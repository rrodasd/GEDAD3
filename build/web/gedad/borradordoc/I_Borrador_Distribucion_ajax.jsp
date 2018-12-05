<%@page import="sagde.bean.BeanOrganizacionExterna"%>
<%@page import="sagde.bean.BeanOrganizacionInterna"%>
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
<%@page import="javax.servlet.http.*"%>


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

    ArrayList ListarDistribucion = null;
    ArrayList ListarDestinatario = null;
    ArrayList ListarAnexos = null;
   

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

        String verifica = (String) request.getParameter("verifica");
        
        periodo = (String) request.getParameter("periodo");
        String cod_int = (String) request.getParameter("cod_interno");

        //-->1. El TagComboDisribucion Necesita el "cod_org_cab":E-I-G para poder cargar
        String cod_org_cabecera = (String) request.getParameter("cod_org_cab");
        if (cod_org_cabecera != null) {
            session.setAttribute("cod_org_cab", cod_org_cabecera);
        }
        //-->2. Traer la distribucion o DESTINATARIOS guardado por el formular para ser REVISADO
        if (verifica.equals("SI")) {
            
            ListarDestinatario = (ArrayList) session.getAttribute("ListarDestinatario");
            session.setAttribute("ListarDestinatario", ListarDestinatario);
        } else {
           
            ListarDestinatario = (ArrayList) objRD.RD_ObtenerDistribucion(periodo, cod_int);
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
                    <table width="100%" align="center" border="0" cellpadding="0" cellspacing="0" bgcolor="#6E6855">
                        <tr>
                            <td>
                                <label class="label-titulo">1. TIPO ORG:</label></td>
                            <td  align="left" valign="middle" colspan="5">                                                                
                                <div align="left" valign="middle">
                                    <input name="tipo" type="radio" value="G" onClick="javascript:f_DIS('G');" />Ejército
                                    <input name="tipo" type="radio" value="E" onClick="javascript:f_DIS('E');" />Externa
                                    <input name="tipo" type="radio" value=I onClick="javascript:f_DIS('I');" />Interna
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <label class="label-titulo">2.ORGANIZACIÓN:</label></td>
                            <td align="left" valign="middle"><div id="dis_org">
                                    <select name="org"  id="org_rodas" class="selectpicker" data-live-search="true"  >
                                        <option>--Elija Opcion--</option>
                                    </select>
                                </div>                                                                     
                            </td>
                            <td width="2%">&nbsp;</td>
                            <td width="12%"><button type="button" class="btn btn-success btn-sm" style="width: 100%" onclick="javascript:f_AgregarDestinatarios();" >AGREGAR</button></td>
                            <td width="2%">&nbsp;</td>
                            <td width="12%"><button type="button" class="btn btn-warning btn-sm" style="width: 100%" onclick="javascript:f_cerrar();" >RETORNAR AL OFICIO</button></td>
                        </tr>
                        <!-- El modal donde lista a los detinatarios-->
                        <tr>
                            <td colspan="6">
                                <div class="modal-body" id="modalDestinatario">

                                    <%
                                        if (ListarDestinatario != null) {
                                    %>
                                    <table class="display" id="distri" width="100%"  border="1">
                                        <thead>
                                            <tr style="background-color:#ADADAD ">
                                                <th style="width:10%">ORG</th>
                                                <th style="width:80%">GRADO y NOMBRE</th>                                                                  
                                                <th style="width:5%">ORIG</th>
                                                <th style="width:5%">ELIMINAR</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <%
                                                for (int i = 0; i < ListarDestinatario.size(); i++) {
                                                    BeanDistribucion objBeanD = (BeanDistribucion) ListarDestinatario.get(i);
                                                   // System.out.println("tipo dist1 x"+objBeanD.getTipo()+"x");
                                            %>
                                            <tr>
                                                <td style="width:10%"><%=objBeanD.getDescOrganizacion()%></td>
                                                <td style="width:80%"><%=objBeanD.getGrado()%><div><%=objBeanD.getNombre()%></div><div><b><i><%=objBeanD.getCargo()%></i></b></div></td>                                                                 
                                                <td style="width:5%"><div align="center"><input name="trabajo" type="radio" onClick="javascript:f_CapturaDestinarario('<%=objBeanD.getNombre()%>', '<%=objBeanD.getGrado()%>', '<%=objBeanD.getCargo()%>', 'T', '<%=objBeanD.getCodigoOrganizacion()%>', '<%=objBeanD.getTipoOrganizacion()%>')" <%if (objBeanD.getTipo() != null) {
                    if (objBeanD.getTipo().equals("T")) {%> checked="true" <%}
                        }%>/></div></td>
                                                <td style="width:5%"><div align="center"><a href="javascript:f_EliminaListaDestinatario('<%=objBeanD.getTipoOrganizacion()%>','<%=objBeanD.getCodigoOrganizacion()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/delete.png" width="20px" height="20px" /></a></div></td>

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
} /*
    *Formulario Ajax (02). Listara lo Detinanatarios Include del Modal Distribucion ----------------------------------------------------------------------------->
 */ else if (reporte.equals("DIST_02")) {

    String Interno = "I";
    String v_tipo_organizacion = (String) request.getParameter("v_tipo_organizacion");
    String v_destinatario = (String) request.getParameter("v_destinatario");

    if (v_tipo_organizacion.contains("G")) {
        tipoOrganizacion = Interno;
    }

//Retorna el Destinatario que se eliguio en el Combo
    BeanDistribucion bean = objRD.AddDistribucion(tipoOrganizacion, v_destinatario);
    bean.setTipo("C");
    
    ListarDestinatario = (ArrayList) session.getAttribute("ListarDestinatario");

    if (ListarDestinatario == null) {
        ListarDestinatario = new ArrayList();
    }
    String mensaje = "";
    if (bean.getCodigoOrganizacion() == null) {
        mensaje = "No existe persona a cargo en esta organización en GEDAD";
    } else {
        boolean existe = objRD.ExisteDistribucion(ListarDestinatario, bean);
        if (existe == false) {
            ListarDestinatario.add(bean);
        }
    }
  

%>

<%      if (ListarDestinatario != null) {
%>
<div align=center"><%=mensaje%></div>
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
            <td style="width:5%">
                <div align="center">
                    <input name="trabajo" type="radio" onClick="javascript:f_CapturaDestinarario('<%=objBeanD.getNombre()%>', '<%=objBeanD.getGrado()%>', '<%=objBeanD.getCargo()%>', 'T', '<%=objBeanD.getCodigoOrganizacion()%>', '<%=objBeanD.getTipoOrganizacion()%>')" <%if (objBeanD.getTipo() != null) {if (objBeanD.getTipo().equals("T")) {%> checked="true" <%}}%> />
                </div>
            </td>
            <td style="width:5%"><div align="center"><a href="javascript:f_EliminaListaDestinatario('<%=objBeanD.getTipoOrganizacion()%>','<%=objBeanD.getCodigoOrganizacion()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/delete.png" width="45px" height="45px" /></a></div></td>
        </tr>
        <%}%>
    </tbody>

</table>        
<%     session.setAttribute("ListarDestinatario", ListarDestinatario);  

}
%>
<%} /*
    *Formulario Ajax (03). Eliminara  lo Detinanatarios Include del Modal Distribucion  ----------------------------------------------------------------------------->
 */ else if (reporte.equals("DIST_03")) {

    String v_tipo_organizacion = (String) request.getParameter("v_tipo_organizacion");
    String v_destinatario = (String) request.getParameter("v_destinatario");

    ListarDestinatario = (ArrayList) session.getAttribute("ListarDestinatario");

    /*Solo pata verificar cuantos en session se tiene
    int cantidadListadestinatario = ListarDestinatario.size();
     */
    int cantidadListadestinatario = ListarDestinatario.size();
   
    Iterator iterator = ListarDestinatario.iterator();
    while (iterator.hasNext()) {
        BeanDistribucion bean_distribucion = (BeanDistribucion) iterator.next();
        //- Se añadio este replaceAll("\\s","")---> para anular los espacios en blanco para realizar la comparacion
        String org_sin_espacio = bean_distribucion.getCodigoOrganizacion().replaceAll("\\s", "");
        if (bean_distribucion.getTipoOrganizacion().equals(v_tipo_organizacion) && org_sin_espacio.equals(v_destinatario)) {
            iterator.remove();
            break;
        }

    }

    ListarDestinatario = (ArrayList) session.getAttribute("ListarDestinatario");
    //System.out.println("cantidadListadestinatario despues-- " + ListarDestinatario.size() + "-");
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



<%} /*
    *Formulario Ajax (04). Actualizara el Pie de la Distribucion  ----------------------------------------------------------------------------->
 */ else if (reporte.equals("DIST_04")) {

    //-->1. Traer los parametros al seleccionar el destinatario original
    periodo = (String) request.getParameter("periodo");
    //String cod_int = (String) request.getParameter("cod_interno");
    String cod_organizacion = (String) request.getParameter("cod_organizacion");
    String tipo_dist = (String) request.getParameter("tipo_dist");
    //System.out.println("cod_organizacion-" + cod_organizacion + "-");

    //-->2. Traer en session los destinatario desde de agregar y/eliminar
    ListarDestinatario = (ArrayList) session.getAttribute("ListarDestinatario");
   // System.out.println("cantidad para el pie de paginaaa *-*-*-*-*-*-*-*-*--" + ListarDestinatario.size() + "-");
    

%>
<table border="0" class="EstiloOF">
    <%      for (int i = 0; i < ListarDestinatario.size(); i++) {
            BeanDistribucion objBeanD = (BeanDistribucion) ListarDestinatario.get(i);
            String org_sin_espacio = objBeanD.getCodigoOrganizacion().replaceAll("\\s", "");
            String org_sin_espacio_viene = cod_organizacion.replaceAll("\\s", "");
           // System.out.println("in espacio-" + org_sin_espacio + "-");
           // System.out.println("in org_sin_espacio_viene-" + org_sin_espacio_viene + "-");
            if (org_sin_espacio.equals(org_sin_espacio_viene)) {
                objBeanD.setTipo(tipo_dist);
                ListarDestinatario.remove(i);
                ListarDestinatario.add(i, objBeanD);
    %>
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
            String org_sin_espacio_viene = cod_organizacion.replaceAll("\\s", "");
            if (!org_sin_espacio.equals(org_sin_espacio_viene)) {
                objBeanD.setTipo("C");
                ListarDestinatario.remove(i);
                ListarDestinatario.add(i, objBeanD);
    %>
    <tr>
        <td>-&nbsp;<%=objBeanD.getDescOrganizacion()%>&nbsp;..........&nbsp;</td>
        <td>01 (C'Inf)</td>
    </tr>
    <%}
        }
session.setAttribute("ListarDestinatario", ListarDestinatario);

    %>
</table>  
<%} else if (reporte.equals("DIST_05")) {
        String interna = (String) request.getParameter("interna");
        String tipo = (String) request.getParameter("tipo");

        String dato = interna.substring(0, 2);
        out.println("<select name='org' id='org'  class='selectpicker' data-live-search='true'    >");
        out.println("<option>--Elija Opcion--</option>");

        if (tipo.equals("I")) {
            Iterator iteratorOrgI = objFD.obtenerOrganizacionInternas(interna).iterator();
            while (iteratorOrgI.hasNext()) {
                BeanOrganizacionInterna beanorgi = (BeanOrganizacionInterna) iteratorOrgI.next();
                out.println("<option value=" + beanorgi.getCOINTERNA_CODIGO() + ">" + beanorgi.getVOINTERNA_NOM_CORTO() + "</option>");
            }

        } else if (tipo.equals("E")) {
            Iterator iteratorOrgE = objFD.obtenerOrganizacionExterna().iterator();
            while (iteratorOrgE.hasNext()) {
                BeanOrganizacionExterna beanorge = (BeanOrganizacionExterna) iteratorOrgE.next();
                out.println("<option  value=" + beanorge.getCodigo() + ">" + beanorge.getNombre() + "</option>");
            }
        } else if (tipo.equals("G")) {
            Iterator iteratorOrgI = objFD.obtenerOrganizacionEjercito(interna, dato).iterator();

            while (iteratorOrgI.hasNext()) {
                BeanOrganizacionInterna beanorgi = (BeanOrganizacionInterna) iteratorOrgI.next();

               
                out.println("<option value=" + beanorgi.getCOINTERNA_CODIGO() + ">" + beanorgi.getVOINTERNA_NOM_CORTO() + "</option>");
            }
        }
        out.println("</select>");

    } else if (reporte.equals("DIST_06")) {       

    ListarDestinatario = (ArrayList) session.getAttribute("ListarDestinatario");
 %>
 
 <table border="0" class="EstiloOF">
    <%        for (int i = 0; i < ListarDestinatario.size(); i++) {
            BeanDistribucion objBeanD = (BeanDistribucion) ListarDestinatario.get(i);
            if (objBeanD.getTipo().equals("T")) {
    %>
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
            if (objBeanD.getTipo().equals("C")) {
    %>
    <tr>
        <td>-&nbsp;<%=objBeanD.getDescOrganizacion()%>&nbsp;..........&nbsp;</td>
        <td>01 (C'Inf)</td>
    </tr>
    <%}
        }
    %>
</table>
 <%
      session.setAttribute("ListarDestinatario", ListarDestinatario);
}

%>