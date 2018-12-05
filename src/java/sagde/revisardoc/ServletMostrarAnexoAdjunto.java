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
import pe.mil.ejercito.alfresco_api.commons.AlfrescoWebScripts;
import pe.mil.ejercito.alfresco_api.commons.PropertiesUtil;
import sagde.bean.BeanAnexo;

import static comun.Constante.*;
import java.util.Base64;

public class ServletMostrarAnexoAdjunto extends HttpServlet {

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

        response.setContentType("text/html");

        String token = (String) request.getParameter("token");
        String fileName = (String) request.getParameter("archivo");
        System.out.println("token x"+token+"x");
        System.out.println("fileName x"+fileName+"x");
        Base64.Decoder decoder = Base64.getDecoder();
        fileName = new String(decoder.decode(fileName));
        System.out.println("fileName x"+fileName+"x");
        // Estableces la ruta donde se encuentra el properties de la aplicacion
        //PropertiesUtil pUtil = new PropertiesUtil(PATH_PROPERTIES);
        PropertiesUtil pUtil = new PropertiesUtil(PATH_PROPERTIESLOCAL);

        //BeanAnexo bAnexoConsultado = objRD.obtenerAnexoSinBlob(objBeanG);
        AlfrescoWebScripts aws = new AlfrescoWebScripts();
        byte[] buffer = aws.getDocument(token);

        ServletContext context = getServletContext();

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
            Logger.getLogger(ServletMostrarAnexoAdjunto.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ServletMostrarAnexoAdjunto.class.getName()).log(Level.SEVERE, null, ex);
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
