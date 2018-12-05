package sagde.login;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.*;

import comun.DAOFactory;
import comun.UsuarioADDAO;
import java.util.logging.Level;
import java.util.logging.Logger;
import sagde.ad.ActiveDirectoryDAO;
import sagde.bean.BeanUsuarioAD;

public class ServletLogin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, Exception {
        response.setContentType("text/html;charset=UTF-8");
        //PrintWriter out = response.getWriter();
        try {
            DAOFactory objDF = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
            UsuarioADDAO objUAD = objDF.getUsuarioADDAO();
            //RevisaDocumentoDAO objRD = objDF.getRevisaDocumentoDAO();

            String sLogin = request.getParameter("txtUsuario");
            String sClave = request.getParameter("txtClave");
            //USO DE ACTIVE DIRECTORY
            ActiveDirectoryDAO objAD = new ActiveDirectoryDAO();
            //boolean accesoO=false,accesoT=false,accesoS=false, accesoE=false;
            boolean accesoO = objAD.loginOFICIALES(sLogin, sClave);
            boolean accesoT = objAD.loginTCOS(sLogin, sClave);
            boolean accesoS = objAD.loginSSOO(sLogin, sClave);
            boolean accesoE = objAD.loginEECC(sLogin, sClave);

            if (accesoO || accesoT || accesoS || accesoE) {
                System.out.println("ingresoo---");
                BeanUsuarioAD objBeanUAD = objUAD.obtenerUsuario(sLogin);
                if (objBeanUAD != null) {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("usuario", objBeanUAD);
                    getServletContext().getRequestDispatcher("/menu").forward(request, response);
                    //getServletContext().getRequestDispatcher("/gedad/login/I_Menu.jsp").forward(request, response);
                } else {
                    request.setAttribute("mensaje", "USUARIO SIN ACCESO A GEDAD!!!");
                    getServletContext().getRequestDispatcher("/gedad/login/I_Login.jsp").forward(request, response);
                }

            } else {
                request.setAttribute("mensaje", "USUARIO O CLAVE INCORRECTA!!!");
                getServletContext().getRequestDispatcher("/gedad/login/I_Login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("mensaje", "CREDENCIAL  NO VALIDA");
            getServletContext().getRequestDispatcher("/gedad/login/I_Login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ServletLogin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (Exception ex) {
            Logger.getLogger(ServletLogin.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
