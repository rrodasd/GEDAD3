package sagde.revisardoc;
//import static comun.Constante.PATH_PROPERTIES;
import static comun.Constante.PATH_PROPERTIESLOCAL;
import comun.DAOFactory;
import comun.GedadBase;
import comun.RevisaDocumentoDAO;

// Import required java libraries
import java.io.IOException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.List;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import javax.servlet.ServletException;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import pe.mil.ejercito.alfresco_api.commons.AlfrescoProcess;
import pe.mil.ejercito.alfresco_api.commons.PropertiesUtil;
import sagde.comun.OracleDBConn;

import sagde.bean.BeanAnexo;
// Extend HttpServlet class

public class ServletCapturaAnexos_RD extends HttpServlet {

    private Connection getConnection() {
        OracleDBConn cnx = new OracleDBConn();
        return cnx.getConnection();
    }

    /**
     * Al llamar al Servlet se invoca primero al metodo init(), y luego al
     * Metodo Service() Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws javax.servlet.ServletException
     * @throws java.io.IOException
     */
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion").trim();

        if (accion.equals("insertar_anexos")) {
            Grabar_Anexos(request);
        }

    }

    /*
    *Grabar anexos
     */
    public boolean Grabar_Anexos(HttpServletRequest req) {

        DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
        RevisaDocumentoDAO objRD = objDAOFactory.getRevisaDocumentoDAO();

        Connection cnx = null;
        String periodo = "";
        String nro_cod_int = "";
        String nrosec = "";

        try {
            //2. Obtener el Codigo del Documento Interno para guardar en la BD  
            periodo = req.getParameter("periodo");
            nro_cod_int = req.getParameter("cod_interno");
            System.out.println("periodo"+periodo);
                        System.out.println("nro_cod_int"+nro_cod_int);
                        System.out.println("nrosec"+nrosec);
                        

            //3. Obtener la Secuencia segun el Codigo de Docuemnto Interno para guardar en la BD
            nrosec = objRD.generaSecAnexo(periodo, nro_cod_int);

            //4. Retorna la ruta del c deacuerdo al Sistema Operativo para el Temporal
            GedadBase gedadBase = new GedadBase();
            String rutaRaiz = gedadBase.getTemporalFileSystem();

            //5.  Asumiendo servlet 2.x Inicia la lectura del Archivo        
            /*req es la HttpServletRequest que recibimos del formulario.
                   * Los items obtenidos serán cada uno de los campos del formulario,tanto campos normales como ficheros subidos.
             */
            boolean isMultipartForm = ServletFileUpload.isMultipartContent(req);

            if (isMultipartForm) {
                File tempDir = new File(rutaRaiz);
                DiskFileItemFactory fact = new DiskFileItemFactory();
                fact.setRepository(tempDir);
                ServletFileUpload fileUpload = new ServletFileUpload(fact);
                List<FileItem> items = fileUpload.parseRequest(req);
                //6.  Se recorren todos los items, que son de tipo FileItem          

                for (FileItem item : items) {

                    if (!item.isFormField()) {
                        String nameFile = FilenameUtils.getName(item.getName());
                        byte[] bytesArchivo = item.get();

                        //(7). llama a api   import pe.mil.ejercito.alfresco_api.commons.AlfrescoProcess  
                        //PropertiesUtil pUtil = new PropertiesUtil(PATH_PROPERTIES);
                        PropertiesUtil pUtillocal = new PropertiesUtil(PATH_PROPERTIESLOCAL);
                        String contentType = "application/octet-stream";
                        AlfrescoProcess ap = new AlfrescoProcess();
                        String retornoUpload = ap.uploadFile(bytesArchivo, nameFile, contentType, "ARCHIVO SUBIDO DE PASO", "ANEXOS_OFICIO/");

                        //(09)Guardar en la Bd el token y tamb en la base de datos
                        PreparedStatement pcs = null;
                        cnx = getConnection();
                        //FileInputStream streamEntrada1 = new FileInputStream(item.getName());
                        
                        System.out.println("periodo"+periodo);
                        System.out.println("nro_cod_int"+nro_cod_int);
                        System.out.println("nrosec"+nrosec);
                        System.out.println("nameFile"+nameFile);
                        System.out.println("retornoUpload"+retornoUpload);
                        pcs = cnx.prepareStatement("insert into sagde_anexos(CANEXO_PERIODO,CANEXO_COD_DOC_INT,CANEXO_SECUENCIA,VANEXO_NOMBRE,VANEXO_TOKEN) values(?,?,?,?,?)");
                        pcs.setString(1, periodo);
                        pcs.setString(2, nro_cod_int);
                        pcs.setString(3, nrosec);
                        pcs.setString(4, nameFile);
                        pcs.setString(5, retornoUpload);
                        pcs.executeUpdate();
                        cnx.commit();
                    }

                }

            }

        } catch (Exception e) {
            System.out.println("Error de Aplicacion " + e.getMessage());
            return false;
        }

        return true;
    }

}
