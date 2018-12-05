

<%@page import="comun.Constante.PATH_PROPERTIES"%>
<%@page import="comun.Constante.PATH_PROPERTIES"%>
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
<%@page import="javax.servlet.http. *"%>

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
    
    System.out.println("FIRMAR anexos-"+ reporte);

    ArrayList ListarDistribucion=null;
    ArrayList ListarDestinatario=null;
    ArrayList ListarAnexos=null;
    
    
    /*
    01. RETORNA LISTA, SEGUN VALOR DE COMBO ORGANIZACION
    02. RETORNA UN DOCUMENTO DE LA LISTA POR REVISAR
    03. ABRE LA VENTANA DE DISTRIBUCION
        Distribucion_01. CARGA EL COMBO DE ACUERDO AL TIPO DE ORGANIZACION 



/*
    *Formulario Ajax (08). Anexos ----------------------------------------------------------------------------->
    */

if (reporte.equals("ANEX_01")) {

 periodo = request.getParameter("periodo");       
 String cod_docinterno = request.getParameter("cod_interno"); 

System.out.println("periodo*-"+periodo+"-");
System.out.println("cod_docinterno-"+cod_docinterno+"-");
  
 ListarAnexos = (ArrayList)objRD.obtenerFullAnexosXDocumento(periodo,cod_docinterno);
 int nroFilas = ListarAnexos.size();
 System.out.println("nroFilas-"+nroFilas+"-");


System.out.println("cantidad ListarAnexos-"+ ListarAnexos.size()+"-");
 
%>
<div id="modalAnexo">
<table width="100%" border="0">
                <input type="text" name="txh_perido_anexos" id="txh_perido_anexos" value="<%=periodo %>"  />  
                <input type="text" name="txh_codinter_anexos" id="txh_codinter_anexos" value="<%=cod_docinterno %>" />  
                <input type="text" name="txh_secuencia_anexos" id="txh_secuencia_anexos"  />  
                <input type="text" name="txh_archivo_anexos" id="txh_archivo_anexos"    />  
<!-- Div Botones-->                
<div align="center"><a href="javascript:f_InsertarAnexos();"><img src="<%=request.getContextPath()%>/imagenes/icono/add_anexos.png" width="60px" height="60px" />Anadir</a>
            <a href="javascript:f_MostraAnexos();"><img src="<%=request.getContextPath()%>/imagenes/icono/ver_anexos.png" width="60px" height="60px" />Ver</a>
            <a href="javascript:f_ActualizarAnexos();"><img src="<%=request.getContextPath()%>/imagenes/icono/actualizar_anexos.png" width="60px" height="60px" />Actualizar</a>
            <a href="javascript:f_EliminarAnexos();"><img src="<%=request.getContextPath()%>/imagenes/icono/del_anexos.png" width="60px" height="60px" />Eliminar</a>
</div>

<!--DIV TABLA DE ANEXOS -->
<div class="modal-body" id="modalListaAnexos">
                       
 <%
                              if (ListarAnexos != null) {
                                  
                                            %>
                                            <table class="display" id="table_anexos" width="100%" border="1">
                                                <thead>
                                                    <tr>
                                                        <th><div align="center">SELECIONAR</div></th>
                                                        <th><div align="center">AÑO</div></th>
                                                        <th><div align="center">INTERNO</div></th>
                                                        <th><div align="center">SECUENCIA</div></th>
                                                        <th><div align="center">NOMBRE</div></th>
                                                       
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        for (int i = 0; i < ListarAnexos.size(); i++) {
                                                            BeanAnexo objBeanA = (BeanAnexo) ListarAnexos.get(i);
                                                    %>
                                        <tr><td ><div align="center"><input name="trabajo" type="radio" onClick="javascript:f_CapturaAnexos('<%=objBeanA.getCANEXO_PERIODO()%>','<%=objBeanA.getCANEXO_COD_DOC_INT()%>','<%=objBeanA.getCANEXO_SECUENCIA()%>','<%=objBeanA.getVANEXO_NOMBRE()%>')"/></div></td>                                                                      
                                        <td><%=objBeanA.getCANEXO_PERIODO()%></td>
                                        <td><%=objBeanA.getCANEXO_COD_DOC_INT()%></td>
                                        <td><%=objBeanA.getCANEXO_SECUENCIA()%></td>
                                        <td><%=objBeanA.getVANEXO_NOMBRE()%></td>                                        
                                        </tr>
                                   
                                                    <%}%>
                                                    <input type="hidden" name="hidNrofilas" id="hidNrofilas"  value="<%=nroFilas%>"  />  
                                                </tbody>
                                            </table>
                                                
                                            <%}else{%>
                                            <input type="text" name="hidNrofilas" id="hidNrofilas"  value="0"  /> 
                                                <%}%>     
    
    
</div>
 <!--FIN --> 
 
  <!--DIV PARA MOSTRA LA CAPA PARA AÑADIR ANEXO -->
 <div id="capa_add_anexos" style="visibility: hidden;width:100%; align-content: center">
      
    <h3>Cargar Anexos</h3>
    <form method="POST" action="#" enctype="multipart/form-data" id="frm_anexos" target="frame_support">
        <!-- COMPONENT START -->
        <div class="form-group">
            <div class="input-group input-file" name="Fichier1">
                <label for="url_anexo_revisar"></label>
                <input type="file" class="form-control" id="url_anexo_revisar" name="fileAnexo" onChange="f_guarda_archivo_local(this.value)" />
                <span class="input-group-btn">
                    <button class="btn btn-warning btn-reset" type="button" onclick="javascript:f_Grabar_Anexos();"><b>GRABAR</b></button>
                     <button class="btn btn-info btn-info"  type="button" onclick="javascript:f_cancelar();"><b>CANCELAR</b></button>
                </span>
            </div>
        </div>
    </form>
    
    <!-- agregar despues el css: display:none -->
    <iframe name="frame_support" style="background: rgba(0,0,0,0.3); width: 100%; height: 80px;visibility: hidden">
        IFrame de soporte
    </iframe>
      
   
  </div>                                                   
 </div>
 <br>
 <!-- FIN DE DIV-->
 </table>
</div>
<%} 

