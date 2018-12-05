package comun.tag;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import sagde.bean.BeanUsuarioAD;

import comun.DAOFactory;
import comun.FormularDocumentoDAO;

public class ClaveIndicativoTag implements Tag {

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

            //recuperamos el codigo de usuario en la session
            HttpSession session = pagecontext.getSession();
            BeanUsuarioAD beanusuario = (BeanUsuarioAD) session.getAttribute("usuario");

            //deberia ser el codigo de usario
            String codigoOrganizacion = beanusuario.getCUSUARIO_COD_ORG().trim();

            String clave_indicativo = objD.obtenerClave_IndicativoxUsuario(codigoOrganizacion);

            out.println(clave_indicativo);
            // out.println("<input name=textfield5 type=text value="+guarnicion+"/>");

        } catch (Exception e) {
            System.out.println(e);
        }
        return EVAL_BODY_INCLUDE;
    }

    public int doEndTag() throws JspException {

        return EVAL_PAGE;

    }

    public void release() {

    }

}
