<%@include file="cerrarSesion.jsp" %>
<%@ taglib uri="/WEB-INF/tlds/libreria.tld" prefix="lb" %>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c" %>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@page import="sagde.bean.BeanTemporal"%>
<%@page import="sagde.bean.BeanUsuarioAD"%>
<%@page import="sagde.bean.BeanAnexo"%>
<%@page import="sagde.bean.BeanDistribucion"%>
<%@page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%    BeanUsuarioAD objBeanU = (BeanUsuarioAD) session.getAttribute("usuario");
    ArrayList ListarDistribucion = new ArrayList();
    ArrayList ListarReferencia = new ArrayList();
    ArrayList ListarAnexos = new ArrayList();

    if (session.getAttribute("distribucion") != null) {
        ListarDistribucion = (ArrayList) session.getAttribute("distribucion");
    }
    if (session.getAttribute("referencia") != null) {
        ListarReferencia = (ArrayList) session.getAttribute("referencia");
    }
    if (session.getAttribute("anexo") != null) {
        ListarAnexos = (ArrayList) session.getAttribute("anexo");
    }
%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Formular Documento: Oficio</title>
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/estilos.css" />
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/bootstrap.css" />
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/bootstrapOF.css" />        
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/bootstrap-datepicker.min.css" />
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/jquery.dataTables.min.css" />
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/bootstrap-select_Cbx.min.css" /> 
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-3.1.1.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/bootstrap-select.min.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/bootstrap-datepicker.min.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/bootstrap-datepicker.es.min.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js" ></script>

        <!--     FIN LIBRERIAS ESTANDAR   -->       
        <style type="text/css">

            .EstiloOF {
                font-family: "Century Gothic", CenturyGothic, AppleGothic, sans-serif;
                font-size: 12px;
                font-style: normal;
                font-variant: normal;
            }

            #miModalObs {
                top:2%;
                left: 78%;
                outline: none;
                width: 20%;	
            }
            #moopio, #moopio a{
                background-color: #9ADACD;
                height: 20px;
                width: 30%;
                font-size: 20px;
                color: #828282;
            }
            #moopio a{
                display:block;
            }
            #moopio a:hover {
                background-color: #4FBFA8;
                cursor:default;
                font-size: 26px;
                color: #D7D7D7;
            }

        </style>

        <script type="text/javascript">

            var ctx_path = "<%= request.getContextPath()%>";
            // Mostrar y Ocultar Capas
            function mostrar(nombreCapa) {
                document.getElementById(nombreCapa).style.visibility = "visible";
            }

            function ocultar(nombreCapa) {
                document.getElementById(nombreCapa).style.visibility = "hidden";
            }

            $(document).ready(function () {
                $('#lisDis').DataTable();
                $('#cboOrganizacion').selectpicker({style: 'btn-info', size: 10});

            });

            function f_openDis() { //v2.0
                $('#miModalDis').modal('show');
            }

            function f_DIS(tipo) {
                var reporte = "01";
                var interna = document.form1.cbo_OrgDependencia.value;
                var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                        "&tipo=", tipo,
                        "&interna=", interna,
                        "&reporte=", reporte);
                $("#dis_org").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#dis_org").html(msg + xhr.status + " " + xhr.statusText);
                    }
                    $('.selectpicker').selectpicker({style: 'btn-info', size: 10});
                });
            }

            function f_agregaDis() {
                var interna = document.form1.cboOrganizacion.value;
                var ch_tipo = document.getElementsByName("tipo");
                var tipo = "";
                var seleccionado = false;
                for (var i = 0; i < ch_tipo.length; i++) {
                    if (ch_tipo[i].checked) {
                        seleccionado = true;
                        tipo = ch_tipo[i].value;
                        break;
                    }
                }
                if (!seleccionado) {
                    alert("Seleccione un Tipo de Organizacion");
                } else if (interna === "--Elija Opcion--") {
                    alert("Seleccione Organizacion");
                } else {
                    var reporte = "02";
                    var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                            "&tipo=", tipo,
                            "&interna=", interna,
                            "&reporte=", reporte);
                    $("#tabladis").load(ruta, function (status, xhr) {
                        if (status === "error") {
                            var msg = "Error!, algo ha sucedido: ";
                            $("#tabladis").html(msg + xhr.status + " " + xhr.statusText);
                        }
                        $('#lisDis').DataTable();
                    });
                }
            }

            function f_elimina(tipo, interna) {
                var reporte = "05";
                var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte,
                        "&tipo=", tipo,
                        "&interna=", interna
                        );
                $("#tabladis").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#tabladis").html(msg + xhr.status + " " + xhr.statusText);
                    }
                    $('#lisDis').DataTable();
                });
            }
   
            function f_cerrar() {
                $('#miModalDis').modal('hide');
                var reporte = "04";
                var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte
                        );
                $("#listadis").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#listadis").html(msg + xhr.status + " " + xhr.statusText);
                    }
                });
            }

            function f_enviaDistribucion(Nombre_dest, Grado_dest, Cargo_dest, interna, tipo) {
                document.form1.txt_Grado.value = Grado_dest;
                document.form1.txt_Cargo.value = Cargo_dest;
                document.form1.txh_Organizacion.value = interna;
                document.form1.txh_TipoOrg.value = tipo;
                var reporte = "03";
                var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte,
                        "&tipo=", tipo,
                        "&interna=", interna
                        );
                $("#listadis").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#listadis").html(msg + xhr.status + " " + xhr.statusText);
                    }
                });
            }

            function f_listaAnexo(usuario, interna) { //v2.0
                $('#miModalAnexos').modal({backdrop: 'static', keyboard: false});
                var reporte = "17";
                var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte,
                        "&usuario=", usuario,
                        "&interna=", interna
                        );
                $("#cuerpoAnexo").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#cuerpoAnexo").html(msg + xhr.status + " " + xhr.statusText);
                    }
                    $('#dt_anetemp').DataTable();
                });
            }

            function f_cerrar_moAnexos() {
                $('#miModalAnexos').modal('hide');
                var reporte = "20";
                var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte
                        );
                $("#listAnexo").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#listAnexo").html(msg + xhr.status + " " + xhr.statusText);
                    }
                });
            }

            function f_verAnexo(token, archivo) {
                if (token === "null") {
                    alert("Documento sin Token, imposible de recuperar");
                } else {
                    var reporte = "16";
                    var extension = archivo.split(".")[1];
                    if (extension === "pdf" || extension === "PDF" || extension === "txt" || extension === "TXT") {
                        $('#modalDocumento').modal({backdrop: 'static', keyboard: false});
                    }
                    archivo = btoa(archivo);
                    var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                            "&reporte=", reporte,
                            "&token=", token,
                            "&archivo=", archivo
                            );
                    $("#documentovp").load(ruta, function (status, xhr) {
                        if (status === "error") {
                            var msg = "Error!, algo ha sucedido: ";
                            $("#documentovp").html(msg + xhr.status + " " + xhr.statusText);
                        }
                    });
                }
            }

            function f_eliminarAnexo(secuencia) {
                var reporte = "19";
                var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte,
                        "&secuencia=", secuencia
                        );
                $("#cuerpoAnexo").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#cuerpoAnexo").html(msg + xhr.status + " " + xhr.statusText);
                    }
                    $('#dt_anetemp').DataTable({});
                });
            }

            function f_grabar_anexo() {
                var accion = "insertar_Anexo";
                var frm_anexos = $("#frm_anexos")[0];
                frm_anexos.action = ctx_path.concat("/grabarAnexoFD?accion=", accion);
                frm_anexos.submit();
                var usuario = document.form1.txh_usuario.value;
                var interna = document.form1.txh_interna.value;
                var ruta =  ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=17",
                        "&usuario=", usuario,
                        "&interna=", interna);
                alert("Archivo agregado con exito");
                refreshDivs('cuerpoAnexo', 2, ruta);
            }

            function f_openAgregaAne() {
                var reporte = "18";
                var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte
                        );
                $("#cuerpoAnexo").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#cuerpoAnexo").html(msg + xhr.status + " " + xhr.statusText);
                    }
                });
            }

            function f_vistaprevia() {
                if (document.form1.cbo_ParteDe.value !== "000") {
                    var reporte = "06";
                    var orgint_origen = btoa(document.form1.cbo_OrgDependencia.options[document.form1.cbo_OrgDependencia.selectedIndex].text);
                    var nombreanio = btoa(document.form1.txt_NombreAnio.value);
                    var guarnicion = btoa(document.form1.txt_Guarnicion.value);
                    var fecha = btoa(document.form1.txt_Fecha.value);
                    var orgint_redacta = btoa(document.form1.txt_Clave.value);
                    var archivo = btoa(document.form1.cboArchivoIndicativo.options[document.form1.cboArchivoIndicativo.selectedIndex].text);
                    var grado_distribucion = btoa(document.form1.txt_Grado.value);
                    var cargo_distribucion = btoa(document.form1.txt_Cargo.value);
                    var asunto = btoa(document.form1.txt_Asunto.value);
                    var cuerpo = btoa(btoa(btoa(CKEDITOR.instances.txtcuerpo.getData())));
                    //var cuerpo = btoa(CKEDITOR.instances.txtcuerpo.getData());
                    var cargo_firmante = btoa(document.form1.cbo_ParteDe.options[document.form1.cbo_ParteDe.selectedIndex].text);
                    $('#miModalVP').modal('show');
                    var ruta = ctx_path.concat("pasacache=", new Date().getTime(),
                            "&orgint_origen=", orgint_origen,
                            "&nombreanio=", nombreanio,
                            "&guarnicion=", guarnicion,
                            "&fecha=", fecha,
                            "&orgint_redacta=", orgint_redacta,
                            "&archivo=", archivo,
                            "&grado_distribucion=", grado_distribucion,
                            "&cargo_distribucion=", cargo_distribucion,
                            "&asunto=", asunto,
                            "&cuerpo=", cuerpo,
                            "&cargo_firmante=", cargo_firmante,
                            "&reporte=", reporte);
                    $.ajax({
                        type: "post",
                        url: "<%= request.getContextPath()%>/r_oficiovp",
                        data: ruta,
                        cache: false,
                        success: function (xhr) {
                            var blob = b64toBlob(xhr, "application/pdf");
                            if (window.navigator && window.navigator.msSaveOrOpenBlob) {
                                window.navigator.msSaveOrOpenBlob(blob, 'vprevia.pdf');
                                $("#mns").css("visibility", "visible");
                                $("#salida2").css("visibility", "hidden");
                            } else {
                                var hrefShowInObject = window.URL.createObjectURL(blob);
                                $("#salida2").attr("src", hrefShowInObject);
                                $("#mns").css("visibility", "hidden");
                                $("#salida2").css("visibility", "visible");
                            }
                        }
                    });
                } else {
                    alert("Falta Seleccionar Combo A la firma");
                }
            }

            function b64toBlob(b64Data, contentType, sliceSize) {
                contentType = contentType || '';
                sliceSize = sliceSize || 512;
                var byteCharacters = atob(b64Data);
                var byteArrays = [];
                for (var offset = 0; offset < byteCharacters.length; offset += sliceSize) {
                    var slice = byteCharacters.slice(offset, offset + sliceSize);
                    var byteNumbers = new Array(slice.length);
                    for (var i = 0; i < slice.length; i++) {
                        byteNumbers[i] = slice.charCodeAt(i);
                    }
                    var byteArray = new Uint8Array(byteNumbers);
                    byteArrays.push(byteArray);
                }
                var blob = new Blob(byteArrays, {type: contentType});
                return blob;
            }

            function f_borrador() {
                document.form1.txh_accion.value = "BORRADOR";
                f_enviar();
            }

            function f_validacion(accion) {
                document.form1.txh_accion.value = accion;
                if (document.form1.txt_Cargo.value === "") {
                    alert("Falta ingresar DISTRIBUCION:");
                } else if (document.form1.txt_Asunto.value === "") {
                    alert("Falta ingresar ASUNTO:");
                } else if (document.form1.cbo_ParteDe.value === "000") {
                    alert("Falta seleccionar A LA FIRMA DE:");
                } else if (document.form1.cbo_Cargo1.value === "000") {
                    alert("Falta seleccionar REVISADO POR:");
                } else {
                    if (accion === "REVISAR" || accion === "ALPARTE") {
                        $('#miModalObs').modal('show');
                    } else {
                        f_enviar();
                    }
                }
            }

            function f_enviar() {
                var accion = document.form1.txh_accion.value;
                var tipo = document.form1.txh_TipoOrg.value;
                var interna = document.form1.cbo_OrgDependencia.value;
                var clave = document.form1.txt_Clave.value;
                var archivo = document.form1.cboArchivoIndicativo.value;
                var clasificacion = document.form1.cbo_Clasificacion.value;
                var prioridad = document.form1.cbo_Prioridad.value;
                var asunto = btoa(document.form1.txt_Asunto.value);
                var nivelsuperior = document.form1.cbo_NivelSuperior.value;
                var guarnicion = document.form1.txt_Guarnicion.value;
                var firmante = document.form1.cbo_ParteDe.value;
                var cuerpo = btoa(btoa(CKEDITOR.instances.txtcuerpo.getData()));
                var revisor = document.form1.cbo_Cargo1.value;
                var observacion = btoa(document.form1.txtObservacion.value);
                var ruta = ctx_path.concat("pasacache=", new Date().getTime(),
                        "&tipo=", tipo,
                        "&interna=", interna,
                        "&clave=", clave,
                        "&archivo=", archivo,
                        "&clasificacion=", clasificacion,
                        "&prioridad=", prioridad,
                        "&asunto=", asunto,
                        "&nivelsuperior=", nivelsuperior,
                        "&guarnicion=", guarnicion,
                        "&firmante=", firmante,
                        "&cuerpo=", cuerpo,
                        "&revisor=", revisor,
                        "&observacion=", observacion,
                        "&accion=", accion);
                $('#miModalObs').modal('hide');
                $.ajax({
                    type: "post",
                    url: "<%= request.getContextPath()%>/oficioEnvio",
                    data: ruta,
                    cache: false
                });

                var posTO = document.all.cbo_Cargo1.options.selectedIndex;
                var des_to = document.all.cbo_Cargo1.options[posTO].text;
                document.all.txh_alerta_revisa.value = des_to;
                $('#miModalAlerta').modal({backdrop: 'static', keyboard: false});
            }

            function f_cerrar_moObs() {
                $('#miModalObs').modal('hide');
            }

            function f_cambio() {
                if (document.all.cbo_ParteDe.value === document.all.cbo_Cargo1.value &&
                        document.all.cbo_ParteDe.value === document.all.txh_usuario.value) {
                    document.all.firmar.style.visibility = "visible";
                    document.all.enviar1.style.visibility = "hidden";
                    document.all.enviar2.style.visibility = "hidden";
                } else {
                    if (document.all.cbo_ParteDe.value === document.all.cbo_Cargo1.value) {
                        document.all.firmar.style.visibility = "hidden";
                        document.all.enviar1.style.visibility = "hidden";
                        document.all.enviar2.style.visibility = "visible";
                    } else {
                        document.all.enviar2.style.visibility = "hidden";
                        document.all.enviar1.style.visibility = "visible";
                        document.all.firmar.style.visibility = "hidden";
                    }
                }
            }

            function f_cerrar_moAlerta() {
                $('#miModalAlerta').modal('hide');
                document.forms[0].action = '<%=request.getContextPath()%>/formular';
                document.forms[0].submit();
            }

            function f_cerrar_moReferencia() {
                $('#modalReferencia').modal('hide');
                var reporte = "11";
                var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte
                        );
                $("#lisRef").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#lisRef").html(msg + xhr.status + " " + xhr.statusText);
                    }
                });
            }

            function f_listaReferencia(usuario, interna) {
                $('#modalReferencia').modal({backdrop: 'static', keyboard: false});
                var reporte = "13";
                var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte,
                        "&usuario=", usuario,
                        "&interna=", interna
                        );
                $("#cuerpoReferencia").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#cuerpoReferencia").html(msg + xhr.status + " " + xhr.statusText);
                    }
                    $('#dt_reftemp').DataTable({});
                    $('.selectpicker').selectpicker({style: 'cbo_RefOrdenLR', size: 5});
                });
            }

            function f_openBusquedaRef() {
                var reporte = "07";
                var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte
                        );
                $("#cuerpoReferencia").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#cuerpoReferencia").html(msg + xhr.status + " " + xhr.statusText);
                    }
                    $('.selectpicker').selectpicker({style: 'cbo_InternaBR', size: 10});
                    $('.selectpicker').selectpicker({style: 'cbo_ClaseBR', size: 10});
                    $('.datepicker').datepicker({format: "dd/mm/yyyy",
                        maxViewMode: 2,
                        todayBtn: "linked",
                        language: "es",
                        daysOfWeekHighlighted: "0,6",
                        calendarWeeks: true,
                        autoclose: true,
                        todayHighlight: true
                    });
                });
            }

            function f_openAgregaRef() {
                var reporte = "10";
                var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte
                        );
                $("#cuerpoReferencia").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#cuerpoReferencia").html(msg + xhr.status + " " + xhr.statusText);
                    }
                    $('.selectpicker').selectpicker({style: 'cbo_InternaAR', size: 10});
                    $('.selectpicker').selectpicker({style: 'cbo_Clase_AR', size: 10});
                    $('.selectpicker').selectpicker({style: 'cbo_Clasificacion_AR', size: 10});
                    $('.selectpicker').selectpicker({style: 'cbo_Prioridad_AR', size: 10});
                    $('.datepicker').datepicker({format: "dd/mm/yyyy",
                        maxViewMode: 2,
                        todayBtn: "linked",
                        language: "es",
                        daysOfWeekHighlighted: "0,6",
                        calendarWeeks: true,
                        autoclose: true,
                        todayHighlight: true
                    });
                });
            }



            function f_verReferencia(token,archivo) {
                if (token === "null") {
                    alert("Documento sin Token, imposible de recuperar");
                } else {
                    $('#modalDocumento').modal({backdrop: 'static', keyboard: false});
                    var reporte = "16";
                    archivo = btoa(archivo);
                    var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                            "&reporte=", reporte,
                            "&archivo=", archivo,
                            "&token=", token
                            );
                    $("#documentovp").load(ruta, function (status, xhr) {
                        if (status === "error") {
                            var msg = "Error!, algo ha sucedido: ";
                            $("#documentovp").html(msg + xhr.status + " " + xhr.statusText);
                        }
                    });
                }
            }

            function f_eliminarReferencia(secuencia) {
                var reporte = "14";
                var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte,
                        "&secuencia=", secuencia
                        );
                $("#cuerpoReferencia").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#cuerpoReferencia").html(msg + xhr.status + " " + xhr.statusText);
                    }
                    $('#dt_reftemp').DataTable({});
                });
            }

            function f_Buscar_Referencia() {
                var reporte = "08";
                var periodo = document.form2.cbo_PeriodoBR.value;
                var tipo = document.form2.cbo_TipoBR.value;
                var interna = document.form2.cbo_InternaBR.value;
                var clase = document.form2.cbo_ClaseBR.value;
                var nrodoc = document.form2.txt_nro_docBR.value;
                var desde = document.form2.txtFecDesdeBR.value;
                var hasta = document.form2.txtFecHastaBR.value;
                var asunto = document.form2.txt_Asunto_BR.value;
                if (interna === "N") {
                    alert("Seleccione Organización!!!");
                } else {
                    var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                            "&reporte=", reporte,
                            "&periodo=", periodo,
                            "&tipo=", tipo,
                            "&clase=", clase,
                            "&nrodoc=", nrodoc,
                            "&desde=", desde,
                            "&hasta=", hasta,
                            "&asunto=", asunto,
                            "&interna=", interna
                            );
                    $("#modalListaBusRef").load(ruta, function (status, xhr) {
                        if (status === "error") {
                            var msg = "Error!, algo ha sucedido: ";
                            $("#modalListaBusRef").html(msg + xhr.status + " " + xhr.statusText);
                        }
                        $('#dt_busref').DataTable({});
                    });
                }
            }

            function f_org_referencia(tipo) {
                var reporte = "12";
                var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte,
                        "&tipo=", tipo
                        );
                $("#org_BR").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#org_BR").html(msg + xhr.status + " " + xhr.statusText);
                    }
                    $('.selectpicker').selectpicker({style: 'cbo_InternaBR', size: 10});
                });
            }

            function f_agrega_refe(periodo, nrodoc, token) {
                var reporte = "09";
                var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte,
                        "&periodo=", periodo,
                        "&nrodoc=", nrodoc,
                        "&token=", token
                        );
                $("#cuerpoReferencia").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#cuerpoReferencia").html(msg + xhr.status + " " + xhr.statusText);
                    }
                    $('#dt_reftemp').DataTable({});
                    $('.selectpicker').selectpicker({style: 'cbo_RefOrdenLR', size: 5});
                });
            }

            var ajaxCR = null;
            function f_cambiaOrden(secuencia, orden) {
                var reporte = "15";
                var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte,
                        "&secuencia=", secuencia,
                        "&orden=", orden
                        );
                $("#sinRetorno").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#sinRetorno").html(msg + xhr.status + " " + xhr.statusText);
                    }
                });
            }

            function f_cerrar_ModDoc() {
                $('#modalDocumento').modal('hide');
                document.all.documentovp.innerHTML = "&nbsp;";
            }

            function f_Grabar_Referencia() {
                var periodo = document.form2.cbo_Periodo_AR.value;
                var tipo = document.form2.cbo_Tipo_Organizacion_AR.value;
                var interna = document.form2.cbo_InternaAR.value;
                var clase = document.form2.cbo_Clase_AR.value;
                var orden = document.form2.txt_Nro_Orden_AR.value;
                var clave = document.form2.txt_Clave_Indic_AR.value;
                var fecha = document.form2.txt_fecha_AR.value;
                var asunto = document.form2.txt_Asunto_AR.value;
                var clasificacion = document.form2.cbo_Clasificacion_AR.value;
                var prioridad = document.form2.cbo_Prioridad_AR.value;
                var accion = "insertar_Referencia";
                var frm_referencia = $("#frm_referencia")[0];
                frm_referencia.action = ctx_path.concat("/grabarRefFD?periodo=", periodo,
                        "&tipo=", tipo,
                        "&clase=", clase,
                        "&orden=", orden,
                        "&clave=", clave,
                        "&fecha=", fecha,
                        "&asunto=", asunto,
                        "&clasificacion=", clasificacion,
                        "&prioridad=", prioridad,
                        "&accion=", accion,
                        "&interna=", interna
                        );
                frm_referencia.submit();

                var ruta = "<%= request.getContextPath()%>/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=" + new Date().getTime() +
                        "&reporte=13" +
                        "&interna=<%=objBeanU.getCUSUARIO_COD_ORG()%>" +
                        "&usuario=<%=objBeanU.getVUSUARIO_CODIGO()%>";

                refreshDivs('cuerpoReferencia', 3, ruta);
            }

            function refreshDivs(divid, secs, url) {
                // define our vars
                var fetch_unix_timestamp;
                // Chequeamos que las variables no esten vacias..
                if (divid === "") {
                    alert('Error: escribe el id del div que quieres refrescar');
                    return;
                } else if (!document.getElementById(divid)) {
                    alert('Error: el Div ID selectionado no esta definido: ' + divid);
                    return;
                } else if (secs === "") {
                    alert('Error: indica la cantidad de segundos que quieres que el div se refresque');
                    return;
                } else if (url === "") {
                    alert('Error: la URL del documento que quieres cargar en el div no puede estar vacia.');
                    return;
                }
                // The XMLHttpRequest object
                var xmlHttp;
                try {
                    xmlHttp = new XMLHttpRequest(); // Firefox, Opera 8.0+, Safari
                } catch (e) {
                    try {
                        xmlHttp = new ActiveXObject("Msxml2.XMLHTTP"); // Internet Explorer                    
                    } catch (e) {
                        try {
                            xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
                        } catch (e) {
                            alert("Tu explorador no soporta AJAX.");
                            return false;
                        }
                    }
                }
                // Timestamp para evitar que se cachee el array GET
                fetch_unix_timestamp = function () {
                    return parseInt(new Date().getTime().toString().substring(0, 100));
                };
                var timestamp = fetch_unix_timestamp();
                var nocacheurl = url + "&t=" + timestamp;
                xmlHttp.onreadystatechange = function () {
                    if (xmlHttp.readyState === 4 && xmlHttp.status === 200) {
                        document.getElementById(divid).innerHTML = xmlHttp.responseText;
                        $('#dt_reftemp').DataTable({
                            "scrollCollapse": true,
                            "paging": false
                        });
                        $('#dt_anetemp').DataTable({
                            "scrollCollapse": true,
                            "paging": false
                        });
                    }
                };
                xmlHttp.open("GET", nocacheurl, true);
                xmlHttp.send(null);
            }

            function f_DIS_AR(tipo) {
                var reporte = "21";
                var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte,
                        "&tipo=", tipo
                        );
                $("#org_AR").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#org_AR").html(msg + xhr.status + " " + xhr.statusText);
                    }
                    $('.selectpicker').selectpicker({style: 'cbo_InternaAR', size: 10});
                });
            }

            var ajaxOAR = null;
            function f_cancelar() {
                var reporte = "22";
                var ruta = ctx_path.concat("/gedad/formulardoc/I_Oficio_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte
                        );
                $("#sinRetorno").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#sinRetorno").html(msg + xhr.status + " " + xhr.statusText);
                    }
                    document.forms[0].action = '<%=request.getContextPath()%>/menu';
                    document.forms[0].submit();
                });
            }

            function f_cerrar_ModVP() {
                $('#miModalVP').modal('hide');
                document.all.salida2.innerHTML = "&nbsp;";
            }

            function f_cerrar_ModDis() {
                $('#miModalDis').modal('hide');
            }

        </script>

    </head>

    <body>
        <form id="form1" name="form1" method="post" action="">
            <input type="hidden" id="cbo_NivelSuperior" name="cbo_NivelSuperior" value="<lb:NombreOrganizacionLargoTagL></lb:NombreOrganizacionLargoTagL>" />
                <input type="hidden" id="txh_accion" name="txh_accion" />
                <input type="hidden" id="txh_usuario" name="txh_usuario" value="<%=objBeanU.getVUSUARIO_CODIGO()%>" />
            <input type="hidden" id="txh_interna" name="txh_interna" value="<%=objBeanU.getCUSUARIO_COD_ORG()%>" />
            <input type="hidden" id="txh_mensaje" name="txh_mensaje" />
            <div id="sinRetorno"></div>
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
                                    <span class="glyphicon glyphicon-user" style="color:rgb(217, 81, 77);">&nbsp;<b><i>Usuario:</i>&nbsp;<%=objBeanU.getVUSUARIO_CARGO()%></b></span>
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
                                    <li><a href="<%=request.getContextPath()%>/menu"><span class="glyphicon glyphicon-home"></span> Home</a></li>
                                </ul>
                            </div>                       
                        </nav>
                    </td>
                </tr>    
            </table>
            <%-- TERMINO  CABECERA --%> 
            <table width="100%">
                <tr>
                    <td width="3%">&nbsp;</td>
                    <td class="form-control" >
                        <%@ include file="/gedad/formulardoc/I_MenuDocumento.jsp"%></td>
                    <td width="3%">&nbsp;</td>
                    <td>
                        <%-- INICIO OFICIO --%> 
                        <table width="100%" border="1">
                            <tr>
                                <td width="100%" bgcolor="#FFFFFF">
                                    <%-- INICIO CABECERA PERU --%>
                                    <table width="100%" cellspacing="0" cellpadding="0" border="0">
                                        <tr>
                                            <td width="10%"><div align="center"><img src="<%= request.getContextPath()%>/imagenes/escudos/escudo.png" width="70px" height="60px" /></div></td>
                                            <td width="10%" bgcolor="#E03032"><span style="color:rgb(255,255,255);"><div class="EstiloOF">&nbsp;PERÚ</div></span></td>
                                            <td width="15%" bgcolor="#2F3130"><span style="color:rgb(255,255,255);"><div class="EstiloOF">&nbsp;Ministerio</div><div class="EstiloOF">&nbsp;de Defensa</div></span></td>
                                            <td width="15%" bgcolor="#565656"><span style="color:rgb(255,255,255);"><div class="EstiloOF">&nbsp;Ejército</div><div class="EstiloOF">&nbsp;del Perú</div></span></td>
                                            <td width="50%" bgcolor="#ADADAD">&nbsp;<select name="cbo_OrgDependencia" id="cbo_OrgDependencia" class="form-controlOF" style="background-color: #ADADAD;color:rgb(255,255,255);"><lb:NombreOrganizacionLargoTag2></lb:NombreOrganizacionLargoTag2></select></td>
                                            </tr>
                                        </table>
                                    <%-- FIN CABECERA PERU --%>
                                    <table width="100%" border="0" cellspacing="0">
                                        <tr>
                                            <td colspan="6"><div align="center" class="EstiloOF"><input name="txt_NombreAnio" id="txt_NombreAnio" type="text" size="80" style="border:0px; text-align: right;" value="<lb:DefinicionPeriodoTag></lb:DefinicionPeriodoTag>" readonly="true" /></div></td>
                                            </tr>
                                            <tr>
                                                <td colspan="6">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td colspan="5">
                                                    <div align="right" class="EstiloOF">
                                                        <table>
                                                            <tr>
                                                                <td><input name="txt_Guarnicion" id="txt_Guarnicion" type="text" style="border:0px; text-align: right;" value="<lb:OrganizacionLugar></lb:OrganizacionLugar>" readonly="true" /></td>
                                                                <td>,&nbsp;</td>
                                                                <td><%
                                                                    java.util.Calendar fecha = java.util.Calendar.getInstance();
                                                                    String Meses[] = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
                                                                    String fecha_st = fecha.get(java.util.Calendar.DATE) + " de " + Meses[fecha.get(java.util.Calendar.MONTH)] + " del " + fecha.get(java.util.Calendar.YEAR);%>
                                                                <input name="txt_Fecha" id="txt_Fecha" type="text" size="25" style="border:0px; text-align: right;" value="<%=fecha_st%>" readonly="true" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                            </td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td width="40%">&nbsp;</td>
                                            <td width="40%">&nbsp;</td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td colspan="2">
                                                <div align="left" class="EstiloOF">Oficio N°</div></td>
                                            <td colspan="3">
                                                <table width="100%">
                                                    <tr>
                                                        <td width="10%"><input name="txt_Numero" id="txt_Numero" type="text" class="form-control" size="3" readonly="false" /></td>
                                                        <td width="20%"><input name="txt_Clave" id="txt_Clave" type="text" class="form-controlOF" readonly="true" value="<lb:ClaveIndicativoTag></lb:ClaveIndicativoTag>" size="10"/></td>
                                                        <td width="70%"><select name="cboArchivoIndicativo" id="cboArchivoIndicativo" class="form-controlOF"><lb:ArchivoIndicativoTag></lb:ArchivoIndicativoTag></select></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>&nbsp;</td>
                                                <td width="49"><div align="left" class="EstiloOF">Se&ntilde;or</div></td>
                                                <td width="8"><div align="left" class="EstiloOF">:</div></td>
                                                <td colspan="3">
                                                    <div align="left" class="Estilo10" id="PrimeraDistribucion">
                                                    <%
                                                        if (session.getAttribute("distribucion") != null) {
                                                            for (int i = 0; i < ListarDistribucion.size(); i++) {
                                                                BeanDistribucion objBeanD = (BeanDistribucion) ListarDistribucion.get(i);
                                                                if (objBeanD.getTipo().equals("T")) {
                                                    %>
                                                    <label>
                                                        <input name="txt_Grado" id="txt_Grado" class="form-controlOF" type="text" readonly="true" value="<%=objBeanD.getGrado()%>" />
                                                    </label>
                                                    <input name="txt_Cargo" id="txt_Cargo" class="form-controlOF" type="text" readonly="true" value="<%=objBeanD.getCargo()%>" />
                                                    <input name="txh_Organizacion" id="txh_Organizacion" class="form-controlOF" type="hidden" value="<%=objBeanD.getCodigoOrganizacion()%>" />
                                                    <input name="txh_TipoOrg" id="txh_TipoOrg" class="form-controlOF" type="hidden" value="<%=objBeanD.getTipoOrganizacion()%>" />
                                                    <%}
                                                        }
                                                    %><%
                                                    } else {
                                                    %>
                                                    <label>
                                                        <input name="txt_Grado" id="txt_Grado" class="form-controlOF" type="text" readonly="true" />
                                                    </label>
                                                    <input name="txt_Cargo" id="txt_Cargo" class="form-controlOF" type="text" readonly="true" />
                                                    <input name="txh_Organizacion" id="txh_Organizacion" class="form-controlOF" type="hidden" />
                                                    <input name="txh_TipoOrg" id="txh_TipoOrg" class="form-controlOF" type="hidden" />
                                                    <%
                                                        }
                                                    %>

                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td colspan="3">
                                                <table>
                                                    <tr>
                                                        <td><button type="button" class="btn btn-primary btn-sm" style="width: 100%" onclick="javascript:f_openDis();" >AGREGAR DISTRIBUCIÓN</button></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td valign="top"><div align="left" class="EstiloOF">Asunto</div></td>
                                            <td valign="top"><div align="left" class="EstiloOF">:</div></td>
                                            <td colspan="3"><textarea name="txt_Asunto" id="txt_Asunto" cols="100%" class="form-controlOF" type="text"></textarea></td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td valign="top"><div align="left" class="EstiloOF">Ref.</div></td>
                                            <td valign="top"><div align="left" class="EstiloOF">:</div></td>
                                            <td colspan="3"><span class="EstiloOF" id="lisRef" name="lisRef">
                                                    <%
                                                        for (int i = 0; i < ListarReferencia.size(); i++) {
                                                            BeanTemporal objBeanT = (BeanTemporal) ListarReferencia.get(i);
                                                    %>
                                                    <a href="javascript:f_verReferencia('<%=objBeanT.getVTEMP_TOKEN()%>','<%=objBeanT.getVTEMP_NOMBRE()%>');">	
                                                        <%=objBeanT.getVREFORD_DESC()%>&nbsp;
                                                        <%=objBeanT.getVCLASE_NOM_CORTO()%>&nbsp;Nº
                                                        <%=objBeanT.getCDOCUMENTO_NRO_ORDEN()%>&nbsp;
                                                        <%=objBeanT.getVDOCUMENTO_CLAVE_INDIC()%>&nbsp;del 
                                                        <%=objBeanT.getDDOCUMENTO_FECHA()%>
                                                    </a><br>
                                                        <%}
                                                        %>
                                                </span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td colspan="3"><label>
                                                    <table>
                                                        <tr>
                                                            <td><button type="button" class="btn btn-primary btn-sm" style="width: 100%" onclick="javascript:f_listaReferencia('<%=objBeanU.getVUSUARIO_CODIGO()%>', '<%=objBeanU.getCUSUARIO_COD_ORG()%>');" >AGREGAR REFERENCIA</button></td>
                                                        </tr>
                                                    </table></label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td height="216" colspan="5">
                                                <table width="100%" height="212" border="0">
                                                    <tr>                        
                                                        <td width="100%">
                                                            <div align="justify">
                                                                <textarea name="txtcuerpo" id="txtcuerpo" class="form-controlOF" type="text"></textarea>
                                                            </div>
                                                        </td>
                                                        <script>
                                                            CKEDITOR.replace('txtcuerpo');
                                                        </script>  
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>                
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td><div align="left" class="EstiloOF">Dios guarde a Ud.</div></td>
                                            <td>&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td colspan="3"><div align="left" class="EstiloOF"><u>DISTRIBUCION:</u></div></td>
                                            <td colspan="2">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td colspan="5">
                                                <div id="listadis">
                                                    <%
                                                        if (session.getAttribute("distribucion") != null) {
                                                    %>
                                                    <table border="0" class="EstiloOF">
                                                        <%
                                                            for (int i = 0; i < ListarDistribucion.size(); i++) {
                                                                BeanDistribucion objBeanD = (BeanDistribucion) ListarDistribucion.get(i);
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
                                                            for (int i = 0; i < ListarDistribucion.size(); i++) {
                                                                BeanDistribucion objBeanD = (BeanDistribucion) ListarDistribucion.get(i);
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
                                                        }
                                                    %>
                                                </div>
                                            </td>
                                        </tr>
                                        <!-- anexos -->
                                        <tr height="10px"></tr>
                                        <tr>
                                            <td>&nbsp;</td>
                                            <td colspan="2"><button type="button" class="btn btn-info btn-sm" style="width: 100%" onclick="javascript:f_listaAnexo('<%=objBeanU.getVUSUARIO_CODIGO()%>', '<%=objBeanU.getCUSUARIO_COD_ORG()%>');" >AGREGAR ANEXOS</button></td>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                        <!-- terminooooooo anexos -->	
                                        <tr>
                                            <td height="15px">&nbsp;</td>
                                            <td colspan="5"><div id="listAnexo">
                                                    <table border="0" width="100%">              
                                                        <!-- AQUI VA LA LISTA DE ANEXOS -->
                                                        <%
                                                            if (ListarAnexos.size() > 0) {
                                                        %>
                                                        <tr class="EstiloOF">
                                                            <td><u>ANEXOS:</u><br>
                                                                    <table  width="100%" >
                                                                        <tbody>
                                                                            <% for (int i = 0; i < ListarAnexos.size(); i++) {
                                                                                    BeanTemporal objBeanT = (BeanTemporal) ListarAnexos.get(i);
                                                                            %>
                                                                            <tr>
                                                                                <td>-</td>
                                                                                <td><div align="left">
                                                                                        <a href="javascript:f_verAnexo('<%=objBeanT.getVTEMP_TOKEN()%>','<%=objBeanT.getVTEMP_NOMBRE()%>');">	
                                                                                            <%=objBeanT.getVTEMP_NOMBRE()%>
                                                                                        </a>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                            <% }%> 
                                                                        </tbody>
                                                                    </table>    
                                                            </td>
                                                        </tr>
                                                        <% }%> 	
                                                        <!--  FIN LISTA DE ANEXOS -->
                                                    </table></div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="6" align="center" class="Estilo10">&nbsp;</td>			  
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                        <%-- FIN OFICIO --%>
                        <br />
                        <%-- INICIO FIRMA Y REVISION --%>
                        <table width="100%" border="0" cellspacing="0">
                            <tr>
                                <td width="30%"><div align="center" class="Estilo10">Prioridad:</div></td>
                                <td width="5%">&nbsp;</td>
                                <td width="30%"><div align="center" class="Estilo10">A la Firma de:</div></td>
                                <td width="5%">&nbsp;</td>
                                <td width="30%"><div align="center" class="Estilo10">Revisado por:</div></td>
                            </tr>
                            <tr>
                                <td><select name="cbo_Prioridad" id="cbo_Prioridad" class="form-control" >
                                        <lb:ListaPrioridad></lb:ListaPrioridad>
                                        </select>
                                    </td>
                                    <td>&nbsp;
                                    </td>
                                    <td>
                                        <select name="cbo_ParteDe" id="cbo_ParteDe" class="form-control" onchange="f_cambio()" >
                                            <option value="000">--Elija Opcion--</option>
                                        <lb:ComboAlparteTag></lb:ComboAlparteTag>
                                        </select>
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>
                                        <select name="cbo_Cargo1" id="cbo_Cargo1" class="form-control" onchange="f_cambio()">
                                            <option value="000">--Elija Opcion--</option>
                                        <lb:ComboCargoTag></lb:ComboCargoTag>
                                        </select>
                                    </td>
                                </tr>
                            </table>
                        <%-- FIN FIRMA Y REVISION --%>
                        <%-- INICIO ENVIO --%>

                        <table width="100%" border="0" cellspacing="0">
                            <tr>
                                <td width="4%">&nbsp;</td>
                                <td width="20%"><div style="visibility:hidden">
                                        <select name="cbo_Clasificacion" id="cbo_Clasificacion">
                                            <lb:ListaClasificacion></lb:ListaClasificacion>
                                            </select>
                                        </div></td>
                                    <td width="4%">&nbsp;</td>			
                                    <td width="20%">&nbsp;</td>			
                                    <td width="4%">&nbsp;</td>
                                    <td width="20%">&nbsp;</td>
                                    <td width="4%">&nbsp;</td>
                                    <td width="20%">&nbsp;</td>
                                    <td width="4%">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>
                                        <div style="visibility:hidden" >
                                            <button type="button" id="enviar2" class="btn btn-success btn-sm" style="width: 100%" onclick="javascript:f_validacion('ALPARTE');" >ENVIAR AL PARTE</button>
                                        </div>
                                    </td>
                                    <td>&nbsp;</td>			
                                    <td>&nbsp;</td>			
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td><div>
                                            <button type="button" id="enviar1" class="btn btn-success btn-sm" style="width: 100%" onclick="javascript:f_validacion('REVISAR');" >ENVIAR PARA REVISAR</button>
                                        </div>
                                    </td>
                                    <td>&nbsp;</td>			
                                    <td><button type="button" class="btn btn-success btn-sm" style="width: 100%" onclick="javascript:f_vistaprevia();" >VISTA PREVIA</button></td>
                                    <td>&nbsp;</td>
                                    <td><button type="button" class="btn btn-warning btn-sm" style="width: 100%" onclick="javascript:f_borrador();" >GUARDAR BORRADOR</button></td>
                                    <td>&nbsp;</td>
                                    <td><button type="button" class="btn btn-danger btn-sm" style="width: 100%" onclick="javascript:f_cancelar();" >CANCELAR</button></td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td><div align="center" style="visibility:hidden"><button type="button" id="firmar" class="btn btn-success btn-sm" style="width: 100%" onclick="javascript:f_validacion('FIRMAR');" >FIRMA DIGITAL</button></div></td>
                                    <td>&nbsp;</td>			
                                    <td>&nbsp;</td>			
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                            </table>
                        <%-- FIN ENVIO --%>
                    </td>
                    <td width="3%">&nbsp;</td>
                </tr>
            </table>
            <br /><br /><br /><br /><br /><br /><br /><br />

            <%-- VENTANA DE OBSERVACION --%>
            <div class="modal fade" id="miModalObs" role="dialog">
                <div class="modal-dialog modal-sm">                                 
                    <div class="modal-content">                                    
                        <div class="modal-header"  style="background-color:rgb(87, 35, 100)"> 
                            <img src="<%=request.getContextPath()%>/imagenes/icono/chat.png" width="90px" height="50px" align="left" />
                            <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Anotaciones</b></span> 
                            <a href="javascript:f_cerrar_moObs();">  <p style="color:rgb(240, 235, 235);" align="left"><b><i>Cerrar</i></b>&nbsp;<span class="glyphicon glyphicon-arrow-left"></span></p></a>                                      
                        </div>
                        <div class="modal-body">  
                            <div>Observaciones:</div>
                            <div><textarea class="form-control inputstl" rows="7" name="txtObservacion" id="txtObservacion"></textarea></div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-primary" onclick="javascript:f_enviar();">Enviar</button>
                        </div>
                    </div>
                </div>
            </div>

            <%-- VENTANA DE DISTRIBUCION --%>
            <div class="modal fade" id="miModalDis" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color:rgb(51, 122, 183)">
                            <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Distribución</b></span>
                            <a href="javascript:f_cerrar();"><p style="color:rgb(240, 235, 235);" align="right"><b><i>Cerrar</i></b>&nbsp;<span class="glyphicon glyphicon-remove"></span></p></a>
                        </div>
                        <div class="modal-body">
                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="0" bgcolor="#6E6855">
                                <tr>
                                    <td width="35%">
                                        <label class="label-titulo">TIPO ORGANIZACION:</label></td>
                                    <td colspan="5" align="left" valign="middle">
                                        <div align="left" valign="middle">
                                            <input name="tipo" type="radio" value="G" onClick="f_DIS(this.value)" />Ejercito
                                            <input name="tipo" type="radio" value="E" onClick="f_DIS(this.value)" />Externa
                                            <input name="tipo" type="radio" value=I onClick="f_DIS(this.value)" />Interna
                                        </div>
                                    </td>
                                </tr>
                                <tr height="5"></tr>
                                <tr>
                                    <td width="36%">
                                        <label class="label-titulo">ORGANIZACION:</label></td>
                                    <td width="36%" align="left" valign="middle">
                                        <div id="dis_org">
                                            <select name="cboOrganizacion" id="cboOrganizacion" class="form-control selectpicker" data-live-search="true">
                                                <option>--Elija Opcion--</option>
                                            </select>
                                        </div>
                                    </td>
                                    <td width="2%">&nbsp;</td>
                                    <td width="12%"><button type="button" class="btn btn-success btn-sm" style="width: 100%" onclick="javascript:f_agregaDis();" >AGREGAR</button></td>
                                    <td width="2%">&nbsp;</td>
                                    <td width="12%"><button type="button" class="btn btn-warning btn-sm" style="width: 100%" onclick="javascript:f_cerrar();" >RETORNAR AL OFICIO</button></td>
                                </tr>
                                <tr height="5"></tr>
                                <tr>
                                    <td colspan="6">
                                        <div id="tabladis">
                                            <table id="lisDis" class="display" width="100%" border="1">
                                                <thead>
                                                    <tr bgcolor="#B0B199">
                                                        <th style="width: 20%"><div align="center">ORGANIZACION</div></th>
                                                        <th style="width: 60%"><div align="center">RESPONSABLE</div></th>
                                                        <th style="width: 10%"><div align="center">ORIGINAL</div></th>
                                                        <th style="width: 10%"><div align="center">ELIMINAR</div></th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%
                                                        for (int i = 0; i < ListarDistribucion.size(); i++) {
                                                            BeanDistribucion objBeanD = (BeanDistribucion) ListarDistribucion.get(i);
                                                    %>
                                                    <tr>
                                                        <td><div align="center"><%=objBeanD.getDescOrganizacion()%></div></td>
                                                        <td>
                                                            <div><%=objBeanD.getGrado()%></div>
                                                            <div><%=objBeanD.getNombre()%></div>
                                                            <div><i><%=objBeanD.getCargo()%></i></div>
                                                        </td>
                                                        <td><div align="center"><input name="trabajo" type="radio" onClick="javascript:f_enviaDistribucion('<%=objBeanD.getNombre()%>', '<%=objBeanD.getGrado()%>', '<%=objBeanD.getCargo()%>', '<%=objBeanD.getCodigoOrganizacion()%>', '<%=objBeanD.getTipoOrganizacion()%>')"/></div></td>
                                                        <td><div align="center"><a href="javascript:f_elimina('<%=objBeanD.getTipoOrganizacion()%>','<%=objBeanD.getCodigoOrganizacion()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/delete.png" width="35px" height="35px" /></a></div></td>
                                                    </tr>
                                                    <%}%>
                                                </tbody>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr height="5"></tr>
                            </table>
                        </div>                        
                    </div>
                </div>
            </div>

            <%-- VENTANA DE VISTA PREVIA --%>
            <div class="modal fade" id="miModalVP" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color:rgb(225, 30, 0)">
                            <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Vista Previa</b></span>
                            <a href="javascript:f_cerrar_ModVP();"><p style="color:rgb(240, 235, 235);" align="right"><b><i>Cerrar</i></b>&nbsp;<span class="glyphicon glyphicon-remove"></span></p></a>
                        </div>
                        <div class="modal-body">
                            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="0" bgcolor="#6E6855">
                                <tr>
                                    <td>
                                        <div id="mns" style="visibility: visible">Su navegador no soporta visualizar un PDF, se procederá a descargar!!!</div>
                                        <iframe id="salida2" style="width: 100%;height: 400px;visibility: hidden" ></iframe></td>                                        
                                </tr>
                                <tr height="5"></tr>
                            </table>
                        </div>                        
                    </div>
                </div>
            </div>


        </form>
        <!-- Modal (03)::Modal Referencia -->                        
        <div class="modal fade" id="modalReferencia" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header" style="background-color:rgb(51, 122, 183)">
                        <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Referencia</b></span>
                        <a href="javascript:f_cerrar_moReferencia();"><p style="color:rgb(240, 235, 235);" align="right"><b><i>Cerrar</i></b>&nbsp;<span class="glyphicon glyphicon-remove"></span></p></a>
                    </div>
                    <div class="modal-body">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="javascript:f_listaReferencia('<%=objBeanU.getVUSUARIO_CODIGO()%>','<%=objBeanU.getCUSUARIO_COD_ORG()%>')">Lista</a></li>
                            <li><a href="javascript:f_openBusquedaRef()">Busqueda</a></li>
                            <li><a href="javascript:f_openAgregaRef()">Agregar</a></li>
                        </ul>
                        <span id="cuerpoReferencia">&nbsp;</span>
                    </div>
                </div>
            </div>
        </div>
        <!--FIN MODAL Modal Anexo-->

        <%-- VENTANA DE ANEXOS --%>
        <div class="modal fade" id="miModalAnexos" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="background-color:rgb(91, 192, 222)">
                        <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Anexos</b></span>
                        <a href="javascript:f_cerrar_moAnexos();"><p style="color:rgb(240, 235, 235);" align="right"><b><i>Cerrar</i></b>&nbsp;<span class="glyphicon glyphicon-remove"></span></p></a>
                    </div>
                    <div class="modal-body">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="javascript:f_listaAnexo('<%=objBeanU.getVUSUARIO_CODIGO()%>','<%=objBeanU.getCUSUARIO_COD_ORG()%>')">Lista</a></li>
                            <li><a href="javascript:f_openAgregaAne()">Agregar</a></li>
                        </ul>
                        <span id="cuerpoAnexo">&nbsp;</span>
                    </div>
                    <!--FIN -->                                                                     
                </div>
            </div>                        
        </div>
        <!--Inicio Modal VP Referencia-->
        <div class="modal fade" id="modalDocumento" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header" style="background-color:rgb(76, 175, 80)">
                        <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Vista de Referencia</b></span>
                        <a href="javascript:f_cerrar_ModDoc();"><p style="color:rgb(240, 235, 235);" align="right"><b><i>Cerrar</i></b>&nbsp;<span class="glyphicon glyphicon-remove"></span></p></a>
                    </div>
                    <div class="modal-body">
                        <span id="documentovp">&nbsp;</span>
                    </div>
                </div>
            </div>
        </div>
        <!-- Fin Modal VP Referencia-->



        <!-- Modal (04)::Modal ALERTA Envio exitoso-->                        
        <div class="modal fade" id="miModalAlerta"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

            <div class="modal-dialog " role="document">                                 
                <div class="modal-content">                                    
                    <div class="modal-header" style="background-color:rgb(76, 175, 80)">
                        <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Envio Exitoso!!!!</b></span> 
                        <a href="javascript:f_cerrar_moAlerta();"><p style="color:rgb(240, 235, 235);" align="right"><b><i>Cerrar</i></b>&nbsp;<span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                    </div>
                    <div id="modalEnvio">  
                        <table>
                            <tr>                                                                                        
                                <td>                                                    
                                    El documento fue enviado al :<input name="txh_alerta_revisa" type="text" size="50" />para la REVISIÓN correspondiente!!!
                                </td>                                                
                            </tr>
                            <tr>                                                                                        
                                <td>                                                    
                                    <img src="<%=request.getContextPath()%>/imagenes/icono/tranferencia.png" width="600px" height="100px" align="center" />
                                </td>                                                
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <!--FIN MODAL Modal ALERTA-->

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
    </body>
</html>