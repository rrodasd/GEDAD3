package comun.tag;

import java.util.Iterator;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import sagde.bean.BeanArchivo;

import comun.DAOFactory;
import comun.FormularDocumentoDAO;

public class ArchivoIndicativoTag implements Tag {

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
        
        DAOFactory objDF = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
        JspWriter out = pagecontext.getOut();
        BeanArchivo beanArchivo = new BeanArchivo();
        try {
            FormularDocumentoDAO objD = objDF.getFormularDocumentoDAO();
            //recuperamos el codigo de usuario en la session
            HttpSession session = pagecontext.getSession();
            String seleccionarchivo = (String) session.getAttribute("archivo");

            Iterator iterator = objD.obtenerArchivoIndicativo().iterator();

            while (iterator.hasNext()) {
                beanArchivo = (BeanArchivo) iterator.next();
                String arch = (beanArchivo.getCARCHIVO_CODIGO().trim().equals(seleccionarchivo)) ? "selected" : "";
                out.println("<option value=" + beanArchivo.getCARCHIVO_CODIGO() + " " + arch + ">" + beanArchivo.getCARCHIVO_CODIGO() + " " + beanArchivo.getVARCHIVO_NOMBRE() + "</option>");
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