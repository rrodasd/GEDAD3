package sagde.mantotablas;

import comun.DAOFactory;
import comun.OrganizacionInternaDAO;
import java.io.IOException;
import java.util.Collection;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sagde.bean.BeanUsuarioAD;

@WebServlet(name = "ListarOrganizacionInterna", urlPatterns = {"/listainterna"})
public class ListarOrganizacionInterna extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        DAOFactory objDF = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
        OrganizacionInternaDAO objOI = objDF.getOrganizacionInternaDAO();
        
        try {
            HttpSession session = request.getSession(true);
            BeanUsuarioAD objBeanU = (BeanUsuarioAD) session.getAttribute("usuario");
            Collection listaInterna = objOI.obtenerFullOrgani(objBeanU.getCUSUARIO_COD_ORG().trim());
            request.setAttribute("listaInterna",listaInterna);				
            getServletContext().getRequestDispatcher("/gedad/manto/I_Interna.jsp").forward(request,response);
        } catch (Exception ex) {
            Logger.getLogger(ListarOrganizacionInterna.class.getName()).log(Level.SEVERE, null, ex);
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
        processRequest(request, response);
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
