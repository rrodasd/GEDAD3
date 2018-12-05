<%@page import="sagde.bean.BeanDistribucion"%>
<%@page import="sagde.bean.BeanArchivo"%>
<%@page import="java.util.Iterator"%>
<%@page import="comun.FormularDocumentoDAO"%>
<%@ taglib uri="/WEB-INF/tlds/libreria.tld" prefix="lb" %>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c" %>
<%@page import="sagde.bean.BeanRevisarDocumento"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sagde.bean.BeanUsuarioAD"%>
<%@page import="comun.RevisaDocumentoDAO"%>
<%@page import="comun.DAOFactory"%>
<%@page import="java.util.Collection"%>
<%@page import="sagde.bean.BeanAnexo"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.io.File"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http. *"%>


<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>



<%
    String hora = (String) request.getParameter("pasacache");
    String reporte = (String) request.getParameter("reporte");
    String dependencia = (String) request.getParameter("dependencia");
    String clase = (String) request.getParameter("clase");
    String codint = (String) request.getParameter("codint");
    String periodo = (String) request.getParameter("periodo");
    String secuencia = (String) request.getParameter("secuencia");
    String tipoOrganizacion = (String) request.getParameter("tipoOrganizacion");
    
    DAOFactory objDF = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
    RevisaDocumentoDAO objRD = objDF.getRevisaDocumentoDAO();
    FormularDocumentoDAO objFD = objDF.getFormularDocumentoDAO();
    session = request.getSession(true);
    BeanUsuarioAD objbean = (BeanUsuarioAD) session.getAttribute("usuario");
    
    
    ArrayList ListarDistribucion=null;
    ArrayList ListarDestinatario=null;
    ArrayList ListarAnexos=null;
    System.out.println("reporte Distribucion Ajax-->"+reporte+"<--");
    
    /*
    DIST_01. MUESTRA LA DISTRIBUCION
    DIST_02. LISTA DESTINARIOS
    DIST_03. ELIMINA DESTINATATIO
    DIST_04. ACTUALIZA PIE DE PAGINA 
      
    
     */
    /*
  
    *Formulario Ajax (01). Mostrará la Distribucion --------------------------------------------------------------------------------------------------->
    */

