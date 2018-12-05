<%@page import="sagde.bean.BeanUsuarioAD"%>
<%@page import="java.util.ArrayList"%>

<%@page import="comun.DAOFactory"%>
<%

    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);

    DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
    //UsuarioRolDAO objusuariorol = objDAOFactory.getUsuarioRolDAO();

    BeanUsuarioAD objBeanU = (BeanUsuarioAD) session.getAttribute("usuario");

    String Nro_Pendiente_Revisar = (String) request.getAttribute("Nro_Pendiente_Revisar");   
    String Nro_Pendiente_Rechazar = (String) request.getAttribute("Nro_Pendiente_Rechazar");
    String Nro_Pendiente_Firmar = (String) request.getAttribute("Nro_Pendiente_Firmar");
    String Nro_Pendiente_Borrador = (String) request.getAttribute("Nro_Pendiente_Borrador");
    String Nro_Recibidos = (String) (request.getAttribute("Nro_Recibidos")+"");

%>
<meta charset="utf-8">
<%@include file="cerrarSesion.jsp" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />     
        <script src="<%=request.getContextPath()%>/js/jquery.min.js" type="text/javascript"></script>
        <script src="<%=request.getContextPath()%>/js/bootstrap.min.js" type="text/javascript"></script>            
        <link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.css">
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%=request.getContextPath()%>/css/estilos.css" />

        <title>GEDAD</title>
        <script languaje="JavaScript">
            
            
       function F_avances() {
            
        $('#miModal').modal('show');
      
        }
            function f_ir(lugar) {
                document.frm_Menu.action = lugar;
                document.frm_Menu.submit();
            }

            function f_clave() {
                alert("Para habilitar los accesos, primero debe cambiar su contraseña inicial!!!");
            }

            function f_sinacceso() {
                alert("Este Usuario no tiene acceso a esta opcion!!!");
            }

            function f_construccion() {
                alert("Esta opcion se encuentra en construccion!!!");
            }

            function f_listaPermiso() {
                $('#miModal').modal('show');
            }

        </script>

    </head>
    <body>
        <form name="frm_Menu" method="post" action="">

            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td height="90" align="center" valign="middle" bgcolor="#B7BCBF"  background="<%= request.getContextPath()%>/imagenes/fondos/fondo_cabecera.fw.png"  >
                        <table  width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr >                               
                                <td align="center" valign="middle">                                  
                                    <h2>
                                        <p style="color:rgb(206, 239, 100);"><b>GESTIÓN ELECTRÓNICA DE DOCUMENTOS Y ARCHIVO DIGITAL</b></p>
                                    </h2>

                                </td>
                            </tr>
                            <tr>
                                <td height="30" align="center" valign="middle" >
                                    <p style="color:rgb(206, 239, 100);"><b><i>con Firma Digital  </i>  EP - RENIEC</b></p>

                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td height="30" align="center" valign="middle" bgcolor="#9A9FA3">
                        <span><b>Gestión Documental</b></span>
                    </td>
                </tr>

                <tr>
                    <td height="30" align="center" valign="middle" bgcolor="#eeeeee">
                        <span class="glyphicon glyphicon-user" style="color:rgb(217, 81, 77);">&emsp;&emsp;<b><i>Usuario :</i><%=objBeanU.getVUSUARIO_CARGO()%></b></span> 

                </tr>
                <%-- MENU DEL SISTEMA --%>

                <tr>
                    <td>
                        <nav class="navbar navbar-inverse">
                            <div class="container-fluid">
                                <div class="navbar-header">
                                    <a class="navbar-brand" href="#">Navegación GEDAD </a>
                                </div>
                                <ul class="nav navbar-nav">                                  
                                    <li class="dropdown">
                                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Formular Documento
                                            <span class="caret"></span></a>
                                        <ul class="dropdown-menu">
                                            <li><a href="<%=request.getContextPath()%>/formular">Formular</a></li>                                            
                                        </ul>
                                    </li>
                                    
                                    <li class="dropdown">
                                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Mesa de Parte
                                            <span class="caret"></span></a>
                                        <ul class="dropdown-menu">
                                            <li><a href="<%=request.getContextPath()%>/listadocumento">Recepción</a></li>
                                            <li><a href="<%=request.getContextPath()%>/listadoc_envio">Envio</a></li>        
                                        </ul>
                                    </li>

                                    <li class="dropdown">
                                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Consultas
                                            <span class="caret"></span></a>
                                        <ul class="dropdown-menu">
                                            <li><a href="#">Mesa de Parte</a></li>
                                            <li><a href="#">Referencia</a></li>        
                                        </ul>
                                    </li>

                                    <li class="dropdown">
                                        <a class="dropdown-toggle" data-toggle="dropdown" href="#">Administración
                                            <span class="caret"></span></a>
                                        <ul class="dropdown-menu">
                                            <li><a href="<%=request.getContextPath()%>/listausuario">Usuarios</a></li>
                                            <li><a href="<%=request.getContextPath()%>/listaencargatura">Encargatura</a></li>
                                            <li><a href="<%=request.getContextPath()%>/listainterna">Organizacion Interna</a></li>
                                            <li><a href="<%=request.getContextPath()%>/listaexterna">Organizacion Externa</a></li>
                                            <li><a href="<%=request.getContextPath()%>/listaintext">Interna - Externa</a></li>
                                        </ul>
                                    </li>
                                </ul>   

                                <ul class="nav navbar-nav navbar-right">
                                    <li><a href="#"><span class="glyphicon glyphicon-user"></span> Cambiar Clave</a></li>
                                    <li><a href="<%=request.getContextPath()%>/logout"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
                                </ul>          

                            </div>                       
                        </nav>

                    </td>
                </tr>



                <%-- MENU DEL SISTEMA --%>

            </table>





            <%-- MENU DEL PENDIENTES --%>
            <table>
                <tr>
                    <td>
                        <div class="vertical-menu">
                            <table>  
                               
                               <a href="#" class="active">Menu Pendientes</a>
                                <a href="<%=request.getContextPath()%>/listarevisar">Documentos por Revisar &emsp;&emsp;&emsp;&emsp; <b><big><span class="glyphicon glyphicon-check"></span> <%=Nro_Pendiente_Revisar%> </big></b></a> 
                                <a href="<%=request.getContextPath()%>/listaFirmar">Documentos por Firmar &emsp;&emsp;&emsp;&emsp;&nbsp;&nbsp; <b><big><span class="glyphicon glyphicon-check"></span> <%=Nro_Pendiente_Firmar%> </big></b></a> 
                                <a href="<%=request.getContextPath()%>/listaRechazados">Documentos Rechazados &emsp;&emsp;&emsp;&nbsp;&nbsp; <b><big><span class="glyphicon glyphicon-check"></span> <%=Nro_Pendiente_Rechazar%> </big></b></a> 
                                <a href="<%=request.getContextPath()%>/listaBorrador">Documentos en Borrador &emsp;&emsp;&emsp;&nbsp;&nbsp;&nbsp; <b><big><span class="glyphicon glyphicon-check"></span> <%=Nro_Pendiente_Borrador%> </big></b></a>
                                <a href="<%=request.getContextPath()%>/listadocdec">Documentos Recibidos &emsp;&emsp;&emsp;&emsp;&nbsp;&nbsp;&nbsp;<b><big><span class="glyphicon glyphicon-check"></span> <%=Nro_Recibidos%> </big></b></a>  
                                
                                 
                            </table>     
                        </div>                
                    </td>

                    <td >
                       
                            <div align="center">
                            <object class="embed-responsive-item">
                              <video autoplay loop  width="1200" height="450">
                                <source src="<%= request.getContextPath()%>/video/GEDAD.mp4" />
                              </video>
                            </object>
                          </div>
                    </td>


                </tr>

            </table>




            <%-- MENU DEL PENDIENTES --%>
            <div class="modal fade" id="miModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title" id="myModalLabel">Avances GEDAD  del VIER 20 AL MIE 25 JULIO 18</h4>
                        </div>
                        
                        <div class="modal-body">
                             <table width="100%">
                                 <tr>
                                    <td><div class="form-group"><label for="txtDniOrden">1. LOGIN</label> </div> </td> 
                                    <td><div class="form-group"><label for="txtDniOrden"></label> </div> </td>    
                               </tr> 
                               <tr>
                                    <td><p><small>- Se cambia  a mayuscula al digital el usuario y visualiza la contraseña</small></p></td> 
                                     <td><p><small></small></p></td>                                 
                               </tr>
                                <tr>
                                    <td><p><small>-Valida el acceso mediante ALERT BOOTSTRAP</small></p></td> 
                                     <td><p><small></small></p></td>                                 
                               </tr>
                          
                               <tr>
                                    <td><div class="form-group"><label for="txtDniOrden">2. MENU PRINCIPAL</label> </div> </td> 
                                    <td><div class="form-group"><label for="txtDniOrden"></label> </div> </td>    
                               </tr> 
                               <tr>
                                    <td><p><small>- video informativo</small></p></td> 
                                    <td><p><small></small></p></td> 
                                   
                               </tr> 
                               <tr>
                                    <td><div class="form-group"><label for="txtDniOrden">3. FORMULAR OFICIO</label> </div> </td> 
                                    <td><div class="form-group"><label for="txtDniOrden"></label> </div> </td>    
                               </tr> 
                               <tr>
                                    <td><p><small> - Cambio de Tipo de letra "Century Gothic"</small></p></td> 
                                    <td><p><small></small></p></td>                                   
                               </tr>
                               <tr>
                                    <td><p><small>3.1 DISTRIBUCION</small></p></td> 
                                    <td><p><small></small></p></td>                                   
                               </tr>
                               <tr>
                                    <td><p><small>- Combo tipo Organizacion</small></p></td> 
                                    <td><p><small></small></p></td>                                   
                               </tr>
                               <tr>
                                    <td><p><small>- Agregar los destinatarios</small></p></td> 
                                    <td><p><small></small></p></td>                                   
                               </tr>
                               <tr>
                                    <td><p><small>- Eliminar los destinatarios</small></p></td> 
                                    <td><p><small></small></p></td>                                   
                               </tr>
                               <tr>
                                    <td><p><small>- Seleccionar y retornar al OFICIO</small></p></td> 
                                    <td><p><small></small></p></td>                                   
                               </tr>
                               <tr>
                                    <td><p><small>-3.2 VISTA PREVIA</small></p></td> 
                                    <td><p><small></small></p></td>                                   
                               </tr>
                               <tr>
                                    <td><p><small>-3.3 ENVIAR DOCUMENTO</small></p></td> 
                                    <td><p><small></small></p></td>                                   
                               </tr>
                               <tr>
                                   <td><p style="color: #9c3328"><small>-3.4 REFERENCIA (Ingresar,eliminar,buscar, retornar)* Falta</small></p></td> 
                                    <td><p><small></small></p></td>                                   
                               </tr>
                               <tr>
                                    <td><p style="color: #9c3328"><small>-3.5 DOCUMENTOS ANEXOS (Ingresar,eliminar,buscar,visualizar, retornar  **Falta)</small></p></td> 
                                    <td><p><small></small></p></td>                                   
                               </tr>
                                <tr>
                                    <td><div class="form-group"><label for="txtDniOrden">4. REVISAR OFICIO</label> </div> </td> 
                                    <td><div class="form-group"><label for="txtDniOrden"></label> </div> </td>    
                               </tr> 
                               <tr>
                                    <td><p><small>-Combo de las dependencia subordinadas</small></p></td> 
                                    <td><p><small></small></p></td>                                   
                               </tr>
                               <tr>
                                    <td><p><small>-Bandeja de los Documentos por Revisar</small></p></td> 
                                    <td><p><small></small></p></td>                                   
                               </tr>
                               <tr>
                                    <td><p><small>-Visualiza Documento por revisar </small></p></td> 
                                    <td><p><small></small></p></td>                                   
                               </tr>
                               <tr>
                                   <td><p style="color: #9c3328"><small>-4.1 DISTRIBUCION (Ingresar,eliminar,buscar, retornar)* Falta</small></p></td> 
                                    <td><p><small></small></p></td>                                   
                               </tr>
                               <tr>
                                   <td><p style="color: #9c3328"><small>-4.4 REFERENCIA (Ingresar,eliminar,buscar, retornar)* Falta</small></p></td> 
                                    <td><p><small></small></p></td>                                   
                               </tr>
                               <tr>
                                    <td><p style="color: #9c3328"><small>-4.5 DOCUMENTOS ANEXOS (Ingresar,eliminar,buscar,visualizar, retornar  **Falta)</small></p></td> 
                                    <td><p><small></small></p></td>                                   
                               </tr>
                                <tr>
                                    <td><p><small></small></p></td> 
                                    <td><p><small></small></p></td>                                   
                               </tr>
                                <tr>
                                   <td><p><small></small></p></td> 
                                    <td><p><small></small></p></td>                                   
                               </tr>
                               <tr>
                                   <td><p><small></small></p></td> 
                                    <td><p><small></small></p></td>                                   
                               </tr>
                               
                               </table>
                            
                            
                        </div>
                        
                    </div>
                </div>
            </div>
            <!--Fin de Cabecera --> 
            <!--Pie-->
            <div id="pie">
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center" valign="middle" bgcolor="#9A9FA3" height="7"></td>
                    </tr>
                    <tr>
                        <td height="66" align="center" valign="middle" bgcolor="#B7BCBF">
                            <div>DEPARTAMENTO DE SISTEMAS DE INFORMACIÓN - DESI</div>
                            <div>® 2018</div>
                            <div>Todos los Derechos Reservados</div>
                        </td>
                    </tr>
                </table>
            </div>
            <!--Pie-->

        </form>
    </body>
</html>