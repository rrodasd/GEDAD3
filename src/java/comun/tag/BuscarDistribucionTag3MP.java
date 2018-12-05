package comun.tag;

import java.util.Iterator;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import sagde.bean.BeanOrganizacionInterna;

import comun.DAOFactory;
import comun.DocumentoDAO;
import sagde.bean.BeanUsuarioAD;

public class BuscarDistribucionTag3MP implements Tag {

    PageContext pagecontext;

    public void setPageContext(
            PageContext pagecontext) {
        this.pagecontext = pagecontext;

    }

    public void setParent(Tag arg0) {

    }

    public Tag getParent() {
        return null;
    }

    public int doStartTag() throws JspException {
        DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);

//		System.out.println("doStartTag");
        JspWriter out = pagecontext.getOut();

        HttpSession session = pagecontext.getSession();

        String codigoOrganizacionUsuario = (String) ((BeanUsuarioAD) session.getAttribute("usuario")).getCUSUARIO_COD_ORG();
        String parametro = codigoOrganizacionUsuario.substring(0, 4);

//		System.out.println("coddddddddddddddddddddddddddddddiiiiiiiiiiiiiigggggggggo	"+parametro);
        try {
            // HttpSession session = pagecontext.getSession(); 
            //BeanUsuario beanusuario = (BeanUsuario)session.getAttribute("mensajero");
            DocumentoDAO objOrgI = objDAOFactory.getDocumentoDAO();

            Iterator iteratorOrgI = objOrgI.obtenerOrganizacionEjercito3().iterator();

            //out.println("<option  value=s>- - Elija Opcion - -</option>");
            while (iteratorOrgI.hasNext()) {
                BeanOrganizacionInterna beanorgi = (BeanOrganizacionInterna) iteratorOrgI.next();
                out.println("<option value=" + beanorgi.getCOINTERNA_CODIGO() + ">" + beanorgi.getVOINTERNA_NOM_CORTO() + "</option>");

            }

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
