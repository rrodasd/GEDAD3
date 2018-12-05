package comun.tag;

import java.util.Iterator;

import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.Tag;
import sagde.bean.BeanClasificacionDocumento;

import comun.DAOFactory;
import comun.FormularDocumentoDAO;

public class ListaClasificacion implements Tag {

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
        BeanClasificacionDocumento beanClasificacion = new BeanClasificacionDocumento();
        try {
            FormularDocumentoDAO objD = objDAOFactory.getFormularDocumentoDAO();
            Iterator iterator = objD.obtenerClasificacion().iterator();
            
            while (iterator.hasNext()) {
                beanClasificacion = (BeanClasificacionDocumento) iterator.next();
                out.println("<option  value=" + beanClasificacion.getCodigo() + ">" + beanClasificacion.getNombre() + "</option>");
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
