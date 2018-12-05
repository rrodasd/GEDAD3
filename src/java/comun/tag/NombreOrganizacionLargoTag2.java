package comun.tag;

import java.util.Iterator;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import sagde.bean.BeanOrganizacionInterna;

import comun.DAOFactory;
import comun.FormularDocumentoDAO;
import java.io.IOException;
import java.sql.SQLException;
import sagde.bean.BeanUsuarioAD;

public class NombreOrganizacionLargoTag2 implements Tag {

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
        //BeanOrganizacionInterna beanOrganizacion = new BeanOrganizacionInterna();
        try {
            FormularDocumentoDAO objFD = objDAOFactory.getFormularDocumentoDAO();
            HttpSession session = pagecontext.getSession();
            BeanUsuarioAD objBeanUAD = (BeanUsuarioAD) session.getAttribute("usuario");
            Iterator iterator = objFD.obtenerOrganizacionInternaNombreLargo(objBeanUAD.getVUSUARIO_CODIGO(), "3").iterator();
            while (iterator.hasNext()) {
                BeanOrganizacionInterna beanOrganizacion = (BeanOrganizacionInterna) iterator.next();
                out.println("<option  value=" + beanOrganizacion.getCOINTERNA_CODIGO() + " selected>" + beanOrganizacion.getVOINTERNA_NOM_LARGO() + "</option>");
                //out.println("<option  value=" + beanOrganizacion.getCOINTERNA_CODIGO() + " >" + beanOrganizacion.getVOINTERNA_NOM_LARGO() + "</option>");
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