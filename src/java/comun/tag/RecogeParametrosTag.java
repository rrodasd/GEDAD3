package comun.tag;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

public class RecogeParametrosTag implements Tag {

    PageContext pagecontext;

    @Override
    public void setPageContext(
            PageContext pagecontext) {
        this.pagecontext = pagecontext;

    }

    @Override
    public Tag getParent() {
        return null;
    }

    @Override
    public int doStartTag() throws JspException {

        //JspWriter out = pagecontext.getOut();

        //reocoger parametros ocultos del formulario de distribucion
        String aux = pagecontext.getRequest().getParameter("oculto1");
        String aux2 = pagecontext.getRequest().getParameter("oculto2");
        String aux3 = pagecontext.getRequest().getParameter("oculto3");
        String aux4 = pagecontext.getRequest().getParameter("oculto4");
        String aux5 = pagecontext.getRequest().getParameter("oculto5");
        String aux6 = pagecontext.getRequest().getParameter("oculto6");
        
    
             
             
        
        //	System.out.println("esto es la auxiliarrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr"+ aux4);

        //recuperar la session 
        HttpSession session = pagecontext.getSession();
       
        session.setAttribute("nombre", aux);
        session.setAttribute("grado", aux2);
        session.setAttribute("cargo", aux3);
        session.setAttribute("tipodistribucion", aux4);
        session.setAttribute("sOrganizacion", aux5);
        session.setAttribute("tipoOrganizacion", aux6);

        return EVAL_BODY_INCLUDE;
    }

    @Override
    public int doEndTag() throws JspException {
        return EVAL_PAGE;

    }

    @Override
    public void release() {

    }

    @Override
    public void setParent(Tag t) {
        
    }

}