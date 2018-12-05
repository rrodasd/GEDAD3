/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sagde.firmadigital;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import comun.Constante;
import static comun.Constante.*;
import comun.StringUtil;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import pe.mil.ejercito.alfresco_api.commons.PropertiesUtil;
import sagde.firmadigital.commons.FileUtil;

/**
 *
 * @author rrodasd
 */
public class ServletUpload extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ServletUpload</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ServletUpload at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
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
            subirDocumentoAlresco(request, response);
            
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(ServletUpload.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(ServletUpload.class.getName()).log(Level.SEVERE, null, ex);
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
            subirDocumentoAlresco(request, response);
         
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(ServletUpload.class.getName()).log(Level.SEVERE, null, ex);
        } catch (Exception ex) {
            Logger.getLogger(ServletUpload.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public void  subirDocumentoAlresco(HttpServletRequest req, HttpServletResponse res) throws FileUploadException, UnsupportedEncodingException, Exception {

        if (!ServletFileUpload.isMultipartContent(req)) {
            res.setStatus(HttpServletResponse.SC_PRECONDITION_FAILED);
            return;
        }
          PropertiesUtil pUtillocal = new PropertiesUtil(PATH_PROPERTIESLOCAL);           
          //PropertiesUtil pUtil = new PropertiesUtil(PATH_PROPERTIES);           
        
        ServletFileUpload upload = FileUtil.initServletFileUpload();
        FileUtil.createPathIfNotExist(Constante.GEDAD_TEMP_DIR);
        List<String> filesSaved = FileUtil.saveFiles(upload.parseRequest(req), Constante.GEDAD_TEMP_DIR);
        System.out.println("--------------------**********************************************al alfrescooo---------------------");
        
        if( !filesSaved.isEmpty() ){
             String tokenID = FileUtil.uploadToAlfresco(StringUtil.unir(Constante.GEDAD_TEMP_DIR,
                                                        File.separator,
                                                        filesSaved.get(0)), filesSaved.get(0), "application/pdf", "PDF_FIRMADOS/");
            
            System.out.println("TokenID del archivo subido " + tokenID);
            
                ServletContext session = req.getSession().getServletContext(); // Aplicacion
            session.setAttribute("tokenID_Of", tokenID);            
            System.out.println("manda a session");            
            
          
        }      

        res.setStatus(HttpServletResponse.SC_OK);      
       
        
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

