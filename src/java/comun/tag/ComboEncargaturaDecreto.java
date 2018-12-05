package comun.tag;

import java.util.Iterator;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import comun.DAOFactory;
import comun.DecretarDocumentoDAO;
import java.io.IOException;
import java.sql.SQLException;
import sagde.bean.BeanOrganizacionInterna;
import sagde.bean.BeanUsuarioAD;
import sagde.comun.Parametros;

public class ComboEncargaturaDecreto implements Tag {

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
        BeanOrganizacionInterna objBeanOI = new BeanOrganizacionInterna();
        try {
            DecretarDocumentoDAO objDD = objDF.getDecretarDocumentoDAO();
            //recuperamos el codigo de usuario en la session
            HttpSession session = pagecontext.getSession();
            BeanUsuarioAD objBeanUAD = (BeanUsuarioAD) session.getAttribute("usuario");

            Iterator iterator = objDD.obtenerOrganizacionEncargatura(objBeanUAD.getCUSUARIO_COD_ORG(), objBeanUAD.getVUSUARIO_CODIGO()).iterator();

            while (iterator.hasNext()) {
                objBeanOI = (BeanOrganizacionInterna) iterator.next();
                out.println("<option value=" + objBeanOI.getCOINTERNA_CODIGO()+ " >" + objBeanOI.getVOINTERNA_NOM_CORTO()+ "</option>");
            }
        } catch (IOException ex){
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + ex.toString());
        }catch(SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
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