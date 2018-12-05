package sagde.registrardoc;


import sagde.revisardoc.*;
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
import comun.DocumentoDAO;
import sagde.bean.BeanReferencia;



public class ServletMostrarPDF_MP extends HttpServlet {

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
        
      
        HttpSession sesion=request.getSession();
        response.setContentType("text/html");
        
        DAOFactory objDF = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
        DocumentoDAO objRD = objDF.getDocumentoDAO();

        
        
        String periodo_mp = (String) request.getParameter("periodo_mp");   
        String cod_int = (String) request.getParameter("cod_int"); 
        String tipo_org = (String) request.getParameter("tipo_org");
        String organizacion_jefe = (String) request.getParameter("organizacion_jefe");
        String token = (String) request.getParameter("token");
        
        System.out.println("mOSTAR periodo_mp -"+periodo_mp+"-");
        System.out.println("cod_int-"+cod_int+"-");
        System.out.println("Mostar tipo_org-"+tipo_org+"-");
        System.out.println("Mostar organizacion_jefe-"+organizacion_jefe+"-");
        System.out.println("Mostar token-"+token+"-");

        

  // Estableces la ruta donde se encuentra el properties de la aplicacion
        //PropertiesUtil pUtil = new PropertiesUtil(PATH_PROPERTIES);
        PropertiesUtil pUtil = new PropertiesUtil(PATH_PROPERTIESLOCAL);
         
       
         AlfrescoWebScripts aws = new AlfrescoWebScripts();
        byte[] buffer = aws.getDocument(token);

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
            Logger.getLogger(ServletMostrarPDF_MP.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ServletMostrarPDF_MP.class.getName()).log(Level.SEVERE, null, ex);
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