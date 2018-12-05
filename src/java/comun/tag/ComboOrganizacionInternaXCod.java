package comun.tag;

import java.util.Iterator;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.Tag;

import sagde.bean.BeanOrganizacionInterna;

import comun.DAOFactory;
import comun.DocumentoDAO;

public class ComboOrganizacionInternaXCod implements Tag{
	PageContext pagecontext;

	public void setPageContext(PageContext pagecontext) {
		// TODO Auto-generated method stub
		this.pagecontext=pagecontext;
	}

	public void setParent(Tag arg0) {
		// TODO Auto-generated method stub
		
	}

	public Tag getParent() {
		// TODO Auto-generated method stub
		return null;
	}

	public int doStartTag() throws JspException {
		JspWriter out=pagecontext.getOut();
		DAOFactory objDAOFactory=DAOFactory.getDAOFactory(DAOFactory.ORACLE);
		//OrganizacionInternaDocDAO objPrioridad=(OrganizacionInternaDocDAO) objDAOFactory.getOrganizacionInternaDocDAO();
		
		
		
		
		String valor=(String)pagecontext.getSession().getAttribute("NombreUsuario");
//		System.out.println("1111111111111111111111111 ----- >>" +valor);
		
		try {
			//String codigoOrganizacionUsuario=(String)((BeanUsuarioAD)session.getAttribute("usuario")).getCUSUARIO_COD_ORG();
			//System.out.println("22222222222222222222222222222 ----- >>" +codigoOrganizacionUsuario);
			DocumentoDAO  objRevisar = objDAOFactory.getDocumentoDAO();

			
			Iterator iterator=objRevisar.obtenerDependencia(valor).iterator();			
			
			
			//Iterator iterator=objPrioridad.obtenerOrganizacionInternaDoc().iterator();
			//out.println("<option  value=s>- - Elija Opcion - -</option>");
			
			while(iterator.hasNext()){
				
				BeanOrganizacionInterna beanOrgInterno=(BeanOrganizacionInterna)iterator.next();
				String	org = (beanOrgInterno.getCOINTERNA_CODIGO().equals(valor))?"selected":"";
				out.println("<option value="+beanOrgInterno.getCOINTERNA_CODIGO()+" "+org+">"+beanOrgInterno.getVOINTERNA_NOM_CORTO()+"</option>");  

			
//				System.out.println("codigo de combo atrapado es ----- >>" + 	beanOrgInterno.getCOINTERNA_CODIGO());
				
				//BeanAuxiliar objBeanAuxiliar=(BeanAuxiliar)iterator.next();	
				//out.println("<option  value="+objBeanAuxiliar.getCodigo()+">"+ objBeanAuxiliar.getNombre()+ "</option>"); 
				
				}
			
		} catch (Exception e) {
			
			System.out.println("doStartTag" + e.getMessage());
			e.printStackTrace();
		}
		
		return EVAL_BODY_INCLUDE;
		
	}

	public int doEndTag() throws JspException {
		// TODO Auto-generated method stub
		return EVAL_PAGE;
	}

	public void release() {
		// TODO Auto-generated method stub
		
	}

}
