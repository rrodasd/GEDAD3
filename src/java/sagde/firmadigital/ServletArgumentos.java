/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sagde.firmadigital;

import com.fasterxml.jackson.core.JsonProcessingException;
import comun.Constante;
import comun.StringUtil;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import sagde.firmadigital.commons.FirmaConfiguracion;

/**
 *
 * @author rrodasd
 */
public class ServletArgumentos extends HttpServlet {

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
            out.println("<title>Servlet ServletArgumentos</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ServletArgumentos at " + request.getContextPath() + "</h1>");
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
        processRequest(request, response);
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
        
        // Generando los argumentos para la firma
        generaArgumentos(request, response);
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

    
    /**
     * Permite generar argumentos para la firma digital con reniec por web
     * @param req
     * @param res 
     */
    private void generaArgumentos(HttpServletRequest req, HttpServletResponse res) throws IOException{
        
        
        //System.out.println("en genera argumento ------------------------------------------------------");
        PrintWriter pw = res.getWriter();
        String serverPath =  Constante.SERVER_PATH;
        
        try{
             String documentName = req.getParameter("documentName");
             String nroUnicoDoc = req.getParameter("nroUnicoDoc");
             String orgint_origen = req.getParameter("orgint_origen");
             String nombreanio = req.getParameter("nombreanio");
             String guarnicion = req.getParameter("guarnicion");
             String fecha = req.getParameter("fecha");
             String orgint_redacta = req.getParameter("orgint_redacta");
             String archivo = req.getParameter("archivo");
             String grado_distribucion = req.getParameter("grado_distribucion");
             String cargo_distribucion = req.getParameter("cargo_distribucion");
             String asunto = req.getParameter("asunto");
             String cuerpo = req.getParameter("cuerpo");
             String periodo = req.getParameter("periodo");
             String codigo_gedad = req.getParameter("codigo_gedad");
             
             //System.out.println("nroUnicoDoc*-*-*-*-*-*-*-*-"+nroUnicoDoc);
             
           
             
             
          
            String protocolo = FirmaConfiguracion.getProtocolo(serverPath);
              
            
           //System.out.println("---------argumentos :protocol------"+protocolo+"--serverPath:>"+serverPath+"--documentName:>"+documentName);
        	
            String arguments = FirmaConfiguracion.paramWeb(protocolo, 
                                                            StringUtil.unir(serverPath, 
                                                                            "/repOficioFirmaDigital?orgint_origen="+orgint_origen+
                                                                           "&nombreanio="+nombreanio+
                                                                           "&guarnicion="+guarnicion+
                                                                           "&fecha="+fecha+ 
                                                                           "&periodo="+periodo+ 
                                                                           "&codigo_gedad="+codigo_gedad+ 
                                                                           "&orgint_redacta="+orgint_redacta+
                                                                           "&archivo="+archivo+
                                                                           "&grado_distribucion="+grado_distribucion+
                                                                           "&cargo_distribucion="+cargo_distribucion+
                                                                           "&asunto="+asunto+
                                                                           "&cuerpo="+cuerpo+
                                                                           "&nroUnicoDoc="+nroUnicoDoc
                                                            ), 
                                                            serverPath, 
                                                            documentName);
            pw.write(arguments);
            pw.close();  
        }catch(JsonProcessingException e){
            System.out.println("Error en: "+e.toString());
        }
        
        
    }
    
}
