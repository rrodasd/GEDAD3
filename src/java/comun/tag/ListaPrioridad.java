package comun.tag;

import java.util.Iterator;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import comun.*;
import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;
import sagde.bean.BeanPrioridadDocumento;

public class ListaPrioridad implements Tag {

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

//		System.out.println("doStartTag");
        JspWriter out = pagecontext.getOut();
        BeanPrioridadDocumento beanPrioridad = new BeanPrioridadDocumento();
        try {
            FormularDocumentoDAO objP = objDAOFactory.getFormularDocumentoDAO();
            Iterator iterator = objP.obtenerPrioridades().iterator();

            //out.println("<select name=select6>");
            while (iterator.hasNext()) {
                beanPrioridad = (BeanPrioridadDocumento) iterator.next();

                out.println("<option  value=" + beanPrioridad.getCodigo() + ">" + beanPrioridad.getNombre() + "</option>");

            }
            //out.println("</select>");
        } catch (IOException e) {
            System.out.println(e);
        } catch (Exception ex) {
            Logger.getLogger(ListaPrioridad.class.getName()).log(Level.SEVERE, null, ex);
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
