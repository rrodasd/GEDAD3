<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
  String tipreg = (String)session.getAttribute("tipgra");
  System.out.println(" valor de tipreg :" + tipreg);
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<script language="javascript">
  function f_submit(){
	document.form1.action='<%= request.getContextPath() %>/capturaimgreg3';
    //	alert("wow");	
	document.form1.submit();
  }
  
  function carga(){
    if(document.form1.url.value!="null"){
      //	alert("entro");
	  document.form1.target='main';
      if(document.form1.treg.value=="A"){
        window.opener.document.frm_Manto.url_Anexo3.value=document.form1.url.value;
      }
      if(document.form1.treg.value=="B"){
        window.opener.document.frmregReferencias.url_Anexo3.value=document.form1.url.value;
      }
      if(document.form1.treg.value=="1"){
        window.opener.document.frm_Manto.url_Anexo3.value=document.form1.url.value;
      }
      window.close();
    }
  }
</script>
<style type="text/css">
<!--
.Estilo1 {
	font-size: 11px;
	font-weight: bold;
	font-family: Verdana, Arial, Helvetica, sans-serif;
}

.Estilo2 {
	font-size: 9px;
	font-weight: bold;
	font-family:  Verdana, Arial, Helvetica, sans-serif;
}

.Estilo3 {
	font-size: 9px;
	font-weight: bold;
	font-family:  Arial;
}

.Estilo4 {
	font-size: 16px;
	font-weight: bold;
	font-family:  Arial;
}
.Estilo5 {
	font-size: 16px;
	font-weight: bold;
	font-family:  Arial;
}

.Estilo6 {
	font-size: 13px;
	font-weight: bold;
	font-family:  Arial;
}
.Estilo16 {color: #FF0000}
-->
</style>

<body background="imagenes/fondos/fondosistema.gif" onload="carga();">
<center>
<form name="form1" method="POST" enctype='multipart/form-data' action=""><span class="Estilo6">
Por favor, seleccione el trayecto de la Imagen a cargar</span>
  <br><input type="file" name="fichero" id="fichero">
  <input type="button" onclick="f_submit()" value="Aceptar">
  <br>
  <input type="hidden" name="url" value="<%=session.getAttribute("ficherox")%>">
  <input type="hidden" name="treg" value="<%=tipreg%>">
</form> 
</center>
</body>
<%session.removeAttribute("ficherox"); %>
</html>
