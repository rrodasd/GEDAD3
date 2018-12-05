package comun.tag;

import java.io.IOException;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

public class TagRBTipoOrganizacion implements Tag {

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
System.out.println("INGRESO");
        JspWriter out = pagecontext.getOut();
        String aux = pagecontext.getRequest().getParameter("tipoOrg");
        if (aux == null) {
            aux = "G";
        }
        
        System.out.println("INGRESO al Radio Botton"+aux);

        try {
            String radio1 = aux.equals("G") ? "checked" : "";
            String radio2 = aux.equals("E") ? "checked" : "";
            String radio3 = aux.equals("I") ? "checked" : "";

            out.println("<input name=tipo type=radio value=G " + radio1 + " onClick=f_DIS('G')>");
            out.println("Ejercito");
            
            out.println("<input name=tipo type=radio  value=E " + radio2 + " onClick=f_DIS('E')>");
            out.println("Externa");

            out.println("<input name=tipo type=radio  value=I " + radio3 + " onClick=f_DIS('I')>");
            out.println("Interna");

        } catch (IOException e) {
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