package comun.tag;

import java.util.Iterator;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import sagde.bean.BeanOrganizacionInterna;
import sagde.bean.BeanUsuarioAD;

import comun.DAOFactory;
import comun.FormularDocumentoDAO;

public class NombreOrganizacionLargoTag implements Tag {

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

        JspWriter out = pagecontext.getOut();

        BeanOrganizacionInterna beanOrganizacion = new BeanOrganizacionInterna();

        try {
            FormularDocumentoDAO objD = objDAOFactory.getFormularDocumentoDAO();
            //recuperamos el codigo de usuario en la session
            HttpSession session = pagecontext.getSession();
            BeanUsuarioAD beanusuario = (BeanUsuarioAD) session.getAttribute("usuario");
            String nivel = "1";
            //deberia ser el codigo de usario
            String codigoUsuario = beanusuario.getVUSUARIO_CODIGO();
            Iterator iterator = objD.obtenerOrganizacionInternaNombreLargo(codigoUsuario, nivel).iterator();

            while (iterator.hasNext()) {
                beanOrganizacion = (BeanOrganizacionInterna) iterator.next();
                out.println(beanOrganizacion.getVOINTERNA_NOM_LARGO());
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
