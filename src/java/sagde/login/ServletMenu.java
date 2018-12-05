package sagde.login;

import comun.DAOFactory;
import comun.DecretarDocumentoDAO;
import comun.RevisaDocumentoDAO;
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
import sagde.bean.BeanRevisarDocumento;
import sagde.bean.BeanUsuarioAD;

@SuppressWarnings("serial")
public class ServletMenu extends HttpServlet {

    @Override
    @SuppressWarnings("unchecked")
    public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        BeanUsuarioAD objbean = (BeanUsuarioAD) session.getAttribute("usuario");

        if (objbean == null) {
            getServletContext().getRequestDispatcher("/gedad/login/I_Login.jsp").forward(request, response);
        } else {
            /**
             * Obtener en el Menu principal el numero de documentos :::
             * Pendiente, por Firmar, Rechazados ,etc
             */
            DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
            RevisaDocumentoDAO objRD = objDAOFactory.getRevisaDocumentoDAO();
            DecretarDocumentoDAO objDD = objDAOFactory.getDecretarDocumentoDAO();
            BeanRevisarDocumento objBeanRD;
            BeanRevisarDocumento objBeanRD1;
            BeanRevisarDocumento objBeanRD2;
            BeanRevisarDocumento objBeanRD3;
            int recibidos = 0;
            try {
                objBeanRD = objRD.obtenerCantidadPendientes("C", objbean.getVUSUARIO_CODIGO(), "revisar");
                request.setAttribute("Nro_Pendiente_Revisar", objBeanRD.getNroPendientes());
                objBeanRD1 = objRD.obtenerCantidadPendientes("C", objbean.getVUSUARIO_CODIGO(), "rechazar");
                request.setAttribute("Nro_Pendiente_Rechazar", objBeanRD1.getNroPendientes());
                objBeanRD2 = objRD.obtenerCantidadPendientes("C", objbean.getVUSUARIO_CODIGO(), "firmar");
                request.setAttribute("Nro_Pendiente_Firmar", objBeanRD2.getNroPendientes());
                objBeanRD3 = objRD.obtenerCantidadPendientes("C", objbean.getVUSUARIO_CODIGO(), "borrador");
                request.setAttribute("Nro_Pendiente_Borrador", objBeanRD3.getNroPendientes());
                recibidos = ((ArrayList) objDD.obtenerDocumentos_X_Decretar(objbean.getCUSUARIO_COD_ORG(), objbean.getVUSUARIO_CODIGO())).size();
                request.setAttribute("Nro_Recibidos", recibidos);
            } catch (SQLException ex) {
                Logger.getLogger(ServletMenu.class.getName()).log(Level.SEVERE, null, ex);
            }
            getServletContext().getRequestDispatcher("/gedad/login/I_Menu.jsp").forward(request, response);
        }

    }

}
