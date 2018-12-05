package sagde.borrador;

import sagde.rechazardoc.*;
import sagde.revisardoc.*;
import comun.DAOFactory;
import comun.RevisaDocumentoDAO;
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

public class ListarDocumentosBorrador extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        BeanUsuarioAD objbean = (BeanUsuarioAD) session.getAttribute("usuario");
        if (objbean == null) {
            getServletContext().getRequestDispatcher("/gedad/login/I_Login.jsp").forward(request, response);
        } else {
            DAOFactory objDF = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
            RevisaDocumentoDAO objRD = objDF.getRevisaDocumentoDAO();
            Collection listaPorRevisar = null;
            try {
                String codigoOrganizacion = request.getParameter("cboDependencia");

                if (codigoOrganizacion == null) {
                    codigoOrganizacion = objbean.getCUSUARIO_COD_ORG();
                }
                if (codigoOrganizacion != null) {
                    if (codigoOrganizacion.equals("0000")) {
                        codigoOrganizacion = objbean.getCUSUARIO_COD_ORG();
                    }
                }

                listaPorRevisar = objRD.ObtenerListaDocumentosXRevisar("A", objbean.getVUSUARIO_CODIGO(), codigoOrganizacion);

            } catch (SQLException ex) {
                Logger.getLogger(ListarDocumentosBorrador.class.getName()).log(Level.SEVERE, null, ex);
            }

            getServletContext().getRequestDispatcher("/gedad/borradordoc/I_Borrador.jsp").forward(request, response);
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
