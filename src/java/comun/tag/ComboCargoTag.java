package comun.tag;

import java.util.Iterator;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import comun.DAOFactory;
import comun.FormularDocumentoDAO;
import java.io.IOException;
import java.sql.SQLException;
import sagde.bean.BeanUsuarioAD;

public class ComboCargoTag implements Tag {

    PageContext pagecontext;

    @Override
    public void setPageContext(PageContext pagecontext) {
        this.pagecontext = pagecontext;
    }

    @Override
    public void setParent(Tag arg0) {

    }

    @Override
    public Tag getParent() {
        return null;
    }

    @Override
    public int doStartTag() throws JspException {
        DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);

//		System.out.println("doStartTag");
        JspWriter out = pagecontext.getOut();

        try {
            HttpSession session = pagecontext.getSession();
            BeanUsuarioAD objBeanUAD = (BeanUsuarioAD) session.getAttribute("usuario");

            FormularDocumentoDAO objD = objDAOFactory.getFormularDocumentoDAO();
            Iterator iterator = objD.obtenerUsuariosxNiveles(objBeanUAD.getCUSUARIO_COD_ORG(), "R").iterator();
            //int contador = 0;
            while (iterator.hasNext()) {
                BeanUsuarioAD bean = (BeanUsuarioAD) iterator.next();
                out.println("<option value=" + bean.getVUSUARIO_CODIGO() + ">" + bean.getVUSUARIO_CARGO() + "</option>");
                /*contador = contador + 1;
                if (contador == 1) {
                    session.setAttribute("activacion", bean.getVUSUARIO_CODIGO().trim());
                }*/
            }

        } catch (IOException | SQLException e) {
            System.out.println(e);
        }
        return EVAL_BODY_INCLUDE;

    }

    @Override
    public int doEndTag() throws JspException {
        return EVAL_PAGE;

    }

    @Override
    public void release() {

    }

}
