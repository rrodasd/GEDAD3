package comun.tag;

import comun.ComboboxDAO;
import java.util.Iterator;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import sagde.bean.BeanUsuarioAD;

import comun.FormularDocumentoDAO;
import comun.DAOFactory;

public class TagRevisadoPor implements Tag {

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
            BeanUsuarioAD beanusuario = (BeanUsuarioAD) session.getAttribute("usuario");

            ComboboxDAO objD = objDAOFactory.getComboboxDAO();

            Iterator iterator = objD.obtenerRevisadorPor(beanusuario.getVUSUARIO_CODIGO()).iterator();
            int contador = 0;
            while (iterator.hasNext()) {
                BeanUsuarioAD bean = (BeanUsuarioAD) iterator.next();
                out.println("<option value=" + bean.getVUSUARIO_CODIGO() + ">" + bean.getVUSUARIO_CARGO() + "</option>");
                contador = contador + 1;
                if (contador == 1) {
                    session.setAttribute("activacion", bean.getVUSUARIO_CODIGO().toString().trim());
                }
            }

        } catch (Exception e) {
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