/*
    *Formulario Ajax (09). Graba los Anexos ----------------------------------------------------------------------------->
    */
else if (reporte.equals("ANEX_02")) {

//(01)::Captura el Años actual
 Calendar fecha = java.util.Calendar.getInstance();
 periodo = fecha.get(java.util.Calendar.YEAR) + "";
 periodo = periodo;

//(02)::Capturara variables de ajax

 periodo = (String) request.getParameter("v_periodo");   
 String cod_docinterno = (String) request.getParameter("v_cod_interno"); 
 secuencia = (String) request.getParameter("v_secuencia");
 String nombre_archivo = (String) request.getParameter("v_nombre_archivo");
System.out.println("periodo -"+periodo+"-");
System.out.println("cod_docinterno-"+cod_docinterno+"-");
System.out.println("secuencia-"+secuencia+"-");
System.out.println("nombre_archivo-"+nombre_archivo+"-");


//(03)::Se obtiene el numero de SECUENCIA y GRABAR 
 String nrosec = null;
  try {
    nrosec = objFD.generaSecAnexo(periodo, cod_docinterno); 
    System.out.println("nombre_archivo-"+nombre_archivo+"-");
    objFD.insertarDocumentoAnexo(periodo, cod_docinterno, nrosec, nombre_archivo);
  } catch (Exception e) {
            System.out.println("Oracle Inserta Anexos ajax" + e.getMessage());
  }
  
//(04):: vUELVE A LLAMAR  A LA LISTA DE ANEXOS
ListarAnexos = (ArrayList)objFD.obtenerFullAnexosXDocumento(periodo,cod_docinterno);
 int nroFilas = ListarAnexos.size();
System.out.println("cantidad ListarAnexos-"+ ListarAnexos.size()+"-");

%>




<%} 
/*
    *Formulario Ajax (10). write los Anexos en la maquina local----------------------------------------------------------------------------->
    */
else if (reporte.equals("ANEX_03")) {
    System.out.println("mOSTAR periodo------------------------------------------------------------- -");
     periodo = (String) request.getParameter("txh_perido_anexos");   
     String cod_int = (String) request.getParameter("txh_codinter_anexos"); 
     secuencia = (String) request.getParameter("txh_secuencia_anexos");
     String fileName = (String) request.getParameter("txh_archivo_anexos");
    System.out.println("mOSTAR periodo -"+periodo+"-");
    System.out.println("Mostarcod_docinterno-"+cod_int+"-");
    System.out.println("Mostar secuencia-"+secuencia+"-");
    System.out.println("Mostar nombre_archivo-"+fileName+"-");

    BeanAnexo objBeanG = new BeanAnexo();
    objBeanG.setCANEXO_PERIODO(periodo);
    objBeanG.setCANEXO_COD_DOC_INT(cod_int);
    objBeanG.setCANEXO_SECUENCIA(secuencia);
    objBeanG.setVANEXO_NOMBRE(fileName);
        

  // Estableces la ruta donde se encuentra el properties de la aplicacion
        PropertiesUtil pUtil = new PropertiesUtil(PATH_PROPERTIES);
        //PropertiesUtil pUtil = new PropertiesUtil("C:\\data\\aws\\alfresco_api.properties");
         System.out.println("pUtil -"+pUtil+"-");
        BeanAnexo bAnexoConsultado = objRD.obtenerAnexoSinBlob(objBeanG);
         System.out.println("bAnexoConsultado.getVANEXO_TOKEN() -"+bAnexoConsultado.getVANEXO_TOKEN());
        AlfrescoWebScripts aws = new AlfrescoWebScripts();
 System.out.println("aws -"+aws+"-");
        byte[] buffer = aws.getDocument(bAnexoConsultado.getVANEXO_TOKEN());
System.out.println("buffer -"+buffer+"-");
        ServletContext context = getServletContext();
System.out.println("context -"+context+"-");
         String mimeType = context.getMimeType(fileName);
System.out.println("mimeType -"+mimeType+"-");
        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }   
        // set content properties and header attributes for the response
        response.setContentType(mimeType);
        String headerKey = "Content-Disposition";
        String headerValue = String.format("inline; filename=\"%s\"", fileName);
        response.setHeader(headerKey, headerValue);
        
        // writes the file to the client
        
        ServletOutputStream out2 = response.getOutputStream();
//PrintWriter out2 = response.getWriter();
System.out.println("out2 -"+out2+"-");

        out2.write(buffer);

//Desktop.getDesktop().open(buffer);
 //out2.flush();
       // out2.flush();
         



%>
<html>
<head>
<script> 

</script> 

<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body >
<form name="form_ver" method="post">
<input type="hidden" name="txt_CDOCUMENTO_PERIODO" >
 <input type="hidden" name="txt_CDOCUMENTO_COD_DOC_INT" >
 <input type="hidden" name="txt_SECUENCIA" >
  <input type="hidden" name="txt_NOMBRE_ARCHIVO" >
 <input type="hidden" name="txt_TipoAccion" >

</form>

</body>
</html>




<%} %>