package comun.tag;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import sagde.bean.BeanUsuarioAD;

import comun.DAOFactory;
import comun.FormularDocumentoDAO;

public class OrganizacionLugar implements Tag {

    PageContext pagecontext;

    @Override
    public void setPageContext(
            PageContext pagecontext) {
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

        JspWriter out = pagecontext.getOut();

        try {
            FormularDocumentoDAO objD = objDAOFactory.getFormularDocumentoDAO();
            HttpSession session = pagecontext.getSession();
            BeanUsuarioAD beanusuario = (BeanUsuarioAD) session.getAttribute("usuario");
            String codigoOrganizacion = beanusuario.getCUSUARIO_COD_ORG().trim();
            String guarnicion = objD.obtenerOrganizacionLugarxUsuario(codigoOrganizacion);
            session.setAttribute("ses_guarnicion", guarnicion);
            out.println(guarnicion);
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