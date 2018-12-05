<%@include file="cerrarSesion.jsp" %>
<%@page import="sagde.bean.BeanUsuarioAD"%>
<%@page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Formular Documento</title>
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/estilos.css" />
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/bootstrap.css" />
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/jquery.dataTables.min.css" />
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-3.1.1.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/jquery.dataTables.min.css"/>
        <!--     FIN LIBRERIAS ESTANDAR   -->       
        
        <%
            BeanUsuarioAD objBeanU = (BeanUsuarioAD) session.getAttribute("usuario");
            String msg_oficio = request.getParameter("msg");
            session.setAttribute("anexos", null);
        %>
        <script type="text/javascript">
            function f_formular(ruta){
                document.form1.txh_ruta.value = ruta;
                document.forms[0].action="<%=request.getContextPath()%>/formular";
                document.forms[0].submit();
            }
        </script>
    </head>

    <body  onload="javascript:if (document.getElementById('msg_oficio').value != 'null') {
            alert('Operación realizada con éxito!!!');
        }">
        <form id="form1" name="form1" method="post" action="">
        <input type="hidden" id="msg_oficio" value="<%=msg_oficio%>" />
        <input type="hidden" id="txh_ruta" name="txh_ruta"/>
            <%-- INICIOOOOOO  CABECERA --%>   
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="background-color:#D4FD89">
                <tr>
                    <td height="90" align="center" valign="middle" bgcolor="#B7BCBF"  background="<%= request.getContextPath()%>/imagenes/fondos/fondo_cabecera.fw.png"  >
                        <table  width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr >                               
                                <td align="center" valign="middle">                                  
                                    <h2>
                                        <p style="color:rgb(206, 239, 100);"><b>GESTIÓN DE DOCUMENTOS Y ARCHIVOS DIGITALES</b></p>
                                    </h2>

                                </td>
                            </tr>
                            <tr>
                                <td height="30" align="center" valign="middle" >
                                    <p style="color:rgb(206, 239, 100);"><b><i>con Firma Digital  </i>  EP - RENIEC</b></p>                             
                                </td>
                            </tr>
                            <tr>
                                <td height="30" align="center" valign="middle" bgcolor="#eeeeee">
                                    <span class="glyphicon glyphicon-user" style="color:rgb(217, 81, 77);">&emsp;&emsp;<b><i>Usuario :</i><%=objBeanU.getVUSUARIO_CARGO()%></b></span>
                                </td>
                            </tr>
                        </table>
                    </td>    
                </tr>

                <%-- MENU DEL SISTEMA --%>             
                <tr>
                    <td>
                        <nav class="navbar navbar-inverse">
                            <div class="container-fluid">
                                <div class="navbar-header">
                                    <a class="navbar-brand" href="#">FORMULAR DOCUMENTO </a>
                                </div>                          

                                <ul class="nav navbar-nav navbar-right">
                                    <li><a href="<%= request.getContextPath()%>/menu"><span class="glyphicon glyphicon-home"></span> Home</a></li>
                                </ul>          

                            </div>                       
                        </nav>

                    </td>
                </tr>    
            </table>
            <%-- TERMINO  CABECERA --%> 
            <table>
                <tr>
                    <td width="3%">&nbsp;</td>
                    <td class="form-control" >
                        <%@ include file="/gedad/formulardoc/I_MenuDocumento.jsp"%></td>
                        <td width="3%">&nbsp;</td>
                        <td></td>
                        <td width="3%">&nbsp;</td>
                </tr>

            </table>

        </form>
    </body>

</html>
