<%@page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@include file="cerrarSesion.jsp" %>
<%    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);

    ArrayList ListarUsuario = null;
    if (request.getAttribute("listaUsuario") != null) {
        ListarUsuario = (ArrayList) request.getAttribute("listaUsuario");
    }
    String codOrgEnc = (String) request.getAttribute("codOrgEnc");
    BeanUsuarioAD objBean = (BeanUsuarioAD) session.getAttribute("usuario");
%>

<%@page session="true"%>
<%@taglib uri="/WEB-INF/tlds/libreria.tld" prefix="lb"%>
<%@page import="sagde.bean.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Registro de Usuario</title>
    <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/estilos.css" />
    <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/bootstrap.css" />
    <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/bootstrap-select.min.css" />
    <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/bootstrap-datepicker.min.css" />
    <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/jquery.dataTables.min.css" />
    <script language="JavaScript" src="<%= request.getContextPath()%>/js/ValidacionesGenerales.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-3.1.1.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/js/bootstrap-select.min.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/js/bootstrap-datepicker.min.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/js/bootstrap-datepicker.es.min.js"></script>
    <script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript">

        var ctx_path = "<%= request.getContextPath()%>";

        $(document).ready(function () {
            $('#listaUsuario').DataTable();
            $('#cboEstado').selectpicker();
        });

        function f_ir(lugar) {
            document.frm_Manto.action = lugar;
            document.frm_Manto.submit();
        }

        function f_insertar() {
            document.frm_Manto.txh_Accion.value = "I";
            var reporte = "01";
            var internaEnc = document.frm_Manto.txh_codOrgEnc.value;
            var ruta = ctx_path.concat("/gedad/manto/I_Usuario_ajax.jsp?pasacache=", new Date().getTime(),
                    "&reporte=", reporte,
                    "&internaEnc=", internaEnc);
            $("#registro").load(ruta, function (status, xhr) {
                if (status === "error") {
                    var msg = "Error!, algo ha sucedido: ";
                    $("#registro").html(msg + xhr.status + " " + xhr.statusText);
                }
                $('#cbo_Interna').selectpicker();
                $('#cbo_Jefe').selectpicker();
            });
            $('#miModal').modal({backdrop: 'static', keyboard: false});
        }

        function f_cancelar() {
            $('#miModal').modal('hide');
            document.all.registro.innerHTML = "";
        }

        function f_agregar() {
            var reporte = "02";
            var hecho = document.frm_Manto.txh_Accion.value;
            var usuario = document.frm_Manto.txt_Usuario.value;
            var interna = document.frm_Manto.cbo_Interna.value;
            var cargo = btoa(document.frm_Manto.txt_Cargo.value);
            var jefe = document.frm_Manto.cbo_Jefe.value;
            var internaEnc = document.frm_Manto.txh_codOrgEnc.value;
            var estadoFiltro = document.frm_Manto.cboEstado.value;
            if (usuario === "") {
                alert("Usuario no válido!!!");
            } else if (interna === "000") {
                alert("Seleccione una Organización!!!");
                document.frm_Manto.cbo_Interna.focus();
            } else if (cargo === "") {
                alert("Ingrese Cargo!!!");
                document.frm_Manto.txt_Cargo.focus();
            } else if (jefe === "0") {
                alert("Seleccione Jefe!!!");
                document.frm_Manto.cbo_Jefe.focus();
            } else {
                var ruta = ctx_path.concat("/gedad/manto/I_Usuario_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte,
                        "&hecho=", hecho,
                        "&usuario=", usuario,
                        "&interna=", interna,
                        "&cargo=", cargo,
                        "&jefe=", jefe,
                        "&estadoFiltro=", estadoFiltro,
                        "&internaEnc=", internaEnc
                        );
                $("#lista").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#lista").html(msg + xhr.status + " " + xhr.statusText);
                    } else {
                        $('#listaUsuario').DataTable();
                        $('#miModal').modal('hide');
                        document.all.registro.innerHTML = "";
                        document.frm_Manto.txh_Accion.value = "";
                    }
                });
            }
        }

        function f_actualizar(usuario) {
            document.frm_Manto.txh_Accion.value = "A";
            var internaEnc = document.frm_Manto.txh_codOrgEnc.value;
            var reporte = "03";
            var ruta = ctx_path.concat("/gedad/manto/I_Usuario_ajax.jsp?pasacache=", new Date().getTime(),
                    "&reporte=", reporte,
                    "&usuario=", usuario,
                    "&internaEnc=", internaEnc
                    );
            $("#registro").load(ruta, function (status, xhr) {
                if (status === "error") {
                    var msg = "Error!, algo ha sucedido: ";
                    $("#registro").html(msg + xhr.status + " " + xhr.statusText);
                } else {
                    $('#miModal').modal({backdrop: 'static', keyboard: false});
                    $('#cbo_Interna').selectpicker();
                    $('#cbo_Jefe').selectpicker();
                    $('#cbo_Estado').selectpicker();
                }
            });
        }

        function f_listar(estadoFiltro) {
            var reporte = "02";
            var hecho = "L";
            var internaEnc = document.frm_Manto.txh_codOrgEnc.value;
            var ruta = ctx_path.concat("/gedad/manto/I_Usuario_ajax.jsp?pasacache=", new Date().getTime(),
                    "&reporte=", reporte,
                    "&estadoFiltro=", estadoFiltro,
                    "&hecho=", hecho,
                    "&internaEnc=", internaEnc
                    );
            $("#lista").load(ruta, function (status, xhr) {
                if (status === "error") {
                    var msg = "Error!, algo ha sucedido: ";
                    $("#lista").html(msg + xhr.status + " " + xhr.statusText);
                } else {
                    $('#listaUsuario').DataTable();
                }
            });
        }

        function f_modificar() {
            var reporte = "02";
            var hecho = document.frm_Manto.txh_Accion.value;
            var usuario = document.frm_Manto.txt_Usuario.value;
            var interna = document.frm_Manto.cbo_Interna.value;
            var cargo = btoa(document.frm_Manto.txt_Cargo.value);
            var jefe = document.frm_Manto.cbo_Jefe.value;
            var estado = document.frm_Manto.cbo_Estado.value;
            var estadoFiltro = document.frm_Manto.cboEstado.value;
            var internaEnc = document.frm_Manto.txh_codOrgEnc.value;
            if (interna === "000") {
                alert("Seleccione una Organizacion!!!");
                document.frm_Manto.cbo_Interna.focus();
            } else if (cargo === "") {
                alert("Ingrese Cargo!!!");
                document.frm_Manto.txt_Cargo.focus();
            } else if (jefe === "0") {
                alert("Seleccione Usuario Jefe!!!");
                document.frm_Manto.cbo_Jefe.focus();
            } else if (estado === "0") {
                alert("Seleccione Estado!!!");
                document.frm_Manto.cbo_Estado.focus();
            } else {
                var ruta = ctx_path.concat("/gedad/manto/I_Usuario_ajax.jsp?pasacache=", new Date().getTime(),
                        "&hecho=", hecho,
                        "&reporte=", reporte,
                        "&usuario=", usuario,
                        "&cargo=", cargo,
                        "&jefe=", jefe,
                        "&estado=", estado,
                        "&estadoFiltro=", estadoFiltro,
                        "&interna=", interna,
                        "&internaEnc=", internaEnc
                        );
                $("#lista").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#lista").html(msg + xhr.status + " " + xhr.statusText);
                    } else {
                        $('#listaUsuario').DataTable();
                        $('#miModal').modal('hide');
                        document.all.registro.innerHTML = "";
                    }
                });
            }
        }

        function f_cerrar_ModReg() {
            $('#miModal').modal('hide');
            document.all.registro.innerHTML = "";
            document.frm_Manto.txh_Accion.value = "";
        }

        function f_cerrar_ModBus() {
            $('#miModalBusqueda').modal('hide');
            document.all.busqueda.innerHTML = "";
        }

        function f_openBusqueda() {
            $('#miModalBusqueda').modal('show');
            var reporte = "04";
            var ruta = ctx_path.concat("/gedad/manto/I_Usuario_ajax.jsp?pasacache=", new Date().getTime(),
                    "&reporte=", reporte
                    );
            $("#busqueda").load(ruta, function (status, xhr) {
                if (status === "error") {
                    var msg = "Error!, algo ha sucedido: ";
                    $("#busqueda").html(msg + xhr.status + " " + xhr.statusText);
                }
            });
        }

        function f_Buscar_Persona() {
            var paterno = document.frm_Manto.txt_paternoB.value;
            var materno = document.frm_Manto.txt_maternoB.value;
            var nombres = document.frm_Manto.txt_nombresB.value;
            if (paterno === "" && materno === "" && nombres === "") {
                alert("Ingrese un parámetro de búsqueda");
            } else {
                var reporte = "05";
                var ruta = ctx_path.concat("/gedad/manto/I_Usuario_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte,
                        "&paterno=", paterno,
                        "&materno=", materno,
                        "&nombres=", nombres
                        );
                $("#listaBusPer").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#listaBusPer").html(msg + xhr.status + " " + xhr.statusText);
                    } else {
                        $('#listaPersona').DataTable();
                    }
                });
            }
        }

        function f_enviarDNI(dni) {
            $('#miModalBusqueda').modal('hide');
            document.frm_Manto.txt_paternoB.value = "";
            document.frm_Manto.txt_maternoB.value = "";
            document.frm_Manto.txt_nombresB.value = "";
            document.all.listaBusPer.innerHTML = "&nbsp;";
            document.frm_Manto.txt_DniB.value = dni;
            f_Buscar();
        }

        function f_Buscar() {
            var dni = document.frm_Manto.txt_DniB.value;
            if (dni === "") {
                alert("Ingrese un DNI!!!");
            } else if (dni.length < 8) {
                alert("Ingrese un DNI válido!!!");
            } else {
                var reporte = "06";
                var ruta = ctx_path.concat("/gedad/manto/I_Usuario_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte,
                        "&dni=", dni
                        );
                $("#rpta_bus").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#rpta_bus").html(msg + xhr.status + " " + xhr.statusText);
                    } else {
                        var existe = document.frm_Manto.txh_Existe.value;
                        if (existe === "S") {
                            document.frm_Manto.txh_Accion.value = "AO";
                        }
                    }
                });
            }
        }

    </script>

    <body>
        <form name="frm_Manto" method="post" action="">
            <input type="hidden" name="txh_Accion" />
            <input type="hidden" name="txh_codOrgEnc" value="<%=codOrgEnc%>"/>

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
                                    <span class="glyphicon glyphicon-user" style="color:rgb(217, 81, 77);">&nbsp;<b><i>Usuario:</i>&nbsp;<%=objBean.getVUSUARIO_CARGO()%></b></span> 

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
                                    <a class="navbar-brand" href="#">USUARIO</a>
                                </div>
                                <ul class="nav navbar-nav navbar-right">
                                    <li><a href="<%=request.getContextPath()%>/menu"><span class="glyphicon glyphicon-log-in"></span> Home</a></li>
                                </ul>
                            </div>                       
                        </nav>
                    </td>
                </tr>    
            </table>
            <%-- TERMINO  CABECERA --%>

            <!--Inicio Tabla Bandeja-->
            <table width="100%" border="0">
                <tr>
                    <td width="10%" valign="top" style="background-color: #cdcec8" >
                        <div align="center">
                            <table width="90%">
                                <tr>                                             
                                    <td>
                                        <select name="cboEstado" id="cboEstado" onchange="f_listar(this.value)" class="form-control selectpicker" data-style="btn-info" data-live-search="true">
                                            <option value="SIN_FILTRO">--- Seleccione Estado---</option>
                                            <option value="A">Activo</option>
                                            <option value="B">Bloqueado</option>
                                        </select> 
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                    <td valign="top">
                        <div align="center" id="lista">
                            <table class="display" border="1" id="listaUsuario">
                                <thead>
                                    <tr bgcolor="#B0B199">
                                        <th width="20%"><div align="center">CODIGO O.I.</div></th>
                                        <th width="10%"><div align="center">ORGANIZACIÓN</div></th>
                                        <th width="10%"><div align="center">USUARIO</div></th>
                                        <th width="10%"><div align="center">GRADO</div></th>
                                        <th width="10%"><div align="center">ARMA</div></th>
                                        <th width="20%"><div align="center">APELLIDOS Y NOMBRES</div></th>
                                        <th width="20%"><div align="center">CARGO QUE OCUPA</div></th>                                        
                                        <th width="5%">&nbsp;</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < ListarUsuario.size(); i++) {
                                            BeanUsuarioAD objBeanUAD = (BeanUsuarioAD) ListarUsuario.get(i);
                                            if (objBeanUAD.getVARMAS_DESCOR() == null) {
                                                objBeanUAD.setVARMAS_DESCOR("");
                                            }
                                            if (objBeanUAD.getCGRADO_DESCCORT() == null) {
                                                objBeanUAD.setCGRADO_DESCCORT("");
                                            }
                                    %>
                                    <tr>
                                        <td><div align="center"><%=objBeanUAD.getCUSUARIO_COD_ORG()%></div></td>
                                        <td><%=objBeanUAD.getVOINTERNA_NOM_CORTO()%></td>
                                        <td bgcolor="#CCD272" ><div align="center"><%=objBeanUAD.getVUSUARIO_CODIGO()%></div></td>
                                        <td><%=objBeanUAD.getCGRADO_DESCCORT()%></td>
                                        <td><%=objBeanUAD.getVARMAS_DESCOR()%></td>
                                        <td><%=objBeanUAD.getAPENOM()%></td>
                                        <td><%=objBeanUAD.getVUSUARIO_CARGO()%></td>
                                        <td><div align="center"><a href="javascript:f_actualizar('<%=objBeanUAD.getVUSUARIO_CODIGO()%>');"><img src="<%= request.getContextPath()%>/imagenes/icono/modificar.jpg" height="25px" width="25px" alt="Editar" /></a></div></td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
                        </div>
                    </td>
                    <td width="10%" valign="top">
                        <div align="center">
                            <table width="90%" border="0">
                                <tr>
                                    <td height="63">
                                        <div align="center">
                                            <input type="button" class="btn btn-primary btn-block" value="Nuevo" onclick="f_insertar()" />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
            <!--Fin Tabla Bandeja-->

            <!--Inicio Modal Registro-->
            <div class="modal fade" id="miModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color:rgb(91, 192, 222)">
                            <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Detalle de Usuario</b></span>
                            <a href="javascript:f_cerrar_ModReg();"><p style="color:rgb(240, 235, 235);" align="right"><b><i>Cerrar</i></b>&nbsp;<span class="glyphicon glyphicon-remove"></span></p></a>
                        </div>
                        <div class="modal-body" id="registro">

                        </div>
                    </div>
                </div>
            </div>
            <!--Fin Modal-->

            <!--Inicio Modal Registro-->
            <div class="modal fade" id="miModalBusqueda" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color:rgb(76, 175, 80)">
                            <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Busqueda de Persona</b></span>
                            <a href="javascript:f_cerrar_ModBus();"><p style="color:rgb(240, 235, 235);" align="right"><b><i>Cerrar</i></b>&nbsp;<span class="glyphicon glyphicon-remove"></span></p></a>
                        </div>
                        <div class="modal-body" id="busqueda">
                        </div>
                    </div>
                </div>
            </div>
            <!--Fin Modal-->

            <!-- -->
            <div class="modal fade" id="modalMensaje" role="dialog">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal">&times;</button>
                            <h4 class="modal-title">Alerta</h4>
                        </div>
                        <div class="modal-body">
                            <p>This is a small modal.</p>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                        </div>
                    </div>
                </div>
            </div>
            </div>
            <!-- -->
            <!--Pie-->
            <div id="pie">
                <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center" valign="middle" bgcolor="#9A9FA3" height="7"></td>
                    </tr>
                    <tr>
                        <td height="66" align="center" valign="middle" bgcolor="#B7BCBF">
                            <div>DEPARTAMENTO DE DESARROLLO DE SISTEMAS - DESIS</div>
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