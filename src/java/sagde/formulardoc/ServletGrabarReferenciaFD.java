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
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import pe.mil.ejercito.alfresco_api.commons.AlfrescoProcess;
import pe.mil.ejercito.alfresco_api.commons.PropertiesUtil;
import sagde.comun.OracleDBConn;

import sagde.bean.BeanRegistroDocumento;
import sagde.bean.BeanUsuarioAD;
// Extend HttpServlet class

public class ServletGrabarReferenciaFD extends HttpServlet {

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

        if (accion.equals("insertar_Referencia")) {
            Grabar_Referencia(request, response);
        }

    }

    /*
    *Grabar anexos
     */
    public boolean Grabar_Referencia(HttpServletRequest req, HttpServletResponse response) {

        DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
        FormularDocumentoDAO objFD = objDAOFactory.getFormularDocumentoDAO();
        BeanRegistroDocumento objBeanRegDocumento = new BeanRegistroDocumento();

        //1. Obtener los datos del Registro de MP
        String periodo = req.getParameter("periodo");
        String tipo = req.getParameter("tipo");
        String interna = req.getParameter("interna");
        String clase = req.getParameter("clase");
        String orden = req.getParameter("orden");
        String clave = req.getParameter("clave");
        String fecha = req.getParameter("fecha");
        String asunto = req.getParameter("asunto");
        String clasificacion = req.getParameter("clasificacion");
        String prioridad = req.getParameter("prioridad");

        Connection cnx = null;

        try {
            //2. Obtener el Codigo del Documento Interno para guaradar en la BD  

            HttpSession session = req.getSession(true);
            BeanUsuarioAD objBeanU = (BeanUsuarioAD) session.getAttribute("usuario");
            
            objBeanRegDocumento.setCDOCUMENTO_PERIODO(periodo);
            objBeanRegDocumento.setCDOCUMENTO_TIPO_ORG_ORIG(tipo);
            objBeanRegDocumento.setCDOCUMENTO_COD_ORG_ORIG(interna);
            objBeanRegDocumento.setCDOCUMENTO_CLASE(clase);
            objBeanRegDocumento.setCDOCUMENTO_NRO_ORDEN(orden);
            objBeanRegDocumento.setVDOCUMENTO_CLAVE_INDIC(clave);
            objBeanRegDocumento.setDDOCUMENTO_FECHA(fecha);
            objBeanRegDocumento.setVDOCUMENTO_ASUNTO(asunto);
            objBeanRegDocumento.setCDOCUMENTO_CLASIFICACION(clasificacion);
            objBeanRegDocumento.setCDOCUMENTO_PRIORIDAD(prioridad);
            objBeanRegDocumento.setVDOCUMENTO_USUARIO(objBeanU.getVUSUARIO_CODIGO());
            objBeanRegDocumento.setCOD_ORG_USUARIO(objBeanU.getCUSUARIO_COD_ORG());           
            String codigoInterno = objFD.insertarReferencia(objBeanRegDocumento);
            
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
                        PropertiesUtil pUtillocal = new PropertiesUtil(PATH_PROPERTIESLOCAL);
                        String contentType = "application/octet-stream";
                        AlfrescoProcess ap = new AlfrescoProcess();
                        String retornoUpload = ap.uploadFile(bytesArchivo, nameFile, contentType, "ARCHIVO SUBIDO DE PASO", "REFERENCIA_OFICIO/");

                        //(09)Guardar en la Bd el token y tamb en la base de datos
                        PreparedStatement pcs = null;
                        CallableStatement cs = null;
                        cnx = getConnection();
                        pcs = cnx.prepareStatement("UPDATE SAGDE_DISTRIBUCION set VDISTRIBUCION_NOM_FILE = ? , VDISTRIBUCION_TOKEN = ? WHERE CDISTRIBUCION_PERIODO = ? AND CDISTRIBUCION_COD_DOC_INT = ? AND CDISTRIBUCION_TIPO_ORG = ? AND CDISTRIBUCION_COD_ORG = ?");
                        pcs.setString(1, nameFile);
                        pcs.setString(2, retornoUpload);
                        pcs.setString(3, periodo);
                        pcs.setString(4, codigoInterno);
                        pcs.setString(5, tipo);
                        pcs.setString(6, String.format("%1$-30s", objBeanU.getVUSUARIO_CODIGO()));
                        pcs.executeUpdate();
                        
                        String query = "{call SP_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
                        cs = cnx.prepareCall(query);
                        cs.setString(1, "B");
                        cs.setString(2, objBeanU.getVUSUARIO_CODIGO());
                        cs.setString(3, objBeanU.getCUSUARIO_COD_ORG());
                        cs.setString(4, periodo);
                        cs.setString(5, codigoInterno);
                        cs.setString(6, nameFile);
                        cs.setString(7, retornoUpload);
                        cs.setString(8, "");
                        cs.setString(9, "");
                        cs.setString(10, "");
                        cs.setString(11, "");
                        cs.setString(12, "");
                        cs.setString(13, "");
                        cs.setString(14, "");
                        cs.setString(15, "");
                        cs.setString(16, "");
                        cs.setString(17, "");
                        cs.setString(18, "");
                        cs.setString(19, "");
                        cs.setString(20, "");
                        cs.setString(21, "");
                        cs.executeUpdate();
                    }

                }

            }

        } catch (SQLException e) {
            System.out.println("Error de Aplicacion " + e.getMessage());
            System.out.println("Error " + e.toString());
            return false;
        } catch (FileUploadException eX) {
            System.out.println("Error de Aplicacion " + eX.getMessage());
            System.out.println("Error " + eX.toString());
            return false;
        }

        return true;
    }

}
