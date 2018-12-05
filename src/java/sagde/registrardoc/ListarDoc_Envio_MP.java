package sagde.registrardoc;

import java.io.IOException;
import java.util.Collection;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sagde.bean.BeanUsuarioAD;
import comun.DAOFactory;
import comun.DocumentoDAO;

public class ListarDoc_Envio_MP extends HttpServlet {

    @Override
    public void service(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
        DocumentoDAO objDocumentoDAO = objDAOFactory.getDocumentoDAO();
        try {
            HttpSession session = request.getSession(true);
            BeanUsuarioAD beanusuario = (BeanUsuarioAD) session.getAttribute("usuario");
            if (beanusuario == null) {
                getServletContext().getRequestDispatcher("/gedad/login/I_Login.jsp").forward(request, response);
            } else {
                String cod_org_usuario = beanusuario.getCUSUARIO_COD_ORG();
                String cod_org_jefe_unidad = beanusuario.getJEFE_UNIDAD();

                Collection listardocumento = objDocumentoDAO.obtenerFullDocumento(cod_org_usuario, cod_org_jefe_unidad, "Envio");
                request.setAttribute("listardocumento", listardocumento);
                getServletContext().getRequestDispatcher("/gedad/registrardoc/I_Registrar_Documentos.jsp").forward(request, response);
            }

        } catch (Exception e) {
            System.out.println("umm:" + e.getMessage());
        }
    }
}