if (reporte.equals("DIST_01")) {
    
        String verifica2 = (String) request.getParameter("verifica"); 
        periodo = (String) request.getParameter("periodo");   
        String cod_int = (String) request.getParameter("cod_interno");
     
        //-->1. El TagComboDisribucion Necesita el "cod_org_cab":E-I-G para poder cargar
        String cod_org_cabecera = (String) request.getParameter("cod_org_cab");         
         if (cod_org_cabecera != null) {
             session.setAttribute("cod_org_cab", cod_org_cabecera);
         }

        //-->2. Traer la distribucion o DESTINATARIOS guardado por el formular para ser REVISADO
            
       
      if (verifica2.equals("SI")){
            ListarDestinatario = (ArrayList) session.getAttribute("ListarDestinatario");            
            session.setAttribute("ListarDestinatario", ListarDestinatario);
       }else{                      
            ListarDestinatario = (ArrayList) objRD.RD_ObtenerDistribucion(periodo,cod_int);
            if (ListarDestinatario != null) {
                 session.setAttribute("ListarDestinatario", ListarDestinatario);
             }          
       }
        
%>



 <!--Inicio ventana Distribucion-->
                                    <div class="modal-body" id="modalDistribucion">    
                                         <input name="txh_periodo" type="hidden" value="<%=periodo%>"/>
                                        <input name="txh_cod_int" type="hidden" value="<%=cod_int%>"/>
                                       <table width="100%" border="0" cellpadding="2" cellspacing="2" bordercolor="#66CCCC" bgcolor="#6E6855" style="background-position:center">
                                           <tr>
                                               <td width="100%">
                                                   <fieldset>
                                                       <legend><b>AGREGAR DISTRIBUCION</b></legend>
                                                       <table width="100%" align="center" border="0" cellpadding="0" cellspacing="0" bgcolor="#6E6855">
                                                           <tr>
                                                            <td >
                                                                <label class="label-titulo">TIPO ORGANIZACION:</label></td>
                                                            <td  align="left" valign="middle">
                                                                <div align="left" valign="middle">
                                                                    <lb:TagRBTipoOrganizacion></lb:TagRBTipoOrganizacion>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        
                                                          
                                                           <tr>
                                                               <td>
                                                                   <label class="label-titulo">ORGANIZACION:</label></td>
                                                               <td align="left" valign="middle">
                                                                   <select name="org"  id="org" class="selectpicker" data-live-search="true"  onchange="javascript:f_AgregarDestinatarios('agregar');">
                                                                       <option>--Elija Opcion--</option>
                                                                   <lb:TagComboDistribucion></lb:TagComboDistribucion>
                                                                   </select>
                                                               </td>
                                                               
                                                           </tr>
                                                           <!-- El modal donde lista a los detinatarios-->
                                                          
                                                           <tr>
                                                               <td colspan="2">
                                                                    <div class="modal-body" id="modalDestinatario">
                                                               
                                                               <% 
                                                                   if (ListarDestinatario != null) {
                                                               %>
                                                               <table class="display" id="distri" width="100%"  border="1">
                                                                   <thead>
                                                                       <tr style="background-color:#ADADAD ">
                                                                           <th style="width:10%">ORGANI</th>
                                                                           <th style="width:80%">GRADO y NOMBRE</th>                                                                  
                                                                           <th style="width:5%">ORIG</th>
                                                                           <th style="width:5%">&nbsp;</th>
                                                                       </tr>
                                                                   </thead>
                                                                  
                                                                    <tbody>
                                                                       <%
                                                                           for (int i = 0; i < ListarDestinatario.size(); i++) {
                                                                               BeanDistribucion objBeanD = (BeanDistribucion) ListarDestinatario.get(i);
                                                                             
                                                                       %>
                                                                       <tr>
                                                                           <td style="width:10%"><%=objBeanD.getDescOrganizacion()%></td>
                                                                           <td style="width:80%"><%=objBeanD.getGrado()%><div><%=objBeanD.getNombre()%></div><div><b><i><%=objBeanD.getCargo()%></i></b></div></td>                                                                 
                                                                           <td style="width:5%"><div align="center"><input name="trabajo" type="radio" onClick="javascript:f_CapturaDestinarario('<%=objBeanD.getNombre()%>', '<%=objBeanD.getGrado()%>', '<%=objBeanD.getCargo()%>', 'T', '<%=objBeanD.getCodigoOrganizacion()%>', '<%=objBeanD.getTipoOrganizacion()%>')"/></div></td>
                                                                           <td style="width:5%"><div align="center"><a href="javascript:f_EliminaListaDestinatario('<%=objBeanD.getTipoOrganizacion()%>','<%=objBeanD.getCodigoOrganizacion()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/delete.png" width="45px" height="45px" /></a></div></td>
                                                                       
                                                                       </tr>
                                                                       <%}%>
                                                                   </tbody>
                                                                   
                                                               </table>
                                                               <%}%>
                                                          
                                                                
                                                            </div>
                                                               </td>
                                                               
                                                           </tr>
                                                          
                                                             

                                                       </table>
                                                   </fieldset>             
                                               </td>
                                           </tr>
                                       </table>                                        
                                    </div>
                                    <!--Fin ventana Distribucion-->


<%
    } 

/*
    *Formulario Ajax (02). Listara lo Detinanatarios Include del Modal Distribucion ohhh yeahhhhh siiiii ----------------------------------------------------------------------------->
    */

