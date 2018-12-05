/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sagde.decretardoc;

import comun.DAOFactory;
import comun.DecretarDocumentoDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sagde.bean.BeanUsuarioAD;

/**
 *
 * @author rbermudezf
 */
public class ListaDocumentoDecreto extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     * @throws java.sql.SQLException
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        DAOFactory objDF = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
        DecretarDocumentoDAO objDD = objDF.getDecretarDocumentoDAO();

        HttpSession session = request.getSession(true);
        BeanUsuarioAD objBeanUAD = (BeanUsuarioAD) session.getAttribute("usuario");
        if(objBeanUAD==null){
            getServletContext().getRequestDispatcher("/gedad/login/I_Login.jsp").forward(request,response);
        }else{
            Collection listaDocumentoDecreto = objDD.obtenerDocumentos_X_Decretar(objBeanUAD.getCUSUARIO_COD_ORG().trim(),objBeanUAD.getVUSUARIO_CODIGO());
            request.setAttribute("listaDocumentoDecreto",listaDocumentoDecreto);				
            getServletContext().getRequestDispatcher("/gedad/decretardoc/I_Decretado.jsp").forward(request,response);
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
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ListaDocumentoDecreto.class.getName()).log(Level.SEVERE, null, ex);
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
        } catch (SQLException ex) {
            Logger.getLogger(ListaDocumentoDecreto.class.getName()).log(Level.SEVERE, null, ex);
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
