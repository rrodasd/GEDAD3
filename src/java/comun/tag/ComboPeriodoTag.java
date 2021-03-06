package comun.tag;

import java.util.Iterator;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

//import sagde.comun.bean.BeanUsuario;
import comun.DAOFactory;
import comun.DocumentoDAO;
import sagde.bean.BeanDocumento1;

public class ComboPeriodoTag implements Tag {

    PageContext pagecontext;

    public void setPageContext(
            PageContext pagecontext) {
        this.pagecontext = pagecontext;
    }

    public void setParent(Tag arg0) {

    }

    public Tag getParent() {
        // TODO Auto-generated method stub
        return null;
    }

    public int doStartTag() throws JspException {
        DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);

        System.out.println("doStartTag");
        JspWriter out = pagecontext.getOut();

        try {
            // HttpSession session = pagecontext.getSession(); 
            //BeanUsuario beanusuario = (BeanUsuario)session.getAttribute("mensajero");

            //PeriodoDAO objPrioridad = objDAOFactory.getComboPeriodoDAO();
            DocumentoDAO objPrioridad = objDAOFactory.getDocumentoDAO();
            //	System.out.println("el valor de la organizacion es "+beanusuario.getCUSUARIO_COD_ORG().trim());
            Iterator iterator = objPrioridad.traeComboPeriodo().iterator();
            //System.out.println("este es el iterietor "+iterator.next().toString());
            while (iterator.hasNext()) {
                BeanDocumento1 objBeanAuxiliar = (BeanDocumento1) iterator.next();
                //System.out.println("este es ekl ben auxiliar"+objBeanAuxiliar);
                out.println("<option  value=" + objBeanAuxiliar.getCodigo() + ">" + objBeanAuxiliar.getCodigo() + "</option>");

            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return EVAL_BODY_INCLUDE;
    }

    public int doEndTag() throws JspException {
        return EVAL_PAGE;
    }

    public void release() {
        // TODO Auto-generated method stub

    }

}
