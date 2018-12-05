

<%@page import="sagde.comun.OracleDBConn"%>
<%@page import="pe.mil.ejercito.alfresco_api.commons.AlfrescoProcess"%>
<%@page import="java.awt.Desktop"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="comun.Constante.*"%>
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
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.*"%>
<%@page import="java.util.List"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.nio.file.Files"%>
<%@page import="java.nio.file.Path"%>
<%@page import="java.nio.file.Paths"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="pe.mil.ejercito.alfresco_api.commons.AlfrescoWebScripts"%>
<%@page import="pe.mil.ejercito.alfresco_api.commons.PropertiesUtil"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
    String hora = (String) request.getParameter("pasacache");
    String reporte = (String) request.getParameter("reporte");
    String periodo = (String) request.getParameter("periodo");
    String secuencia = (String) request.getParameter("secuencia");

    DAOFactory objDF = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
    RevisaDocumentoDAO objRD = objDF.getRevisaDocumentoDAO();
    session = request.getSession(true);
    ArrayList ListarAnexos = new ArrayList();

    /*
    ANEX_01. RETORNA LISTA DE ANEXOS, SEGUN PERIODO Y COD INTERNO
    ANEX_02. RETORNA FORMULARIO VACIO PARA AGREGAR ANEXO
    ANEX_03. INVOCA AL SERVLET PARA LA VISTA PREVIA DE UN ANEXO
     */
    if (reporte.equals("ANEX_01")) {

        periodo = request.getParameter("periodo");
        String cod_docinterno = request.getParameter("cod_interno");
        ListarAnexos = (ArrayList) objRD.obtenerFullAnexosXDocumento(periodo, cod_docinterno);

%><br>
<table class="display" id="table_anexos" width="100%" border="1">
    <thead>
        <tr>
            <th style="width: 10%"><div align="center">N°</div></th>
            <th style="width: 70%"><div align="center">NOMBRE</div></th>
            <th style="width: 10%"><div align="center">VER</div></th>
            <th style="width: 10%"><div align="center">ELIMINAR</div></th>
        </tr>
    </thead>
    <tbody>
        <%            for (int i = 0; i < ListarAnexos.size(); i++) {
                BeanAnexo objBeanA = (BeanAnexo) ListarAnexos.get(i);
        %>
        <tr>
            <td><div align="center"><%=objBeanA.getCANEXO_SECUENCIA()%></div></td>
            <td><%=objBeanA.getVANEXO_NOMBRE()%></td>
            <td><div align="center"><a href="javascript:f_verAnexo('<%=objBeanA.getVANEXO_TOKEN()%>','<%=objBeanA.getVANEXO_NOMBRE()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/ver_anexos.png" width="20px" height="20px" /></a></div></td>
            <td><div align="center"><a href="javascript:f_eliminarAnexo('<%=objBeanA.getCANEXO_SECUENCIA()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/delete.png" width="20px" height="20px" /></a></div></td>
        </tr>
        <%}%>
    </tbody>
</table>
<%} else if (reporte.equals("ANEX_02")) {
%>
<form method="POST" action="#" enctype="multipart/form-data" id="frm_anexos" target="frame_support">
    <!-- COMPONENT START -->
    <div class="form-group">
        <div class="input-group input-file" name="Fichier1">
            <label for="url_anexo"></label>
            <input type="file" class="form-controlOF" id="url_anexo" name="fileAnexo" style="width: 550px" />
        </div>
    </div>
    <div align="center">
        <span class="input-group-btn">
            <table width="30%">
                <tr>
                    <td width="45%"><button class="btn btn-success btn-reset form-control" type="button" onclick="javascript:f_grabar_anexo();"><b>GRABAR</b></button></td>
                    <td width="10%">&nbsp;</td>
                    <td width="45%"><button class="btn btn-danger btn-info form-control" type="button" onclick="javascript:f_cerrar_moAnexos();"><b>CANCELAR</b></button></td>
                </tr>
            </table>
        </span>
    </div>
</form>
<!-- agregar despues el css: display:none -->
<iframe name="frame_support" style="background: rgba(0,0,0,0.3); width: 100%; height: 0px;visibility: hidden">
    IFrame de soporte
</iframe>
<%
} else if (reporte.equals("ANEX_03")) {

    String token = (String) request.getParameter("token");
    String archivo = (String) request.getParameter("archivo");

%>
<div class="embed-responsive embed-responsive-16by9">
    <iframe class="embed-responsive-item" src="<%= request.getContextPath()%>/mostrarAnexoAdjunto?token=<%=token%>&archivo=<%=archivo%>"></iframe>
</div>
<%} else if (reporte.equals("ANEX_04")) {

    periodo = (String) request.getParameter("periodo");
    String cod_int = (String) request.getParameter("cod_interno");
    secuencia = (String) request.getParameter("secuencia");
    objRD.eliminarAnexos(periodo, cod_int, secuencia);

    ListarAnexos = (ArrayList) objRD.obtenerFullAnexosXDocumento(periodo, cod_int);
%><br>
<table class="display" id="table_anexos" width="100%" border="1">
    <thead>
        <tr>
            <th style="width: 10%"><div align="center">N°</div></th>
            <th style="width: 70%"><div align="center">NOMBRE</div></th>
            <th style="width: 10%"><div align="center">VER</div></th>
            <th style="width: 10%"><div align="center">ELIMINAR</div></th>
        </tr>
    </thead>
    <tbody>
        <%            for (int i = 0; i < ListarAnexos.size(); i++) {
                BeanAnexo objBeanA = (BeanAnexo) ListarAnexos.get(i);
        %>
        <tr>
            <td><div align="center"><%=objBeanA.getCANEXO_SECUENCIA()%></div></td>
            <td><%=objBeanA.getVANEXO_NOMBRE()%></td>
            <td><div align="center"><a href="javascript:f_verAnexo('<%=objBeanA.getVANEXO_TOKEN()%>','<%=objBeanA.getVANEXO_NOMBRE()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/ver_anexos.png" width="20px" height="20px" /></a></div></td>
            <td><div align="center"><a href="javascript:f_eliminarAnexo('<%=objBeanA.getCANEXO_SECUENCIA()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/delete.png" width="20px" height="20px" /></a></div></td>
        </tr>
        <%}%>
    </tbody>
</table>
<%
} else if (reporte.equals("ANEX_05")) {
    periodo = (String) request.getParameter("periodo");
    String cod_int = (String) request.getParameter("cod_interno");
    ListarAnexos = (ArrayList)objRD.obtenerFullAnexosXDocumento(periodo, cod_int);
%>
<table border="0" width="100%">
    <tr class="EstiloOF">
        <td><u>ANEXOS:</u><br>
            <table  width="100%" >
                <tbody>
                    <%
                        for (int i = 0; i < ListarAnexos.size(); i++) {
                            BeanAnexo objBeanA = (BeanAnexo) ListarAnexos.get(i);
                    %>
                    <tr>
                        <td>-</td>
                        <td><div align="left">
                                <a href="javascript:f_verAnexo('<%=objBeanA.getVANEXO_TOKEN()%>','<%=objBeanA.getVANEXO_NOMBRE()%>');">	
                                    <%=objBeanA.getVANEXO_NOMBRE()%>
                                </a>
                            </div>
                        </td>
                    </tr>
                    <%}%>
                </tbody>
            </table>
        </td>
    </tr>
</table>
<%
    }

%>