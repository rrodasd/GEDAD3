<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String alerta = "VACIO";
    if (request.getAttribute("mensaje") != null) {
        alerta = (String) request.getAttribute("mensaje");
    }


%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" href="<%= request.getContextPath()%>/NEW_STANDARES/css/bootstrap.css" />
        <link rel="stylesheet" href="<%= request.getContextPath()%>/NEW_STANDARES/css/estilos.css" media="all" />
        <script language="JavaScript" src="<%= request.getContextPath()%>/NEW_STANDARES/js/jquery-3.1.1.js"></script>
        <script language="JavaScript" src="<%= request.getContextPath()%>/NEW_STANDARES/js/bootstrap.min.js"></script>



        <meta charset="utf-8">
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
                <meta name="viewport" content="width=device-width, initial-scale=1">
                    <title>Gedad</title>

                    <!-- CSS -->
                    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Roboto:400,100,300,500">
                        <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.min.css">
                            <link rel="stylesheet" href="assets/font-awesome/css/font-awesome.min.css">
                                <link rel="stylesheet" href="assets/css/form-elements.css">
                                    <link rel="stylesheet" href="assets/css/style.css">


                                        <!-- Favicon and touch icons -->
                                        <link rel="shortcut icon" href="assets/ico/favicon.png">
                                            <link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets/ico/apple-touch-icon-144-precomposed.png">
                                                <link rel="apple-touch-icon-precomposed" sizes="114x114" href="assets/ico/apple-touch-icon-114-precomposed.png">
                                                    <link rel="apple-touch-icon-precomposed" sizes="72x72" href="assets/ico/apple-touch-icon-72-precomposed.png">
                                                        <link rel="apple-touch-icon-precomposed" href="assets/ico/apple-touch-icon-57-precomposed.png">




                                                            <title>GEDAD</title>
                                                            <script languaje="JavaScript">

                                                                function f_sesion() {

                                                                    var usuario = document.frm_Acceso.txtUsuario.value;
                                                                    var clave = document.frm_Acceso.txtClave.value;
                                                                    if (usuario === "") {
                                                                        alert("Ingrese Usuario!!!");
                                                                    } else if (clave === "") {
                                                                        alert("Ingrese Clave!!!");
                                                                    } else {
                                                                        document.frm_Acceso.action = "<%= request.getContextPath()%>/login";
                                                                        document.frm_Acceso.submit();
                                                                    }
                                                                }

                                                                function carga() {
                                                                    var mensaje = document.frm_Acceso.txtmensaje.value;
                                                                    if (mensaje !== "null") {
                                                                        $('#miModal').modal('show');
                                                                    }
                                                                    document.frm_Acceso.txtUsuario.focus;
                                                                }

                                                                function logeo() {
                                                                    var mensaje = document.frm_Acceso.txtmensaje.value;
                                                                    if (mensaje !== "null") {
                                                                        $('#miModal').modal('show');
                                                                    }
                                                                    document.frm_Acceso.txtUsuario.focus;
                                                                }

                                                            </script>    

                                                            </head>
                                                            <body onLoad="carga();">
                                                                <form name="frm_Acceso" method="post" action="login">
                                                                    <!-- Top content -->
                                                                    <div class="top-content">

                                                                        <div class="inner-bg">
                                                                            <div class="container">
                                                                                <div class="row">
                                                                                    <div class="col-sm-8 col-sm-offset-2 text">
                                                                                        <h1><strong>SISTEMA DE GESTIÓN ELECTRÓNICA DE DOCUMENTOS Y ARCHIVO DIGITAL </strong></h1>

                                                                                    </div>
                                                                                </div>
                                                                                <div class="row">
                                                                                    <div class="col-sm-6 col-sm-offset-3 form-box">
                                                                                        <div class="form-top">
                                                                                            <div class="form-top-left">
                                                                                                <h3></h3>
                                                                                                <h3>Inicie Sesión</h3>

                                                                                            </div>
                                                                                            <div class="form-top-right">
                                                                                                <i class="fa fa-lock"></i>
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="form-bottom">
                                                                                            <form role="form" action="" method="post" class="login-form">
                                                                                                <div class="form-group">
                                                                                                    <label class="sr-only" for="form-username">USUARIO</label>
                                                                                                    <input type="text" name="txtUsuario" placeholder="Usuario..." class="form-username form-control" id="form-username" onkeyup="javascript:this.value = this.value.toUpperCase();">
                                                                                                </div>
                                                                                                <div class="form-group">
                                                                                                    <label class="sr-only" for="form-password">CONTRASEÑA</label>
                                                                                                    <input type="password" name="txtClave" placeholder="Contraseña..." class="form-password form-control" id="form-password">
                                                                                                </div>
                                                                                                <button type="button" class="btn form-control" onclick="f_sesion()">INGRESAR</button>
                                                                                                <% if (alerta != "VACIO") {%>
                                                                                                <div class="alert alert-warning" id="messageUsuario" style="text-align: center;margin-bottom: 0px;padding-top: 5px;padding-bottom: 5px;padding-right: 8px;padding-left: 8px;">
                                                                                                    <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true" class="txt4" >&times;</span></button>
                                                                                                    <%= alerta%>
                                                                                                </div>
                                                                                                <% }%>

                                                                                            </form>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                                <div class="row">
                                                                                    <div class="col-sm-6 col-sm-offset-3 social-login">
                                                                                        <h3>DEPARTAMENTO DE SISTEMAS DE INFORMACIÓN - DESI</h3>

                                                                                        <div class="social-login-buttons">
                                                                                            <a class="btn btn-link-2" href="#">
                                                                                                <i class="fa fa-facebook"></i> Facebook
                                                                                            </a>
                                                                                            <a class="btn btn-link-2" href="#">
                                                                                                <i class="fa fa-twitter"></i> Twitter
                                                                                            </a>
                                                                                            <a class="btn btn-link-2" href="#">
                                                                                                <i class="fa fa-google-plus"></i> Google Plus
                                                                                            </a>
                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>
                                                                        </div>

                                                                    </div>


                                                                    <!-- Javascript -->
                                                                    <script src="assets/js/jquery-1.11.1.min.js"></script>
                                                                    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
                                                                    <script src="assets/js/jquery.backstretch.min.js"></script>
                                                                    <script src="assets/js/scripts.js"></script>

                                                                    <!--[if lt IE 10]>
                                                                        <script src="assets/js/placeholder.js"></script>
                                                                    <![endif]-->
                                                                </form>
                                                            </body>
                                                            </html>
