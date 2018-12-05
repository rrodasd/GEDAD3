package sagde.registrardoc;


import comun.AdjuntarDocumentoDAO;
import comun.DAOFactory;
import comun.PDFDAO;
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
import sagde.bean.BeanDistribucion;


public class ServletVerPDFMP extends HttpServlet {

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
        
        DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
        AdjuntarDocumentoDAO objG = objDAOFactory.getAdjuntarDocumentoDAO();
        
        String periodo = request.getParameter("periodo").trim();
	String cod_int = request.getParameter("docinterno").trim();
	String organiz = request.getParameter("codorg").trim();
		
            
        
        BeanDistribucion objBeanG = new BeanDistribucion();
        objBeanG.setPeriodo(periodo);
        objBeanG.setCodigoDocumento(cod_int);
        objBeanG.setCodigoOrganizacion(organiz);
      
        
        byte[] buffer = objG.obtenerAdjunto(objBeanG);
        BeanDistribucion objbean = objG.obtenerGestion(objBeanG);
          
        String fileName = objbean.getNombre();
        ServletContext context = getServletContext();
       
        // sets MIME type for the file download
        String mimeType = context.getMimeType(fileName);
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
            Logger.getLogger(ServletVerPDFMP.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ServletVerPDFMP.class.getName()).log(Level.SEVERE, null, ex);
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