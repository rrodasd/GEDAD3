package comun.tag;

import java.io.IOException;
import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.Tag;

public class BuscarReferenciaTAG2 implements Tag {

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

        JspWriter out = pagecontext.getOut();
        String aux = pagecontext.getRequest().getParameter("org");
        if (aux == null) {
            aux = "I";
        }

        try {
            String ch = aux.equals("E") ? "checked" : "";
            String ch1 = aux.equals("I") ? "checked" : "";
            out.println("<table width=100% border=0>");
            out.println("<tr><td>");
            out.println("<label>");
            out.println("<input name=org type=radio value=I " + ch1 + " onClick=f_ORG()>");
            out.println("Ejercito");
            out.println("</label>");
            out.println("</td></tr><tr><td>");
            out.println("<label>");
            out.println("<input name=org type=radio value=E " + ch + " onClick=f_ORG()>");
            out.println("Externa</label>");
            out.println("</td></tr></table>");

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