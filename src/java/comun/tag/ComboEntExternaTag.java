package comun.tag;

import java.util.Iterator;

import javax.servlet.http.HttpSession;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;


import sagde.bean.BeanUsuarioAD;

import comun.DAOFactory;
import comun.DocumentoDAO;
import sagde.bean.BeanDocumento1;



public class ComboEntExternaTag  implements Tag{
	PageContext pagecontext;
	public void setPageContext(
			PageContext pagecontext) {
		this.pagecontext=pagecontext;		
	}

	public void setParent(Tag arg0) {		
		
	}

	public Tag getParent() {
		// TODO Auto-generated method stub
		return null;
	}

	public int doStartTag() throws JspException {
		DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
		  DocumentoDAO  objPrioridad = objDAOFactory.getDocumentoDAO();

		JspWriter out = pagecontext.getOut();

		try{
		 HttpSession session = pagecontext.getSession(); 
		 BeanUsuarioAD beanusuario = (BeanUsuarioAD)session.getAttribute("usuario");
		
		 
		 System.out.println("el valor de la organizacion es=============> "+beanusuario.getCUSUARIO_COD_ORG().trim());
		 Iterator iterator = objPrioridad.traeComboEntidadExterna(beanusuario.getCUSUARIO_COD_ORG().trim()).iterator();
		
		 while(iterator.hasNext()){		
			BeanDocumento1 objBeanAuxiliar=(BeanDocumento1)iterator.next();			
			out.println("<option  value="+objBeanAuxiliar.getCodigo()+">"+ objBeanAuxiliar.getNombre() +"</option>"); 
			
		 }			 
		 
			}catch(Exception e){  
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