else if (reporte.equals("DIST_02")) {
    
  String Interno = "I";  
  String v_tipo_organizacion = (String) request.getParameter("v_tipo_organizacion");
  String v_destinatario = (String) request.getParameter("v_destinatario");
 
  if (v_tipo_organizacion.contains("G")) {
      tipoOrganizacion = Interno;
    }
    
//Retorna el Destinatario que se eliguio en el Combo
            BeanDistribucion bean = objRD.AddDistribucion(tipoOrganizacion, v_destinatario);          
             ListarDestinatario = (ArrayList) session.getAttribute("ListarDestinatario");

            if (ListarDestinatario == null) {
                ListarDestinatario = new ArrayList();

            }

            boolean existe = objRD.ExisteDistribucion(ListarDestinatario, bean);
System.out.println("--nuevo array--");

            if (existe == false) {
                ListarDestinatario.add(bean);
            }
            int cantidad = ListarDestinatario.size();
System.out.println("--cantidad--"+cantidad+"-");
            session.setAttribute("cantidad", cantidad);
            session.setAttribute("ListarDestinatario", ListarDestinatario);

      


%>

                                                      <% 
                                                                   if (ListarDestinatario != null) {
                                                               %>
                                                                <table class="display" id="distri" width="100%"  border="1">
                                                                   <thead>
                                                                       <tr style="background-color:#ADADAD ">
                                                                           <th style="width:10%">ORGANI</th>
                                                                           <th style="width:80%">GRADO y NOMBRE</th>                                                                  
                                                                           <th style="width:5%">ORIG</th>
                                                                           <th style="width:5%">&nbsp;</th>
                                                                       </tr>
                                                                   </thead>
                                                                  
                                                                    <tbody>
                                                                       <%
                                                                           for (int i = 0; i < ListarDestinatario.size(); i++) {
                                                                               BeanDistribucion objBeanD = (BeanDistribucion) ListarDestinatario.get(i);
                                                                             
                                                                       %>
                                                                       <tr>
                                                                           <td style="width:10%"><%=objBeanD.getDescOrganizacion()%></td>
                                                                           <td style="width:80%"><%=objBeanD.getGrado()%><div><%=objBeanD.getNombre()%></div><div><i><%=objBeanD.getCargo()%></i></div></td>                                                                 
                                                                           <td style="width:5%"><div align="center"><input name="trabajo" type="radio" onClick="javascript:f_CapturaDestinarario('<%=objBeanD.getNombre()%>', '<%=objBeanD.getGrado()%>', '<%=objBeanD.getCargo()%>', 'T', '<%=objBeanD.getCodigoOrganizacion()%>', '<%=objBeanD.getTipoOrganizacion()%>')"/></div></td>
                                                                           <td style="width:5%"><div align="center"><a href="javascript:f_EliminaListaDestinatario('<%=objBeanD.getTipoOrganizacion()%>','<%=objBeanD.getCodigoOrganizacion()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/delete.png" width="45px" height="45px" /></a></div></td>
                                                                       </tr>
                                                                       <%}%>
                                                                   </tbody>
                                                                   
                                                               </table>
                                                               <%}%>
                                                          



<%} 

/*
    *Formulario Ajax (03). Eliminara  lo Detinanatarios Include del Modal Distribucion  ----------------------------------------------------------------------------->
    */
