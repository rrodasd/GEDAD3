package comun.tag;

import java.util.Iterator;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import sagde.bean.BeanOrganizacionExterna;
import sagde.bean.BeanOrganizacionInterna;

import comun.DAOFactory;
import comun.FormularDocumentoDAO;

public class BuscarDistribucionTag implements Tag {

    PageContext pagecontext;

    public void setPageContext(
            PageContext pagecontext) {
        this.pagecontext = pagecontext;

    }

    public void setParent(Tag arg0) {

    }

    @Override
    public Tag getParent() {
        return null;
    }

    @Override
    public int doStartTag() throws JspException {
        DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
System.out.println("ingreso a comboooo");
        JspWriter out = pagecontext.getOut();

        String organizacion = pagecontext.getRequest().getParameter("tipo");
        HttpSession session = pagecontext.getSession(); 
        String dato = (String) session.getAttribute("dependencias");
          System.out.println("dato---"+dato);
        String dato2 = dato.substring(0, 2);
        System.out.println("dato2---"+dato2);
        if (organizacion == null) {
            System.out.println("entro");
            organizacion = "G";
        }

        try {
            FormularDocumentoDAO objD = objDAOFactory.getFormularDocumentoDAO();
            if (organizacion.equals("I")) {

                Iterator iteratorOrgI = objD.obtenerOrganizacionInternas(dato).iterator();
                while (iteratorOrgI.hasNext()) {
                    BeanOrganizacionInterna beanorgi = (BeanOrganizacionInterna) iteratorOrgI.next();
                    out.println("<option value=" + beanorgi.getCOINTERNA_CODIGO() + ">" + beanorgi.getVOINTERNA_NOM_CORTO() + "</option>");
                }

            } else if (organizacion.equals("E")) {
                Iterator iteratorOrgE = objD.obtenerOrganizacionExterna().iterator();
                while (iteratorOrgE.hasNext()) {
                    BeanOrganizacionExterna beanorge = (BeanOrganizacionExterna) iteratorOrgE.next();
                    out.println("<option  value=" + beanorge.getCodigo() + ">" + beanorge.getNombre() + "</option>");
                }
            } else if (organizacion.equals("G")) {
                Iterator iteratorOrgI = objD.obtenerOrganizacionEjercito(dato, dato2).iterator();
                while (iteratorOrgI.hasNext()) {
                    BeanOrganizacionInterna beanorgi = (BeanOrganizacionInterna) iteratorOrgI.next();
                    out.println("<option value=" + beanorgi.getCOINTERNA_CODIGO() + ">" + beanorgi.getVOINTERNA_NOM_CORTO() + "</option>");
                }
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

    public void release() {

    }
}