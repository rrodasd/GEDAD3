<%@page import="sagde.bean.BeanClase"%>
<%@page import="java.util.ArrayList"%>
<%@page import="comun.FormularDocumentoDAO"%>
<%@page import="comun.DAOFactory"%>
<%@page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%
    DAOFactory objDF = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
    FormularDocumentoDAO objFD = objDF.getFormularDocumentoDAO();
    ArrayList listaClase = (ArrayList) objFD.listaClaseFormular();
%>
<table  width="100%" border="0" cellspacing="0" cellpadding="0" >
    <tr>                               
        <td align="center" valign="middle">                                  
            <h4>
                <p style="color:rgb(222, 97, 94);"><b>Clases de documentos</b></p>
            </h4>                                  
        </td>
    </tr>
    <tr>
        <td align="center" valign="middle">
            <%
                out.println("<table>");
                for (int i = 0; i < listaClase.size(); i++) {
                    BeanClase objBeanC = (BeanClase) listaClase.get(i);
                    out.println("<tr>");
                    out.println("<td><div align=left><a href=\"javascript:f_formular('" + objBeanC.getVCLASE_RUTA() + "')\" >" + objBeanC.getVCLASE_NOM_LARGO()+ "</a></span></div></td>");
                    //out.println("<td><div align=left><a href='" + request.getContextPath() + "/formular?ruta=" + objBeanC.getVCLASE_RUTA() + "' >" + objBeanC.getVCLASE_NOM_LARGO()+ "</a></span></div></td>");
                    //out.println("<td><div align=left><a href='" + request.getContextPath() + objBeanC.getVCLASE_RUTA() + "' >" + objBeanC.getVCLASE_NOM_LARGO()+ "</a></span></div></td>");
                    out.println("</tr>");
                }
                out.println("</table>");
            %>
        </td>
    </tr>
</table>