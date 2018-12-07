<%@page import="sagde.bean.BeanPrioridadDocumento"%>
<%@page import="sagde.bean.BeanClase"%>
<%@page import="sagde.bean.BeanOrganizacionInterna"%>
<%@page import="sagde.bean.BeanPeriodo"%>
<%@page import="sagde.bean.BeanDocumento1"%>
<%@page import="comun.RevisaDocumentoDAO"%>
<%@page import="comun.DAOFactory"%>
<%@page import="sagde.bean.BeanArchivo"%>
<%@page import="comun.ComboboxDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="sagde.bean.BeanUsuarioAD"%>
<%@ page import="sagde.bean.BeanRevisarDocumento"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="/WEB-INF/tlds/libreria.tld" prefix="lb" %>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c" %>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>Documentos Por Revisar</title>

        <!-- HOJAS DE ESTILOS -->
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/estilos.css" />
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/bootstrap.css" />
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/bootstrapOF.css" />
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/jquery.dataTables.min.css" />
        <!--
    <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/bootstrap.min.css" />     
        -->
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/bootstrap-select.min.css" />
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/bootstrap-datepicker.min.css" /> 

        <!-- SCRIPTS -->
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.min.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-3.1.1.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js" ></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/bootstrap-select.min.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/pe.mil.ejercito.commons.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/pe.mil.ejercito.constants.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/bootstrap-datepicker.min.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/bootstrap-datepicker.es.min.js"></script> 
        <%
            BeanUsuarioAD objBeanU = (BeanUsuarioAD) session.getAttribute("usuario");
            String Cod_jefe_unidad = objBeanU.getJEFE_UNIDAD();
            DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
            ComboboxDAO objCombobox = objDAOFactory.getComboboxDAO();
            RevisaDocumentoDAO objRD = objDAOFactory.getRevisaDocumentoDAO();
        %>
        
        <style type="text/css">
            .red {
                background-color: red !important;
            }

            .orange {
                background-color: orange !important;
            }
            
            #miModalVerAnexos {
                top:2%;
                right: 10%;
                outline: none;
               	
            }
        </style>
        <!--     FIN LIBRERIAS ESTANDAR   -->  
        <script>

            /*
             * @JavaScript para Boostrap
             */
            $(document).ready(function () {
                $('#listaMP').DataTable({
                    
                     "fnRowCallback": function (row, data, dataIndex) {
                        if (data[8] === "<div align=\"center\">MUY URGENTE</div>") { 
                            $(row).addClass('red');
                        }
                        if (data[8] === "<div align=\"center\">URGENTE</div>") {
                            $(row).addClass('orange');
                        }
                    }
                   
                });

                //dar formato a la fecha            
                $('.datepicker').datepicker({format: "dd/mm/yyyy",
                    maxViewMode: 2,
                    todayBtn: "linked",
                    language: "es",
                    daysOfWeekHighlighted: "0,6",
                    calendarWeeks: true,
                    autoclose: true,
                    todayHighlight: true
                });

                $('.selectpicker').selectpicker({style: 'btn-info', size: 10});
            });


            /*
             * Funciones 
             */

            var ctx_path = "<%= request.getContextPath()%>";

            // Mostrar y Ocultar Capas
            function mostrar(nombreCapa) {
                document.getElementById(nombreCapa).style.visibility = "visible";
            }

            function ocultar(nombreCapa) {
                document.getElementById(nombreCapa).style.visibility = "hidden";
            }

        </script>

        <script type="text/javascript">

            /*
             @Funcion f_insertar: Abre el modal limpio
             */
            function f_insertar() {
                document.all.txt_Nro_Orden.value = "";
                document.all.txt_Clave_Indic.value = "";
                document.all.txt_fecha_MP.value = "";
                document.all.txt_Asunto_MP.value = "";
                document.all.url_anexo_revisar.value = "";
                $('#miModalRegDoc').modal({backdrop: 'static', keyboard: false});
            }

            /*
             @Funcion f_DIS retorna en el combo organizacion de acuerdo al tipo de organizacion
             */
            function f_DIS(tipo) {
                var reporte = "REG_DOC_01";
                if (window.XMLHttpRequest) {
                    ajaxDO = new XMLHttpRequest();
                } else {
                    ajaxDO = new ActiveXObject("Microsoft.XMLHTTP");
                }
                ajaxDO.onreadystatechange = funcionCallbackDO;
                var ruta = "<%= request.getContextPath()%>/gedad/registrardoc/I_Registrar_Documentos_ajax.jsp?pasacache=" + new Date().getTime() + "&reporte=" + reporte + "&tipo=" + tipo;
                ajaxDO.open("GET", ruta, true);
                ajaxDO.send("");
            }

            var ajaxDO = null;
            function funcionCallbackDO() {
                if (ajaxDO.readyState === 4 && ajaxDO.status === 200) {
                    document.all.dis_org.innerHTML = ajaxDO.responseText;
                    $('.selectpicker').selectpicker({style: 'btn-info', size: 10});
                }
            }

          
            /* 
             * f_Grabar_Documento. Graba los documentos en Mesa de Parte 
             */

            function f_Grabar_Documento() {
                var cbo_Periodo = document.all.cbo_Periodo.value;
                var cbo_Tipo_Organizacion = document.all.cbo_Tipo_Organizacion.value;
                var org = document.all.org.value;
                var cbx_Clase_Doc = document.all.cbx_Clase_Doc.value;
                var txt_Nro_Orden = document.all.txt_Nro_Orden.value;
                var txt_Clave_Indic = document.all.txt_Clave_Indic.value;
                var txt_fecha_MP = document.all.txt_fecha_MP.value;
                var txt_Asunto_MP = btoa(document.all.txt_Asunto_MP.value);
                var cbx_tipo_distri = document.all.cbx_tipo_distri.value;
                var cbx_Prioridad = document.all.cbx_Prioridad.value;

                if (document.all.cbo_Periodo.value == "") {
                    document.all.cbo_Periodo.focus();
                    alert("Ingrese el Periodo");
                } else if (document.all.cbo_Tipo_Organizacion.value == "") {
                    document.all.cbo_Tipo_Organizacion.focus();
                    alert("Ingrese la Procedencia del Documento");
                } else if (document.all.txt_Nro_Orden.value == "") {
                    document.all.txt_Nro_Orden.focus();
                    alert("Ingrese el Nro de documento");
                } else if (document.all.txt_Clave_Indic.value == "") {
                    document.all.txt_Clave_Indic.focus();
                    alert("Ingrese el Indicativo del documento");
                } else if (document.all.txt_fecha_MP.value == "") {
                    document.all.txt_fecha_MP.focus();
                    alert("Ingrese la Fecha del Documento");
                } else if (document.all.txt_Asunto_MP.value == "") {
                    document.all.txt_Asunto_MP.focus();
                    alert("Ingrese el asunto del Documento");
                } else if (document.all.cbx_tipo_distri.value == "") {
                    document.all.cbx_tipo_distri.focus();

                } else if (document.all.cbx_Prioridad.value == "") {
                    document.all.cbx_Prioridad.focus();
                } else {
                    var accion = "insertar_MP";
                    var frm_documento = $("#frm_documento")[0];
                    frm_documento.action = ctx_path.concat("/GrabarMP?cbo_Periodo=" + cbo_Periodo +
                            "&cbo_Tipo_Organizacion=" + cbo_Tipo_Organizacion +
                            "&org=" + org +
                            "&cbx_Clase_Doc=" + cbx_Clase_Doc +
                            "&txt_Nro_Orden=" + txt_Nro_Orden +
                            "&txt_Clave_Indic=" + txt_Clave_Indic +
                            "&txt_fecha_MP=" + txt_fecha_MP +
                            "&txt_Asunto_MP=" + txt_Asunto_MP +
                            "&cbx_tipo_distri=" + cbx_tipo_distri +
                            "&cbx_Prioridad=" + cbx_Prioridad +
                            "&accion=" + accion);
                    frm_documento.submit();
                    
                    alert("Se ingresó satisfactoriamente");
                    $('#miModalRegDoc').modal('hide');
              
                    
                    var reporte = "REG_DOC_02";
                    if (window.XMLHttpRequest) {
                        ajaxLista = new XMLHttpRequest();
                    } else {
                        ajaxLista = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    ajaxLista.onreadystatechange = funcionCallbackLista;
                    var ruta = "<%= request.getContextPath()%>/gedad/registrardoc/I_Registrar_Documentos_ajax.jsp?pasacache=" + new Date().getTime() + "&reporte=" + reporte;
                    ajaxLista.open("GET", ruta, true);
                    ajaxLista.send("");                    
                    //setTimeout(funcionCallbackLista, 1000);

                }

            }
            
             function f_actualizar(periodo,cod_int,tipo_orig,cod_org,clase,nro_orden,indic,fecha,asunto,tipo_dist,prioridad) {             
                $('#miModalRegDoc').modal({backdrop: 'static', keyboard: false});                          

               var reporte = "REG_DOC_06";
                if (window.XMLHttpRequest) {
                    ajaxActMP = new XMLHttpRequest();
                } else {
                    ajaxActMP = new ActiveXObject("Microsoft.XMLHTTP");
                }
                ajaxActMP.onreadystatechange = funcionCallbackActualizaMP;
                var ruta = "<%= request.getContextPath()%>/gedad/registrardoc/I_Registrar_Documentos_ajax.jsp?pasacache=" + new Date().getTime() +
                                                          "&reporte=" + reporte+
                                                          "&periodo=" + periodo+
                                                          "&cod_int=" + cod_int+
                                                          "&tipo_orig=" + tipo_orig+
                                                          "&cod_org=" + cod_org+
                                                          "&clase=" + clase+
                                                          "&nro_orden=" + nro_orden+
                                                          "&indic=" + indic+
                                                          "&fecha=" + fecha+
                                                          "&asunto=" + asunto+
                                                          "&tipo_dist=" + tipo_dist+
                                                          "&prioridad=" + prioridad;
                ajaxActMP.open("GET", ruta, true);
                ajaxActMP.send(""); 
                
            }
            
               var ajaxActMP = null;
            function funcionCallbackActualizaMP() {
                if (ajaxActMP.readyState === 4 && ajaxActMP.status === 200) {
                    document.all.registro_MP.innerHTML = ajaxActMP.responseText; 
                      $('.selectpicker').selectpicker({style: 'btn-info', size: 10});

                }
            }
            

            var ajaxLista = null;
            function funcionCallbackLista() {
                if (ajaxLista.readyState === 4 && ajaxLista.status === 200) {
                    document.all.lista.innerHTML = ajaxLista.responseText;
                   $('#example').DataTable({
                    "fnRowCallback": function (row, data, dataIndex) {
                        if (data[8] === "<div align=\"center\">MUY URGENTE</div>") { 
                            $(row).addClass('red');
                        }
                        if (data[8] === "<div align=\"center\">URGENTE</div>") {
                            $(row).addClass('orange');
                        }
                    }
                });

                }
            }



            function f_verPDF(periodo, cod_int, tipo_org, organizacion_jefe, token) {
                if (token === "null") {
                    alert("No tiene Documento Registrado");
                } else {
                    $('#miModalVerMP').modal('show');
                    var reporte = "REG_DOC_03";

                    if (window.XMLHttpRequest) {
                        ajaxverPDF_MP = new XMLHttpRequest();
                    } else {
                        ajaxverPDF_MP = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    ajaxverPDF_MP.onreadystatechange = funcionCallbackVerPDF_MP;

                    var ruta = "<%= request.getContextPath()%>/gedad/registrardoc/I_Registrar_Documentos_ajax.jsp?pasacache=" + new Date().getTime() +
                            "&reporte=" + reporte +
                            "&periodo=" + periodo +
                            "&cod_int=" + cod_int +
                            "&tipo_org=" + tipo_org +
                            "&organizacion_jefe=" + organizacion_jefe +
                            "&token=" + token;
                    ajaxverPDF_MP.open("GET", ruta, true);
                    ajaxverPDF_MP.send("");
                }
            }

            var ajaxverPDF_MP = null;
            function funcionCallbackVerPDF_MP() {
                if (ajaxverPDF_MP.readyState === 4 && ajaxverPDF_MP.status === 200) {
                    document.all.modalMostarMP.innerHTML = ajaxverPDF_MP.responseText;

                }
            }


            /**
             * f_openAnexoVentana::. Abre el Modal de Anexos
             * @returns {undefined}
             */
            function f_openAnexoVentana(periodo, cod_interno) {
                $('#miModalAnexo').modal({backdrop: 'static', keyboard: false});
                var reporte = "REG_DOC_05";
                if (window.XMLHttpRequest) {
                    ajaxLista_Anexos = new XMLHttpRequest();
                } else {
                    ajaxLista_Anexos = new ActiveXObject("Microsoft.XMLHTTP");
                }
                ajaxLista_Anexos.onreadystatechange = funcionCallbackLista_Anexos;

                var ruta = "<%= request.getContextPath()%>/gedad/registrardoc/I_Registrar_Documentos_ajax.jsp?pasacache=" + new Date().getTime() +
                        "&reporte=" + reporte +
                        "&periodo=" + periodo +
                        "&cod_interno=" + cod_interno;
                ajaxLista_Anexos.open("GET", ruta, true);
                ajaxLista_Anexos.send("");

            }

            var ajaxLista_Anexos = null;
            function funcionCallbackLista_Anexos() {
                if (ajaxLista_Anexos.readyState === 4 && ajaxLista_Anexos.status === 200) {
                    document.all.modalAnexos.innerHTML = ajaxLista_Anexos.responseText;
                    $('#table_anexos').DataTable();
                }
            }

            function f_InsertarAnexos() {
                document.all.txh_accion_anexos.value = "insertar_anexos";
                alert(document.all.txh_accion_anexos.value);
                mostrar("capa_add_anexos");
            }

            function f_Grabar_Anexos() {
                var accion_anexos = document.all.txh_accion_anexos.value;
                var periodo_anexo = document.all.txh_perido_anexos.value;
                alert(periodo_anexo);
                var cod_int_anexos = document.all.txh_codinter_anexos.value;
                var sec_anexos = document.all.txh_secuencia_anexos.value;
                var file_anexos = document.all.txh_archivo_anexos.value;

                var frm_anexos = $("#frm_anexos")[0];

                if (accion_anexos == "insertar_anexos") {
                    frm_anexos.action = ctx_path.concat("/capturaAnexos_RD?cod_interno=" + cod_int_anexos + "&accion=" + accion_anexos+"&periodo=" + periodo_anexo);
                    frm_anexos.submit();

                    alert("Se Grabò exitosamente");

                    var reporte = "REG_DOC_05";
                    if (window.XMLHttpRequest) {
                        ajaxLista_Anexos = new XMLHttpRequest();
                    } else {
                        ajaxLista_Anexos = new ActiveXObject("Microsoft.XMLHTTP");
                    }

                    ajaxLista_Anexos.onreadystatechange = funcionCallbackLista_Anexos;

                    var ruta = "<%= request.getContextPath()%>/gedad/registrardoc/I_Registrar_Documentos_ajax.jsp?pasacache=" + new Date().getTime() +
                            "&reporte=" + reporte +
                            "&periodo=" + periodo_anexo +
                            "&cod_interno=" + cod_int_anexos;
                    ajaxLista_Anexos.open("GET", ruta, true);
                    ajaxLista_Anexos.send("");

                } else if (accion_anexos == "actualizar_anexos") {
                    frm_anexos.action = ctx_path.concat("/capturaAnexos_RD?cod_interno=" + cod_int_anexos + "&accion=" + accion_anexos + "&periodo_anexo=" + periodo_anexo + "&sec_anexos=" + sec_anexos);
                    frm_anexos.submit();
                    alert("Se Actualizó exitosamente");

                    var reporte = "REG_DOC_05";
                    if (window.XMLHttpRequest) {
                        ajaxLista_Anexos = new XMLHttpRequest();
                    } else {
                        ajaxLista_Anexos = new ActiveXObject("Microsoft.XMLHTTP");
                    }

                    ajaxLista_Anexos.onreadystatechange = funcionCallbackLista_Anexos;

                    var ruta = "<%= request.getContextPath()%>/gedad/registrardoc/I_Registrar_Documentos_ajax.jsp?pasacache=" + new Date().getTime() +
                            "&reporte=" + reporte +
                            "&periodo=" + periodo_anexo +
                            "&cod_interno=" + cod_int_anexos;
                    ajaxLista_Anexos.open("GET", ruta, true);
                    ajaxLista_Anexos.send("");
                }
            }


           
            
            
            function f_CapturaAnexos(periodo, docinterno, secuencia, nombre_archivo) {
                document.all.txh_perido_anexos.value = periodo;
                document.all.txh_codinter_anexos.value = docinterno;
                document.all.txh_secuencia_anexos.value = secuencia;
                document.all.txh_archivo_anexos.value = nombre_archivo;
            }

            function f_MostraAnexos() {
             
                $('#miModalVerAnexos').modal('show');              
                document.all.txh_accion_anexos.value = "mostar_anexos";                
                if (document.all.txh_secuencia_anexos.value != "") {
                    var txh_perido_anexos = document.all.txh_perido_anexos.value;
                    var txh_codinter_anexos = document.all.txh_codinter_anexos.value;
                    var txh_secuencia_anexos = document.all.txh_secuencia_anexos.value;
                    var txh_archivo_anexos = document.all.txh_archivo_anexos.value;

                    var reporte = "ANEX_03";
                    if (window.XMLHttpRequest) {
                        ajaxverAnexos = new XMLHttpRequest();
                    } else {
                        ajaxverAnexos = new ActiveXObject("Microsoft.XMLHTTP");
                    }

                    ajaxverAnexos.onreadystatechange = funcionCallbackVerAnexos;
                    var extension = txh_archivo_anexos.split(".")[1];
                    if (extension === "doc" || extension === "xls" || extension === "ppt" || extension === "docx" || extension === "xlsx" || extension === "pptx" || extension === "mp4" || extension === "avi") {
                        $('#miModalVerAnexos').modal('hide');
                    }

                    var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_Anexos_ajax.jsp?pasacache=" + new Date().getTime() +
                            "&reporte=" + reporte +
                            "&txh_perido_anexos=" + txh_perido_anexos +
                            "&txh_codinter_anexos=" + txh_codinter_anexos +
                            "&txh_secuencia_anexos=" + txh_secuencia_anexos +
                            "&txh_archivo_anexos=" + txh_archivo_anexos;
                    ajaxverAnexos.open("GET", ruta, true);
                    ajaxverAnexos.send("");

                } else {
                    alert("Debe Selecionar el Archivo Adjunto!::");
                }
            }


            var ajaxverAnexos = null;
            function funcionCallbackVerAnexos() {
                if (ajaxverAnexos.readyState === 4 && ajaxverAnexos.status === 200) {
                    document.all.modalMostarAnexos.innerHTML = ajaxverAnexos.responseText;

                }
            }


            

            function eliminar(periodo, cod_int) {
                
                var answer = confirm("Deseas eliminar este registro?")
                if (answer){
                      var reporte = "REG_DOC_04";
                        if (window.XMLHttpRequest) {
                            ajaxLista = new XMLHttpRequest();
                        } else {
                            ajaxLista = new ActiveXObject("Microsoft.XMLHTTP");
                        }

                        ajaxLista.onreadystatechange = funcionCallbackLista;

                        var ruta = "<%= request.getContextPath()%>/gedad/registrardoc/I_Registrar_Documentos_ajax.jsp?pasacache=" + new Date().getTime() +
                                "&reporte=" + reporte +
                                "&periodo=" + periodo +
                                "&cod_int=" + cod_int;
                        ajaxLista.open("GET", ruta, true);
                        ajaxLista.send("");
                }
                else{
                    
                }
                /*
                $('#eliminar').submit(function(e){
                    BootstrapDialog.confirm('Hi Apple, are you sure?', function(result){
                           if(!result) {
                              return false;
                           }
                    }); 
               });
               */ 
                
              
            }


            //CERRAR LOS MODALES           
            function f_cancelar() {
                $('#miModalRegDoc').modal('hide');
            }

            function f_cerrar_moObs() {
                $('#miModalRegDoc').modal('hide');
            }
            function f_cerrar_moAnexos() {
                $('#miModalAnexo').modal('hide');
                document.all.txh_accion_anexos.value = "";
            }
            
            function f_cerrar_moMP() {
                $('#miModalVerMP').modal('hide');
              
            }
              function f_cerrar_verAnexos() {
                $('#miModalVerAnexos').modal('hide');
            }
            
            

        </script>
    </head>

    <body>
        <form name="frm_Manto" method="post" action=""> 
            <input name="txh_accion_anexos" type="hidden"  />

            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="background-color:#D4FD89">
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

                            <tr>
                                <td height="30" align="center" valign="middle" bgcolor="#eeeeee">
                                    <span class="glyphicon glyphicon-user" style="color:rgb(217, 81, 77);">&emsp;&emsp;<b><i>Usuario :</i><%=objBeanU.getVUSUARIO_CARGO()%></b></span> 

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
                                    <a class="navbar-brand" href="#">MESA DE PARTE </a>
                                </div>                          

                                <ul class="nav navbar-nav navbar-right">
                                    <li><a href="<%=request.getContextPath()%>/menu"><span class="glyphicon glyphicon-log-in"></span> Home</a></li>
                                </ul>          

                            </div>                       
                        </nav>

                    </td>
                </tr>    
            </table>

            <%--TABLA DE COLECCION  --%>     
            <!--Inicio Tabla Bandeja-->

            <table width="100%" border="0" style="background-color:#DDE9E4">
                <tr>
                    <td width="10%">&nbsp;</td>
                    <td width="70%">
                        <div align="center" id="lista">
                            <table class="display" width="100%" border="1" id="listaMP">
                                <thead>
                                    <tr bgcolor="#B0B199">                                      
                                        <th width="5%"><div align="center">AÑO</div></th>
                                        <th width="5%"><div align="center">FECHA_REG</div></th>
                                        <th width="5%"><div align="center">CODIGO GEDAD</div></th>                                        
                                        <th width="5%"><div align="center">DEP ORIGEN</div></th>
                                        <th width="5%"><div align="center">CLASE</div></th>
                                        <th width="5%"><div align="center">NRO. DOC</div></th>
                                        <th width="10%"><div align="center">FECHA DOC</div></th>
                                        <th width="10"><div align="center">ASUNTO_DEL_DOCUMENTO</div></th>
                                        <th width="10"><div align="center">PRIORIDAD</div></th>
                                        <th width="10"><div align="center">TIPO DISTRIBUCIÓN</div></th>
                                        <th width="10%"><div align="center">ACTUALIZAR</div></th>
                                        <th width="10%"><div align="center">VER DOC</div></th>
                                        <th width="5%"><div align="center">VER ANEXO</div></th>                                         
                                        <th width="5%"><div align="center">ELIMINAR</div></th>    

                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        ArrayList ListarDocMP = null;
                                        if (request.getAttribute("listardocumento") != null) {
                                            ListarDocMP = (ArrayList) request.getAttribute("listardocumento");
                                        }

                                        for (int i = 0; i < ListarDocMP.size(); i++) {
                                            BeanDocumento1 objBeanC = (BeanDocumento1) ListarDocMP.get(i);
                                            String prioridad = objBeanC.getCDOCUMENTO_PRIORIDAD();
                                            System.out.println("la priorodad es:: " + prioridad);

                                    %>
                                    <tr >

                                        <td><div align="center"><%=objBeanC.getCDOCUMENTO_PERIODO()%></div></td>
                                        <td><div align="center"><%=objBeanC.getDDOCUMENTO_FEC_ACT()%></div></td>
                                        <td bgcolor="#CCD272" ><div align="center"><%=objBeanC.getCDOCUMENTO_COD_DOC_INT()%></div></td>
                                        <td><div align="center"><%=objBeanC.getCDOCUMENTO_COD_ORG_ORIG()%></div></td>
                                        <td><div align="center"><%=objBeanC.getCDOCUMENTO_CLASE()%></div></td>
                                        <td><div align="center"><%=objBeanC.getCDOCUMENTO_NRO_ORDEN()%></div></td>
                                        <td><div align="center"><%=objBeanC.getDDOCUMENTO_FECHA()%></div></td>
                                        <td><div align="center"><%=objBeanC.getVDOCUMENTO_ASUNTO()%></div></td> 
                                        <td><div align="center"><%=objBeanC.getCDOCUMENTO_PRIORIDAD()%></div></td> 
                                         <td><div align="center"><%=objBeanC.getCDISTRIBUCION_TIPO_DISTRIB()%></div></td> 
                                        <td  width="200px"><div align="center">  <a href="javascript:f_actualizar('<%=objBeanC.getCDOCUMENTO_PERIODO()%>',
                                                                                                                  '<%=objBeanC.getCDOCUMENTO_COD_DOC_INT()%>',
                                                                                                                  '<%=objBeanC.getCDOCUMENTO_TIPO_ORG_ORIG()%>',
                                                                                                                  '<%=objBeanC.getCDOCUMENTO_COD_ORG_DEP()%>',
                                                                                                                  '<%=objBeanC.getCCLASE_CODIGO()%>',
                                                                                                                  '<%=objBeanC.getCDOCUMENTO_NRO_ORDEN()%>',
                                                                                                                  '<%=objBeanC.getVDOCUMENTO_CLAVE_INDIC()%>',                                                                                                                
                                                                                                                  '<%=objBeanC.getDDOCUMENTO_FECHA()%>',
                                                                                                                  '<%=objBeanC.getVDOCUMENTO_ASUNTO()%>',
                                                                                                                  '<%=objBeanC.getCDISTRIBUCION_TIPO_DISTRIB()%>',
                                                                                                                  '<%=objBeanC.getCPRIORIDAD_CODIGO()%>'                                                                                                                                                                                                                                  
                                                                                                                  );">ACTUALIZAR
                                                                                </a></div>
                                        </td> 
                                        <td><div align="center">  
                                                <%if (objBeanC.getVDISTRIBUCION_TOKEN() == null) {
                                                %>
                                                <a href="javascript:f_verPDF('<%=objBeanC.getCDOCUMENTO_PERIODO()%>','<%=objBeanC.getCDOCUMENTO_COD_DOC_INT()%>','I','<%=objBeanU.getJEFE_UNIDAD()%>','<%=objBeanC.getVDISTRIBUCION_TOKEN()%>');">
                                                    <img src="imagenes/icono/noexiste.png" width="35" height="35" border="0" /></a>

                                                <%} else {%>
                                                <a href="javascript:f_verPDF('<%=objBeanC.getCDOCUMENTO_PERIODO()%>','<%=objBeanC.getCDOCUMENTO_COD_DOC_INT()%>','I','<%=objBeanU.getJEFE_UNIDAD()%>','<%=objBeanC.getVDISTRIBUCION_TOKEN()%>');">
                                                    <img src="imagenes/icono/pdf.png" width="35" height="35" border="0" /></a>

                                                <%}%>
                                            </div>
                                        </td> 
                                        <td><div align="center">   
                                                <a href="javascript:f_openAnexoVentana('<%=objBeanC.getCDOCUMENTO_PERIODO()%>','<%=objBeanC.getCDOCUMENTO_COD_DOC_INT()%>' );">
                                                    <img src="imagenes/icono/anexos.fw.png" width="35" height="35" border="0" /></a>
                                            </div></td> 

                                        <td><div align="center">   
                                                <a href="javascript:eliminar('<%=objBeanC.getCDOCUMENTO_PERIODO()%>','<%=objBeanC.getCDOCUMENTO_COD_DOC_INT()%>');">
                                                    <img src="imagenes/icono/delete.png" width="35" height="35" border="0" /></a>
                                            </div></td> 

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
                    <td width="10%">&nbsp;</td>
                </tr>
                <tr><td colspan="4">&nbsp;</td></tr>
            </table>

            <!-- Modal (02)::Modal MOSTRAR Referencia -->                        
            <div class="modal fade" id="miModalVerMP"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

                <div class="modal-dialog   modal-lg" role="document">                                 
                    <div class="modal-content">                                    
                        <div class="modal-header"  style="background-color:rgb(194, 66, 78)">   <span style="color:rgb(240, 235, 235);font-size: 18px" align="center" ><b>DOCUMENTO</b></span> 
                             <a href="javascript:f_cerrar_moMP();"> <p style="color:rgb(243, 232, 233);" align="right"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                        </div>
                        <div  id="modalMostarMP">                                        

                        </div>


                    </div>
                </div>
            </div>

            <!--Fin Tabla Bandeja-->
  </form>   
        <!-- Modal (02)::Modal Distribucion -->                        
      
        <!--FIN MODAL Ventana Distribucion-->

        <!-- Modal (01)::Inicio Modal Registrar dcouemnto MESA DE PARTE-->
        <div class="modal fade" id="miModalRegDoc" style="overflow-y: scroll;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <!-- Dentro del Modal se añade unj Tabla para el combox prioridad, a la firma de y revisado por  -->

            <!--Fin Tabla dentro del Modal -->                                                        
            <div class="modal-dialog modal-lg" role="document">

                <div class="modal-content">
                    <div class="modal-header"  style="background-color:rgb(247, 169, 43)"> 
                        <img src="<%=request.getContextPath()%>/imagenes/icono/mp.png" width="110px" height="70px" align="left" />
                        <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Registro Mesa de Parte </b></span> 
                        <a href="javascript:f_cerrar_moObs();">  <p style="color:rgb(240, 235, 235);" align="rigth"><b><i>Cerrar  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                    </div>
                    <div class="modal-body" id="registro_MP">
                        <div align="left">

                            <table width="100%">
                                <tr>                        
                                    <td  style="background: #FFD153">
                                        <div align="left"><span style="color:rgb(6, 32, 27); font-family: monospace;font-size: 16px"><u>I. Datos del la Organización que Remite : </u></span></div>
                                    </td>    
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%">
                                            <tr>
                                                <td>&nbsp;&nbsp;</td>
                                                <td><div align="left" class="EstiloOF">Año</div></td>
                                                <td>&nbsp;&nbsp;</td>
                                                <td><div align="left" class="EstiloOF">Procedencia</div> </td>
                                                <td>&nbsp;&nbsp;</td>
                                                <td><div align="left" class="EstiloOF">Dependencia</div> </td>
                                            </tr>
                                            <tr>
                                                <td>&nbsp;&nbsp;</td>
                                                <td><select name="cbo_Periodo" class="form-control" id="cbo_Periodo" >
                                                        <%
                                                            Iterator iterator = objCombobox.obtenerPeriodo().iterator();
                                                            while (iterator.hasNext()) {
                                                                BeanPeriodo bean = (BeanPeriodo) iterator.next();
                                                                out.println("<option value= " + bean.getCPERIODO_CODIGO() + ">" + bean.getCPERIODO_CODIGO() + "</option>");

                                                            }

                                                        %>  
                                                    </select>
                                                </td>
                                                <td>&nbsp;&nbsp;</td>
                                                <div id="retorna_org">
                                                <td><select name="cbo_Tipo_Organizacion" class="form-control" id="cbo_Tipo_Organizacion" onchange="f_DIS(this.value)">
                                                        <option value="I">Interna</option>
                                                        <option value="E">Externa</option> 
                                                    </select>
                                                    <td>&nbsp;&nbsp;</td>
                                                </td>
                                                <td><div id="dis_org">
                                                        <select name='org' id='org'  class='selectpicker' data-live-search='true'   >
                                                            <%                                                        Iterator iteratorOrgI = objCombobox.obtenerOrganizacionEjercito_MP().iterator();
                                                                while (iteratorOrgI.hasNext()) {
                                                                    BeanOrganizacionInterna beanorgi = (BeanOrganizacionInterna) iteratorOrgI.next();
                                                                    out.println("<option value=" + beanorgi.getCOINTERNA_CODIGO() + ">" + beanorgi.getVOINTERNA_NOM_CORTO() + "</option>");
                                                                }

                                                            %>  
                                                        </select>
                                                    </div>

                                                </td>
                                                </div>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>

                            </table>    
                            <table width="100%">
                                <tr>                        
                                    <td  style="background: #FFD153">
                                        <div align="left"><span style="color:rgb(6, 32, 27);font-family: monospace;font-size: 16px"><u>II. Datos del documento : </u></span></div>
                                    </td>       
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%">
                                            <tr>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td width="20%"><div align="left" class="EstiloOF">Clase Documento</div></td>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td width="20%"><div align="left" class="EstiloOF">Nro Documento</div> </td>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td width="20%"><div align="left" class="EstiloOF">Indicativo</div> </td>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td width="20%"><div align="left" class="EstiloOF">Fecha Documento</div> </td>
                                            </tr>
                                            <tr>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td width="20%"><div align="left" class="EstiloOF">
                                                        <select name='cbx_Clase_Doc' id='cbx_Clase_Doc'  class='selectpicker' data-live-search='true'   >
                                                            <%  Iterator iteratorClaseDoc = objCombobox.obtenerClaseDocumento().iterator();
                                                                while (iteratorClaseDoc.hasNext()) {
                                                                    BeanClase beanclase = (BeanClase) iteratorClaseDoc.next();
                                                                    out.println("<option value=" + beanclase.getCCLASE_CODIGO() + ">" + beanclase.getVCLASE_NOM_LARGO() + "</option>");
                                                                }

                                                            %>  
                                                        </select>
                                                    </div>
                                                </td>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td width="20%"><div align="left" class="EstiloOF" ><input name="txt_Nro_Orden" id="txt_Nro_Orden" type="text" class="form-control" size="3"  /></div> </td>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td width="20%"><div align="left" class="EstiloOF"><input name="txt_Clave_Indic" id="txt_Clave_Indic"   type="text" class="form-control" size="3"  /></div> </td>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td width="20%"><div align="left" > 

                                                        <div class="input-group date" data-provide="datepicker" data-date-format="dd/mm/yyyy">
                                                            <input type="text" class="form-control" name="txt_fecha_MP" id="txt_fecha_MP">
                                                                <div class="input-group-addon">
                                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                                </div>
                                                        </div>                                                        

                                                    </div> </td>
                                            </tr>
                                            <tr>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td colspan="7" width="85%"><div align="left" class="EstiloOF">Asunto</div></td>                                              
                                            </tr>
                                            <tr>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td width="85%" colspan="7"><div align="left" class="EstiloOF"><input name="txt_Asunto_MP" id="txt_Asunto_MP"   type="text" class="form-control" size="3" /></div></td>                                              
                                            </tr>
                                            <tr>
                                                <td width="10%">&nbsp;&nbsp;</td>  
                                                <td width="40%" colspan="3"><div align="left" class="EstiloOF">Tipo Distribución</div></td>
                                                <td width="10%">&nbsp;&nbsp;</td>                                                  
                                                <td width="40%" colspan="3"><div align="left" class="EstiloOF">Prioridad</div> </td>


                                            </tr>
                                            <tr>
                                                <td width="5%">&nbsp;&nbsp;</td>  
                                                <td width="45%" colspan="3"><div align="left" class="EstiloOF">
                                                        <select name='cbx_tipo_distri' id='cbx_tipo_distri'  class='selectpicker' data-live-search='true'>
                                                            <option value="T">COMUN</option>
                                                            <option value="C">C'INF</option>
                                                        </select>

                                                    </div>
                                                </td>
                                                <td width="10%">&nbsp;&nbsp;</td>                                           

                                                <td width="45%" colspan="3"><div align="left" class="EstiloOF"> 
                                                        <select name='cbx_Prioridad' id='cbx_Prioridad'  class='selectpicker' data-live-search='true'   >
                                                            <%                                                        
                                                                Iterator iteratorPrioridad = objCombobox.obtenerPrioridades().iterator();
                                                                while (iteratorPrioridad.hasNext()) {
                                                                    BeanPrioridadDocumento beanprioridad = (BeanPrioridadDocumento) iteratorPrioridad.next();
                                                                    out.println("<option value=" + beanprioridad.getCodigo() + ">" + beanprioridad.getNombre() + "</option>");
                                                                }

                                                            %>  
                                                        </select>
                                                    </div> 
                                                </td>

                                            </tr>

                                        </table>    
                                    </td>
                                </tr><BR>

                            </table>
                            <table width="100%">
                                <tr>                        
                                    <td colspan="6"  style="background: #FFD153">
                                        <div align="left"><span style="color:rgb(6, 32, 27); font-family: monospace;font-size: 16px"><u>III. Adjuntar Documentos : </u></span></div>
                                    </td>       
                                </tr>
                                <tr>
                                    <td colspan="7">
                                        <div id="capa_add_" style="width:100%; align-content: center">                                   
                                            <form method="POST" action="#" enctype="multipart/form-data" id="frm_documento" target="frame_support">
                                                <!-- COMPONENT START -->
                                                <div class="form-group">
                                                    <div class="input-group input-file" name="Fichier1">
                                                        <label for="url_anexo_revisar"></label>
                                                        <input type="file" class="form-control" id="url_anexo_revisar" name="fileAnexo" style="width: 550px" />
                                                        <span class="input-group-btn">
                                                            <button class="btn btn-warning btn-reset" type="button" onclick="javascript:f_Grabar_Documento();"><b>GRABAR</b></button>
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
                                    </td>
                                </tr><BR>

                            </table>


                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!--Fin Modal-->

        <!-- Modal (03)::Modal Anexo -->                        
        <div class="modal fade" id="miModalAnexo"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog " role="document">                                 
                <div class="modal-content">                                    
                    <div class="modal-header"  style="background-color:rgb(76, 151, 80)"> <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Anexos</b></span> 
                        <a href="javascript:f_cerrar_moAnexos();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                    </div>
                    <div  id="modalAnexos">  
                    </div>
                </div>
            </div>
        </div>
        <!--FIN MODAL Modal Anexo-->    
          <div class="modal fade" id="miModalVerAnexos"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

            <div class="modal-dialog " role="document">                                 
                <div class="modal-content">                                    
                    <div class="modal-header"  style="background-color:rgb(222,97,94)">  
                        <a href="javascript:f_cerrar_verAnexos();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                    </div>
                    <div  id="modalMostarAnexos">                                        

                    </div>


                </div>
            </div>
        </div>
        
        
         

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



    </body>
</html>
