package sagde.registrardoc;
//import static comun.Constante.PATH_PROPERTIES;
import static comun.Constante.PATH_PROPERTIESLOCAL;
import comun.DAOFactory;
import comun.DocumentoDAO;
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
import java.util.Base64;
import javax.servlet.ServletException;
import javax.servlet.http.HttpSession;


import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import pe.mil.ejercito.alfresco_api.commons.AlfrescoProcess;
import pe.mil.ejercito.alfresco_api.commons.PropertiesUtil;
import sagde.comun.OracleDBConn;


import sagde.bean.BeanAnexo;
import sagde.bean.BeanDistribucion;
import sagde.bean.BeanRegistroDocumento;
import sagde.bean.BeanUsuarioAD;
// Extend HttpServlet class
public class ServletGrabaMP extends HttpServlet{
	
    
     private Connection getConnection() {
        OracleDBConn cnx = new OracleDBConn();
        return cnx.getConnection();
    }
/** Al llamar al Servlet se invoca primero al metodo init(), y luego al Metodo Service()
      * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
*/
    protected void service(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException { 
      
  String accion = request.getParameter("accion").trim();  
  
        System.out.println("accion------------------------------entrooo-"+accion);
    
        if (accion.equals("eliminar_anexos")) {
            //Eliminar(request, response);
        }

        if (accion.equals("actualizar_anexos")) {
            Actualizar_Anexos(request);
        }

        if (accion.equals("insertar_MP")) {
             Grabar_Anexos(request,response);
        }

         if (accion.equals("mostar_anexos")) {
             //grabar_anexos(request);
        }
      
      
    
    	
    }
    
    /*
    *Grabar anexos
    */
    public boolean Grabar_Anexos(HttpServletRequest req,HttpServletResponse response) {
        
        DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
        DocumentoDAO objDocumentoDAO = objDAOFactory.getDocumentoDAO();
        RevisaDocumentoDAO objRD = objDAOFactory.getRevisaDocumentoDAO();
        BeanRegistroDocumento objBeanRegDocumento = new BeanRegistroDocumento();
        Base64.Decoder decoder = Base64.getDecoder();
        //1. Obtener los datos del Registro de MP
       String cbo_Periodo = req.getParameter("cbo_Periodo"); 
       String cbo_Tipo_Organizacion = req.getParameter("cbo_Tipo_Organizacion");
       String org = req.getParameter("org"); 
       String cbx_Clase_Doc = req.getParameter("cbx_Clase_Doc"); 
       String txt_Nro_Orden = req.getParameter("txt_Nro_Orden");
       String txt_Clave_Indic = req.getParameter("txt_Clave_Indic"); 
       String txt_fecha_MP = req.getParameter("txt_fecha_MP"); 
       String txt_Asunto_MP = req.getParameter("txt_Asunto_MP"); 
         txt_Asunto_MP = new String(decoder.decode(txt_Asunto_MP));
       
       String cbx_tipo_distri = req.getParameter("cbx_tipo_distri"); 
       String cbx_Prioridad = req.getParameter("cbx_Prioridad"); 
    
        Connection cnx = null;     
    	File fichero =null;      
        String nrosec = null;
        
    	try {
        //2. Obtener el Codigo del Documento Interno para guaradar en la BD  
         
        HttpSession session = req.getSession(true);
        BeanUsuarioAD beanusuario = (BeanUsuarioAD)session.getAttribute("usuario");				
	String usuario = beanusuario.getVUSUARIO_CODIGO().trim();
        String cod_org_usuario = beanusuario.getCUSUARIO_COD_ORG();
        String cod_jefe_unidad = beanusuario.getJEFE_UNIDAD();
        
        
        
        System.out.println("cbo_Periodo  : " + cbo_Periodo);
        System.out.println("cbo_Tipo_Organizacion  : " + cbo_Tipo_Organizacion);
        System.out.println("org  : " + org);
        System.out.println("cbx_Clase_Doc  : " + cbx_Clase_Doc);
        System.out.println("txt_Nro_Orden  : " + txt_Nro_Orden);
        System.out.println("txt_Clave_Indic  : " + txt_Clave_Indic);
        System.out.println("txt_fecha_MP  : " + txt_fecha_MP);
        System.out.println("txt_Asunto_MP  : " + txt_Asunto_MP);
        System.out.println("cbx_tipo_distri  : " + cbx_tipo_distri);
        System.out.println("cbx_Prioridad  : " + cbx_Prioridad);
        System.out.println("usuario  : " + usuario);
        System.out.println("cod_org_usuario  : " + cod_org_usuario);
        System.out.println("cod_jefe_unidad  : " + cod_jefe_unidad);
       
        
        
        objBeanRegDocumento.setCDOCUMENTO_PERIODO(cbo_Periodo);
        objBeanRegDocumento.setCDOCUMENTO_TIPO_ORG_ORIG(cbo_Tipo_Organizacion);
        objBeanRegDocumento.setCDOCUMENTO_COD_ORG_ORIG(org);			
        objBeanRegDocumento.setCDOCUMENTO_CLASE(cbx_Clase_Doc);
        objBeanRegDocumento.setCDOCUMENTO_NRO_ORDEN(txt_Nro_Orden);
        objBeanRegDocumento.setVDOCUMENTO_CLAVE_INDIC(txt_Clave_Indic);
        objBeanRegDocumento.setDDOCUMENTO_FECHA(txt_fecha_MP);
        objBeanRegDocumento.setVDOCUMENTO_ASUNTO(txt_Asunto_MP);
        objBeanRegDocumento.setCDISTRIBUCION_TIPO_DISTRIB(cbx_tipo_distri);
        objBeanRegDocumento.setCDOCUMENTO_PRIORIDAD(cbx_Prioridad);        
        objBeanRegDocumento.setVDOCUMENTO_GUARNICION("San Borja");			
        objBeanRegDocumento.setVDOCUMENTO_USUARIO(usuario);
        objBeanRegDocumento.setCOD_ORG_USUARIO(cod_org_usuario);
        objBeanRegDocumento.setJEFE_UNIDAD(cod_jefe_unidad);

        String codigoInterno=objDocumentoDAO.insertarDocRegistrado_MP(objBeanRegDocumento);    
        //System.out.println("codigoInterno codigoInternocodigoInternocodigoInternocodigoInterno : " + codigoInterno);
           
    
//4. Retorna la ruta del c deacuerdo al Sistema Operativo para el Temporal
        GedadBase gedadBase = new GedadBase();
        String rutaRaiz = gedadBase.getTemporalFileSystem();           
           
         
        //5.  Asumiendo servlet 2.x Inicia la lectura del Archivo        
                /*req es la HttpServletRequest que recibimos del formulario.
                   * Los items obtenidos serán cada uno de los campos del formulario,tanto campos normales como ficheros subidos.
                   */
       

            boolean isMultipartForm = ServletFileUpload.isMultipartContent(req);
            
            if( isMultipartForm ){                
                File tempDir = new File(rutaRaiz);
                DiskFileItemFactory fact = new DiskFileItemFactory();
                fact.setRepository(tempDir);                
                ServletFileUpload fileUpload = new ServletFileUpload(fact);                     
                List<FileItem> items = fileUpload.parseRequest(req);                
                //6.  Se recorren todos los items, que son de tipo FileItem          
                
                for (FileItem item : items) {  
                 
                    if( !item.isFormField() ){
                       // System.out.println( String.format("\tArchivo encontrado %s - %d Kb", item.getName(), item.getSize()/1024 ) );                                          
                        String nameFile = FilenameUtils.getName(item.getName());                       
                        byte[]  bytesArchivo =item.get();
                         //(7). llama a api   import pe.mil.ejercito.alfresco_api.commons.AlfrescoProcess  
                        //PropertiesUtil pUtil = new PropertiesUtil(PATH_PROPERTIES);
                        PropertiesUtil pUtillocal = new PropertiesUtil(PATH_PROPERTIESLOCAL);                            
                        String contentType = "application/octet-stream";          
                        AlfrescoProcess ap = new AlfrescoProcess();                         
                        String retornoUpload = ap.uploadFile(bytesArchivo, nameFile, contentType,"ARCHIVO SUBIDO DE PASO", "ANEXOS_OFICIO/");
                      
                    //(09)Guardar en la Bd el token y tamb en la base de datos

                            PreparedStatement pcs = null;
                            BeanDistribucion objBeanDistri = null;
                            cnx = getConnection();
                            //FileInputStream streamEntrada1 = new FileInputStream(item.getName());
                            objBeanDistri = new BeanDistribucion();
                            objBeanDistri.setImagen(nameFile);
                           
                        System.out.println("tokenid---"+retornoUpload);
                        System.out.println("bjBeanDistri.getImagen()  : " + objBeanDistri.getImagen());
                        System.out.println("cbo_Periodo  : " + cbo_Periodo);
                        System.out.println("codigoInterno  : " + codigoInterno);
                        System.out.println("cbo_Tipo_Organizacion  : " + cbo_Tipo_Organizacion);
                        System.out.println("cod_jefe_unidad  : " + String.format("%1$-30s", cod_jefe_unidad)+ "---");
                        
                            
                           // objBeanAN.setBANEXO_IMAGEN_ARCHIVO(streamEntrada1);
                            pcs = cnx.prepareStatement("UPDATE SAGDE_DISTRIBUCION set VDISTRIBUCION_NOM_FILE = ? , VDISTRIBUCION_TOKEN = ? WHERE CDISTRIBUCION_PERIODO = ? AND CDISTRIBUCION_COD_DOC_INT = ? AND CDISTRIBUCION_TIPO_ORG = ? AND CDISTRIBUCION_COD_ORG = ?");
                            pcs.setString(1, objBeanDistri.getImagen());
                            pcs.setString(2, retornoUpload);
                            pcs.setString(3, cbo_Periodo);
                            pcs.setString(4, codigoInterno);
                            pcs.setString(5, cbo_Tipo_Organizacion);
                            pcs.setString(6, String.format("%1$-30s", cod_jefe_unidad));
                            pcs.executeUpdate();
                            cnx.commit();
                            
                            System.out.println("ingreso el tokennn  nnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn: ");
                            
                            
                    }
                    
                }
                
            }
           /* 
            Collection listardocumento = objDocumentoDAO.obtenerFullDocumento(cod_org_usuario,cod_jefe_unidad);
              
            int nroFilas = listardocumento.size();
            System.out.println("nroFilasnroFilasnroFilas--"+nroFilas);
            
            session.setAttribute("listardocumento", listardocumento);
           
           getServletContext().getRequestDispatcher("/gedad/registrardoc/I_Registrar_Documentos.jsp").forward(req, response);
        */
       }         
           
        catch(Exception e) {
             System.out.println("Error de Aplicacion " + e.getMessage());
            return false;
        }

        return true;
    }

   

    
    
     public boolean Actualizar_Anexos(HttpServletRequest req) {
                 
        DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
        RevisaDocumentoDAO objRD = objDAOFactory.getRevisaDocumentoDAO();
        
    
        //Capturar Variables
        
        String periodo = req.getParameter("periodo_anexo");
        String cod_docinterno = req.getParameter("cod_interno");
        String secuencia = req.getParameter("sec_anexos");
        
        System.out.println("1.--periodo"+periodo+"cod_docinterno"+cod_docinterno+"secuencia"+secuencia);  
        Connection cnx = null;
     
    	File fichero =null;     
        
    	try {           
           
    //4. Retorna la ruta del c deacuerdo al Sistema Operativo
            GedadBase gedadBase = new GedadBase();
            String rutaRaiz = gedadBase.getTemporalFileSystem();        
          
    //5.  Asumiendo servlet 2.x Inicia la lectura del Archivo        
                /*req es la HttpServletRequest que recibimos del formulario.
                   * Los items obtenidos serán cada uno de los campos del formulario,tanto campos normales como ficheros subidos.
                   */
                
            boolean isMultipartForm = ServletFileUpload.isMultipartContent(req);
            
            if( isMultipartForm ){                
                File tempDir = new File(rutaRaiz);
                DiskFileItemFactory fact = new DiskFileItemFactory();
                fact.setRepository(tempDir);
                
                ServletFileUpload fileUpload = new ServletFileUpload(fact);           
                List<FileItem> items = fileUpload.parseRequest(req);
                
   //6.  Se recorren todos los items, que son de tipo FileItem    
                for (FileItem item : items) {                    
                    if( !item.isFormField() ){
                        System.out.println( String.format("\tArchivo encontrado %s - %d Kb", item.getName(), item.getSize()/1024 ) );                       
                        //Se obtiene el Nombre del Archivo
                        String nameFile = FilenameUtils.getName(item.getName());  
                        byte[]  bytesArchivo =item.get();
                      
                        
                         //PropertiesUtil pUtil = new PropertiesUtil(PATH_PROPERTIES);
                        PropertiesUtil pUtillocal = new PropertiesUtil(PATH_PROPERTIESLOCAL);    
                        
                        String contentType = "application/octet-stream";          
                        AlfrescoProcess ap = new AlfrescoProcess();                         
                        String retornoUpload = ap.uploadFile(bytesArchivo, nameFile, contentType,"ARCHIVO SUBIDO DE PASO", "ANEXOS_OFICIO/");
                       // Create session
    //Session session = getSession(, username, password); 
                    
   //7. Eliminara en el alfreso 
       
       BeanAnexo objBeanG = new BeanAnexo();
       objBeanG.setCANEXO_PERIODO(periodo);
       objBeanG.setCANEXO_COD_DOC_INT(cod_docinterno);
       objBeanG.setCANEXO_SECUENCIA(secuencia);
       objBeanG.setVANEXO_NOMBRE(nameFile);
       BeanAnexo bAnexoConsultado = objRD.obtenerAnexoSinBlob(objBeanG);
       String idtoken=bAnexoConsultado.getVANEXO_TOKEN();
       System.out.println("Obtengo el Token ID de la base de datos -"+idtoken);
       byte[] bytestoken;  
       bytestoken = ap.obtenerBytes(idtoken);
      // CmisObject obj=
       
      PreparedStatement pcs = null;
      BeanAnexo objBeanAN = null;
      cnx = getConnection();
       //FileInputStream streamEntrada1 = new FileInputStream(item.getName());
      objBeanAN = new BeanAnexo();
      objBeanAN.setVANEXO_NOMBRE(nameFile);
                        // objBeanAN.setBANEXO_IMAGEN_ARCHIVO(streamEntrada1);
      pcs = cnx.prepareStatement("UPDATE sagde_anexos set VANEXO_NOMBRE = ?, VANEXO_TOKEN = ? where CANEXO_PERIODO = ? AND CANEXO_COD_DOC_INT = ? AND CANEXO_SECUENCIA = ?");
      pcs.setString(1, objBeanAN.getVANEXO_NOMBRE());
      pcs.setString(2, retornoUpload);
      pcs.setString(3, periodo);
      pcs.setString(4, cod_docinterno);
      pcs.setString(5, secuencia);
      pcs.executeUpdate();
      cnx.commit();

        
         
   
                          
                    }
                    
                }
                
            }
            
    
          
        }         
           
        catch(Exception e) {
             System.out.println("Error de Aplicacion " + e.getMessage());
            return false;
        }

        return true;
    }
    
  
  
}
