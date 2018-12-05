package sagde.formulardoc;

import comun.DAOFactory;
import comun.FormularDocumentoDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
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
public class ServletFormularDocumento extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession(true);
        BeanUsuarioAD objBeanUAD = (BeanUsuarioAD) session.getAttribute("usuario");
        if (objBeanUAD == null) {
            getServletContext().getRequestDispatcher("/gedad/login/I_Login.jsp").forward(request, response);
        } else {
            String ruta = (String) request.getParameter("txh_ruta");
            if (ruta == null) {
                getServletContext().getRequestDispatcher("/gedad/formulardoc/I_FormularDocumento.jsp").forward(request, response);
            } else {
                DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
                FormularDocumentoDAO objFD = objDAOFactory.getFormularDocumentoDAO();
                ArrayList referencia = (ArrayList) objFD.listarReferenciaTemporal(objBeanUAD.getVUSUARIO_CODIGO(), objBeanUAD.getCUSUARIO_COD_ORG());
                ArrayList anexos = (ArrayList) objFD.listarAnexoTemporal(objBeanUAD.getVUSUARIO_CODIGO(), objBeanUAD.getCUSUARIO_COD_ORG());
                session.setAttribute("referencia", referencia);
                session.setAttribute("anexo", anexos);
                getServletContext().getRequestDispatcher(ruta).forward(request, response);
            }

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
            Logger.getLogger(ServletFormularDocumento.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ServletFormularDocumento.class.getName()).log(Level.SEVERE, null, ex);
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
