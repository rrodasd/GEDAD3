package sagde.formulardoc;

import static comun.Constante.PATH_PROPERTIESLOCAL;
import comun.DAOFactory;
import comun.FormularDocumentoDAO;
import comun.GedadBase;

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
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import pe.mil.ejercito.alfresco_api.commons.AlfrescoProcess;
import pe.mil.ejercito.alfresco_api.commons.PropertiesUtil;
import sagde.comun.OracleDBConn;

import sagde.bean.BeanDistribucion;
import sagde.bean.BeanTemporal;
import sagde.bean.BeanUsuarioAD;
// Extend HttpServlet class

public class ServletGrabarAnexoFD extends HttpServlet {

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

        if (accion.equals("insertar_Anexo")) {
            Grabar_Anexo(request, response);
        }

    }

    /*
    *Grabar anexos
     */
    public boolean Grabar_Anexo(HttpServletRequest req, HttpServletResponse response) {

        DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
        FormularDocumentoDAO objFD = objDAOFactory.getFormularDocumentoDAO();
        
        BeanTemporal objBeanT = new BeanTemporal();
        Connection cnx = null;

        try {
            //2. Obtener el Codigo del Documento Interno para guaradar en la BD  

            HttpSession session = req.getSession(true);
            BeanUsuarioAD objBeanU = (BeanUsuarioAD) session.getAttribute("usuario");
            
            objBeanT.setVTEMP_USUARIO(objBeanU.getVUSUARIO_CODIGO());
            objBeanT.setCTEMP_CODORG(objBeanU.getCUSUARIO_COD_ORG());

            String codigoInterno = objFD.insertarAnexoTemporal(objBeanT);
            
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
                        String retornoUpload = ap.uploadFile(bytesArchivo, nameFile, contentType, "ARCHIVO SUBIDO DE PASO", "ANEXO_OFICIO/");

                        //(09)Guardar en la Bd el token y tamb en la base de datos
                        PreparedStatement pcs = null;
                        BeanDistribucion objBeanDistri = null;
                        cnx = getConnection();
                        //FileInputStream streamEntrada1 = new FileInputStream(item.getName());
                        objBeanDistri = new BeanDistribucion();
                        objBeanDistri.setImagen(nameFile);

                        pcs = cnx.prepareStatement("UPDATE SAGDE_TEMPORAL set VTEMP_NOMBRE = ? , VTEMP_TOKEN = ? WHERE VTEMP_USUARIO = ? AND CTEMP_CODORG = ? AND CTEMP_TIPO = 'A' AND CTEMP_SECUENCIA = ?");
                        pcs.setString(1, objBeanDistri.getImagen());
                        pcs.setString(2, retornoUpload);
                        pcs.setString(3, objBeanU.getVUSUARIO_CODIGO());
                        pcs.setString(4, objBeanU.getCUSUARIO_COD_ORG());
                        pcs.setString(5, codigoInterno);
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