else if (reporte.equals("DIST_03")) {
    
  String v_tipo_organizacion = (String) request.getParameter("v_tipo_organizacion");
  String v_destinatario = (String) request.getParameter("v_destinatario");
            
  ListarDestinatario = (ArrayList) session.getAttribute("ListarDestinatario");

    /*Solo pata verificar cuantos en session se tiene
    int cantidadListadestinatario = ListarDestinatario.size();
    */           
     int cantidadListadestinatario = ListarDestinatario.size();
System.out.println("cantidadListadestinatario antes-- " + cantidadListadestinatario+"-");
   Iterator iterator = ListarDestinatario.iterator();    
        while (iterator.hasNext()) {
            BeanDistribucion bean_distribucion = (BeanDistribucion) iterator.next();
            //- Se añadio este replaceAll("\\s","")---> para anular los espacios en blanco para realizar la comparacion
            String  org_sin_espacio=bean_distribucion.getCodigoOrganizacion().replaceAll("\\s","");
             if (bean_distribucion.getTipoOrganizacion().equals(v_tipo_organizacion) && org_sin_espacio.equals(v_destinatario)) {
                iterator.remove();
                break;
            }

        }
      
ListarDestinatario = (ArrayList) session.getAttribute("ListarDestinatario");
System.out.println("cantidadListadestinatario despues-- " + ListarDestinatario.size()+"-");
 session.setAttribute("ListarDestinatario", ListarDestinatario);
%>

 <% 
                                                                   if (ListarDestinatario != null) {
                                                               %>
                                                                <table class="display" id="distri" width="100%"  border="1">
                                                                   <thead>
                                                                       <tr style="background-color:#ADADAD ">
                                                                           <th style="width:10%">ORGANI</th>
                                                                           <th style="width:80%">GRADO y NOMBRE</th>                                                                  
                                                                           <th style="width:5%">ORIG</th>
                                                                           <th style="width:5%">&nbsp;</th>
                                                                       </tr>
                                                                   </thead>
                                                                  
                                                                    <tbody>
                                                                       <%
                                                                           for (int i = 0; i < ListarDestinatario.size(); i++) {
                                                                               BeanDistribucion objBeanD = (BeanDistribucion) ListarDestinatario.get(i);
                                                                             
                                                                       %>
                                                                       <tr>
                                                                           <td style="width:10%"><%=objBeanD.getDescOrganizacion()%></td>
                                                                           <td style="width:80%"><%=objBeanD.getGrado()%><div><%=objBeanD.getNombre()%></div><div><i><%=objBeanD.getCargo()%></i></div></td>                                                                 
                                                                           <td style="width:5%"><div align="center"><input name="trabajo" type="radio" onClick="javascript:f_CapturaDestinarario('<%=objBeanD.getNombre()%>', '<%=objBeanD.getGrado()%>', '<%=objBeanD.getCargo()%>', 'T', '<%=objBeanD.getCodigoOrganizacion()%>', '<%=objBeanD.getTipoOrganizacion()%>')"/></div></td>
                                                                           
                                                                           <td style="width:5%"><div align="center"><a href="javascript:f_EliminaListaDestinatario('<%=objBeanD.getTipoOrganizacion()%>','<%=objBeanD.getCodigoOrganizacion()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/delete.png" width="45px" height="45px" /></a></div></td>
                                                                       </tr>
                                                                       <%}%>
                                                                   </tbody>
                                                                   
                                                               </table>
                                                               <%}%>
                                                          


<%} 


/*
    *Formulario Ajax (04). Actualizara el Pie de la Distribucion  ----------------------------------------------------------------------------->
    */
else if (reporte.equals("DIST_04")) {


 //-->1. Traer los parametros al seleccionar el destinatario original
        periodo = (String) request.getParameter("periodo");   
        String cod_int = (String) request.getParameter("cod_interno"); 
        String cod_organizacion = (String) request.getParameter("cod_organizacion");
    System.out.println("cod_organizacion-"+ cod_organizacion+"-");

 //-->2. Traer en session los destinatario desde de agregar y/eliminar
    ListarDestinatario = (ArrayList) session.getAttribute("ListarDestinatario");
    System.out.println("cantidad-"+ ListarDestinatario.size()+"-");
    session.setAttribute("ListarDestinatario", ListarDestinatario);
         
%>

<table border="0" class="EstiloOF">
    <%
        for (int i = 0; i < ListarDestinatario.size(); i++) {
            BeanDistribucion objBeanD = (BeanDistribucion) ListarDestinatario.get(i);
            String org_sin_espacio = objBeanD.getCodigoOrganizacion().replaceAll("\\s", "");
            if (org_sin_espacio.equals(cod_organizacion)) {%>
    <tr>
        <td>-&nbsp;<%=objBeanD.getDescOrganizacion()%>&nbsp;..........&nbsp;</td>
        <td>01</td>
    </tr>  
    <%}
        }
    %>
    <%
        for (int i = 0; i < ListarDestinatario.size(); i++) {
            BeanDistribucion objBeanD = (BeanDistribucion) ListarDestinatario.get(i);
            String org_sin_espacio = objBeanD.getCodigoOrganizacion().replaceAll("\\s", "");
            if (!org_sin_espacio.equals(cod_organizacion)) {%>
    <tr>
        <td>-&nbsp;<%=objBeanD.getDescOrganizacion()%>&nbsp;..........&nbsp;</td>
        <td>01 (C'Inf)</td>
    </tr>
    <%}
        }
    %>
            
            
    



<%} %>