package sagde.revisardoc;


import comun.DAOFactory;
import comun.RevisaDocumentoDAO;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import pe.mil.ejercito.alfresco_api.commons.AlfrescoWebScripts;


import pe.mil.ejercito.alfresco_api.commons.PropertiesUtil;
import sagde.bean.BeanAnexo;



import static comun.Constante.*;
import sagde.bean.BeanReferencia;



public class ServletMostrarReferencia extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    
    private static final int BUFFER_SIZE = 4096;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, Exception {
        
        System.out.println("entraaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa -");
        HttpSession sesion=request.getSession();
        response.setContentType("text/html");
        
        DAOFactory objDF = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
        RevisaDocumentoDAO objRD = objDF.getRevisaDocumentoDAO();
       
      
        String periodo_origen = (String) request.getParameter("periodo_origen");   
        String cod_int_origen = (String) request.getParameter("cod_int_origen"); 
        String periodo_ref = (String) request.getParameter("periodo_ref");
        String cod_int_ref = (String) request.getParameter("cod_int_ref");
        System.out.println("mOSTAR periodo -"+periodo_origen+"-");
        System.out.println("Mostarcod_docinterno-"+cod_int_origen+"-");
        System.out.println("Mostar secuencia-"+periodo_ref+"-");
        System.out.println("Mostar nombre_archivo-"+cod_int_ref+"-");

        BeanReferencia objBeanG = new BeanReferencia();
        objBeanG.setCREFERENCIA_PERIODO_ORIG(periodo_origen);
        objBeanG.setCREFERENCIA_COD_DOC_ORIG(cod_int_origen);
        objBeanG.setCREFERENCIA_PERIODO_REF(periodo_ref);
        objBeanG.setCREFERENCIA_COD_DOC_REF(cod_int_ref);


  // Estableces la ruta donde se encuentra el properties de la aplicacion
        //PropertiesUtil pUtil = new PropertiesUtil(PATH_PROPERTIES);
        PropertiesUtil pUtil = new PropertiesUtil(PATH_PROPERTIESLOCAL);
         
        BeanReferencia ReferenciaConsultado = objRD.obtenerReferenciaSinBlob(objBeanG);
         System.out.println("ReferenciaConsultado.getVANEXO_TOKEN() -"+ReferenciaConsultado.getVDISTRIBUCION_TOKEN());
         AlfrescoWebScripts aws = new AlfrescoWebScripts();
        byte[] buffer = aws.getDocument(ReferenciaConsultado.getVDISTRIBUCION_TOKEN());

        ServletContext context = getServletContext();
        
        String fileName="referencia.pdf";

         String mimeType = context.getMimeType(fileName);
        System.out.println("mimeType -"+mimeType+"-");
        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }   
        // set content properties and header attributes for the response
        response.setContentType(mimeType);
        String headerKey = "Content-Disposition";
        String headerValue = String.format("inline; filename=\"%s\"", fileName);
        response.setHeader(headerKey, headerValue);
        
        // writes the file to the client
        
        ServletOutputStream out2 = response.getOutputStream();
//PrintWriter out2 = response.getWriter();


        out2.write(buffer);

        
        
        
        
  
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ServletMostrarReferencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ServletMostrarReferencia.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}