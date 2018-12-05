package comun.tag;

import comun.ComboboxDAO;
import java.util.Iterator;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import sagde.bean.BeanAuxiliar;
import sagde.bean.BeanUsuarioAD;

import comun.DAOFactory;

import java.io.IOException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class TagComboUsuarioNivelInferior implements Tag {

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

        try {
            HttpSession session = pagecontext.getSession();
            BeanUsuarioAD beanusuario = (BeanUsuarioAD) session.getAttribute("usuario");
            ComboboxDAO objCombobox = objDAOFactory.getComboboxDAO(); 
             System.out.println("ORGANIZACION DEL LOGUEO ------>"+beanusuario.getCUSUARIO_COD_ORG().trim()+"<---");
            Iterator iterator = objCombobox.obtenerUsuarioNivelInf(beanusuario.getCUSUARIO_COD_ORG().trim()).iterator();
            while (iterator.hasNext()) {
                BeanAuxiliar objBeanAuxiliar = (BeanAuxiliar) iterator.next();
                out.println("<option  value=" + objBeanAuxiliar.getCodigo() + ">" + objBeanAuxiliar.getNombre() + "</option>");
            }
        } catch (IOException e) {
            System.out.println("Error combo " + e.toString());
        } catch (SQLException ex) {
            Logger.getLogger(TagComboUsuarioNivelInferior.class.getName()).log(Level.SEVERE, null, ex);
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