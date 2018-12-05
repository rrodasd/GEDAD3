package comun.tag;

import comun.ComboboxDAO;
import java.util.Iterator;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import sagde.bean.BeanOrganizacionInterna;
import sagde.bean.BeanUsuarioAD;

import comun.DAOFactory;

public class TagComboOrganizacionCabecera implements Tag {

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
        BeanOrganizacionInterna beanOrganizacion = new BeanOrganizacionInterna();
        try {

            ComboboxDAO objCombobox = objDAOFactory.getComboboxDAO();
            HttpSession session = pagecontext.getSession();
            BeanUsuarioAD beanusuario = (BeanUsuarioAD) session.getAttribute("usuario");
            //El Ajax I_PorReviasar_ajax manda el Codigo de la Organizacion de la Cebecera  por session 
            String viene_cod_orga_cabecera = (String) session.getAttribute("cod_org_cabecera");
            String selecciondependencia = "";
            if(viene_cod_orga_cabecera!=null){
                selecciondependencia = viene_cod_orga_cabecera.trim();
            }

            String nivel = "3";
            String codigoUsuario = beanusuario.getVUSUARIO_CODIGO();
            Iterator iterator = objCombobox.obtenerOrganizacionInternaNombreLargo(codigoUsuario, nivel).iterator();
            while (iterator.hasNext()) {
                beanOrganizacion = (BeanOrganizacionInterna) iterator.next();
                String org = (beanOrganizacion.getCOINTERNA_CODIGO().trim().equals(selecciondependencia)) ? "selected" : "";
                out.println("<option  value=" + beanOrganizacion.getCOINTERNA_CODIGO() + " " + org + ">" + beanOrganizacion.getVOINTERNA_NOM_LARGO() + "</option>");
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
