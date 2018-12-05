package sagde.mantotablas;

import comun.DAOFactory;
import comun.EncargaturaDAO;
import comun.UsuarioADDAO;
import java.io.IOException;
import java.util.Collection;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sagde.bean.BeanEncargatura;
import sagde.bean.BeanUsuarioAD;

public class ListarUsuario extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        try {
            DAOFactory objDF = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
            UsuarioADDAO objUAD = objDF.getUsuarioADDAO();
            EncargaturaDAO objE = objDF.getEncargaturaDAO();
            HttpSession session = request.getSession(true);
            BeanUsuarioAD objBeanUAD = (BeanUsuarioAD) session.getAttribute("usuario");
            if (objBeanUAD == null) {
                getServletContext().getRequestDispatcher("/gedad/login/I_Login.jsp").forward(request, response);
            } else {
                BeanEncargatura objBeanE = new BeanEncargatura();
                objBeanE.setCENCARGATURA_COD_ORG_ENC(objBeanUAD.getCUSUARIO_COD_ORG());
                objBeanE.setVENCARGATURA_USUARIO(objBeanUAD.getVUSUARIO_CODIGO());
                objBeanE.setCENCARGATURA_TIPO("A");
                String codOrgEnc = objE.obtenerCodigoEncargaturaxTipo(objBeanE);

                if (codOrgEnc == null) {
                    getServletContext().getRequestDispatcher("/menu").forward(request, response);
                } else {
                    Collection listaUsuario = objUAD.listarUsuario(codOrgEnc);
                    request.setAttribute("listaUsuario", listaUsuario);
                    request.setAttribute("codOrgEnc", codOrgEnc);
                    getServletContext().getRequestDispatcher("/gedad/manto/I_Usuario.jsp").forward(request, response);
                }
            }
        } catch (Exception ex) {
            Logger.getLogger(ListarUsuario.class.getName()).log(Level.SEVERE, null, ex);
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
