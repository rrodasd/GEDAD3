package comun.tag;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import sagde.bean.BeanPeriodo;
import comun.DAOFactory;
import comun.FormularDocumentoDAO;
import java.io.IOException;
import java.sql.SQLException;

public class DefinicionPeriodoTag implements Tag {

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

        try {
            FormularDocumentoDAO objFD = objDF.getFormularDocumentoDAO();
            Date fechaActual = new Date();
            SimpleDateFormat formato = new SimpleDateFormat("yyyy");
            String cadenaFecha = formato.format(fechaActual);
            BeanPeriodo objBeanP = objFD.obtenerDefinicionPeriodo(cadenaFecha);
            String definicion = objBeanP.getVPERIODO_DEFINICION();
            out.println(definicion);
        } catch (IOException | SQLException e) {
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