package comun.tag;

import java.util.Iterator;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import sagde.bean.BeanAuxiliar;
import sagde.bean.BeanUsuarioAD;

import comun.DAOFactory;
import comun.OrganizacionInternaDAO;

public class ComboUsuarioInf implements Tag {

    PageContext pagecontext;

    @Override
    public void setPageContext(PageContext pagecontext) {
        this.pagecontext = pagecontext;

    }

    @Override
    public void setParent(Tag arg0) {
        // TODO Auto-generated method stub

    }

    @Override
    public Tag getParent() {
        // TODO Auto-generated method stub
        return null;
    }

    @Override
    public int doStartTag() throws JspException {
        DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);

        JspWriter out = pagecontext.getOut();

        try {
            HttpSession session = pagecontext.getSession();
            BeanUsuarioAD beanusuario = (BeanUsuarioAD) session.getAttribute("usuario");

            OrganizacionInternaDAO objOI = objDAOFactory.getOrganizacionInternaDAO();

            Iterator iterator = objOI.obtenerUsuariosxNivelInf(beanusuario.getCUSUARIO_COD_ORG().trim()).iterator();

            while (iterator.hasNext()) {
                BeanAuxiliar objBeanAuxiliar = (BeanAuxiliar) iterator.next();
                out.println("<option  value=" + objBeanAuxiliar.getCodigo() + ">" + objBeanAuxiliar.getCodigo() + "</option>");
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return EVAL_BODY_INCLUDE;
    }

    @Override
    public void release() {
        // TODO Auto-generated method stub

    }

    @Override
    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }

}