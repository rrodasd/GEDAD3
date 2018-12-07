<%@include file="cerrarSesion.jsp" %>
<%@page import="sagde.bean.BeanPrioridadDocumento"%>
<%@page import="sagde.bean.BeanPeriodo"%>
<%@page import="sagde.bean.BeanReferencia"%>
<%@page import="sagde.bean.BeanClase"%>
<%@page import="sagde.bean.BeanOrganizacionInterna"%>
<%@page import="comun.RevisaDocumentoDAO"%>
<%@page import="comun.DAOFactory"%>
<%@page import="sagde.bean.BeanArchivo"%>
<%@page import="comun.ComboboxDAO"%>
<%@page import="java.util.Iterator"%>
<%@page import="sagde.bean.BeanUsuarioAD"%>
<%@ page import="sagde.bean.BeanRevisarDocumento"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib uri="/WEB-INF/tlds/libreria.tld" prefix="lb" %>
<%@ page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
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
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/bootstrap-select_Cbx.min.css" />        
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

        <!-- API CERTIFICADO FIGITAL -->
        <script type="text/javascript" src="https://dsp.reniec.gob.pe/refirma_invoker/resources/js/client.js"></script> 



        <%
            BeanUsuarioAD objBeanU = (BeanUsuarioAD) session.getAttribute("usuario");
            session.setAttribute("anexos", null);
            DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
            RevisaDocumentoDAO objRD = objDAOFactory.getRevisaDocumentoDAO();
        %>


        <script type="text/javascript">

            //<![CDATA[
            var documentName_ = null;
            //
            window.addEventListener('getArguments', function (e) {
                ObtieneArgumentosParaFirmaDesdeLaWeb();
            });

            window.addEventListener('invokerOk', function (e) {
                MiFuncionOkWeb();
            });

            window.addEventListener('invokerCancel', function (e) {
                MiFuncionCancel();
            });

            function getArguments() {
                arg = document.getElementById("argumentos").value;
                dispatchEventClient('sendArguments', arg);
            }

            /**
             * Metodo que permite pasar argumentos para que pueda firmarse desde la web
             * @returns 
             */
            function ObtieneArgumentosParaFirmaDesdeLaWeb() {
                // Se debe generar un nuevo Servlet

                $.post("argumentos", {
                    documentName: "2018006173.pdf",
                    nroUnicoDoc: btoa(document.all.txt_nro_unico_OF.value),
                    orgint_origen: btoa(document.all.cbo_OrgDependencia.options[document.all.cbo_OrgDependencia.selectedIndex].text),
                    nombreanio: btoa(document.all.txt_NombreAnio.value),
                    guarnicion: btoa(document.all.txt_Guarnicion.value),
                    fecha: btoa(document.all.txt_Fecha.value),
                    orgint_redacta: btoa(document.all.txt_Clave.value),
                    archivo: btoa(document.all.cboArchivoIndicativo.options[document.all.cboArchivoIndicativo.selectedIndex].text),
                    grado_distribucion: btoa(document.all.txt_Grado.value),
                    cargo_distribucion: btoa(document.all.txt_Cargo.value),
                    asunto: btoa(document.all.txt_Asunto.value),
                    cuerpo: btoa(btoa(CKEDITOR.instances.cuerpo.getData()))


                }, function (data, status) {
                    document.getElementById("argumentos").value = data;
                    getArguments();
                });
            }

            /**
             * Si puede firmar el documento mostrará un mensaje de confirmación
             * @returns {undefined}
             */
            function MiFuncionOkWeb() {
                alert("Documento firmado desde una URL correctamente00000000.");
                //document.getElementById("signedDocument").href="getFileServlet?documentName=" + documentName_; // A validar

                //Se enviará MifuncionSaveOfFD servlet para guardar en la base de datos despues de haber firmado digitalmente
                MifuncionSaveOfFD();

            }


            function MifuncionSaveOfFD() {

                f_tranferencia('FIRMADIGITAL');

            }

            /**
             * Solo si decide cancelar la firma
             * @returns {undefined}
             */
            function MiFuncionCancel() {
                alert("El proceso de firma digital fue cancelado.");
            }


            function f_cerrar_moDetalleEnvio() {
                $('#miModalEnvio').modal('hide');
            }
        </script>    

        <!--     FIN LIBRERIAS ESTANDAR   -->       
        <style type="text/css">

            #moopio, #moopio a{
                background-color: #9ADACD;
                height: 50px;
                width: 100%;
                font-size: 22px;
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

            #moopio1, #moopio1 a{
                background-color: #BBE6DD;
                height: 50px;
                width: 100%;
                font-size: 22px;
                color: #828282;
            }

            #moopio1 a{
                display:block;
            }

            #moopio1 a:hover {
                background-color: #4FBFA8;
                cursor:default;
                font-size: 26px;
                color: #D7D7D7;
            }

            .EstiloOF {
                font-family: "Century Gothic", CenturyGothic, AppleGothic, sans-serif;
                font-size: 12px;
                font-style: normal;
                font-variant: normal;
            }

            /* Posicion del Modal Distribucion*/
            #miModalDistribucion {
                top:15%;
                left: 55%;
                outline: none;
            }

            /* Posicion del Modal Distribucion*/
            #miModalAnexo {
                top:5%;
                left: 53%;
                outline: none;
            }

            #miModalEnvio {
                top:2%;
                left: 78%;
                outline: none;
                width: 20%;	
            }

            #miModalDevolver {
                top:2%;
                left: 78%;
                outline: none;
                width: 20%;	
            }

            #miModalAlerta {
                top:20%;            
                outline: none;
            }

            #miModalObs {
                top:2%;
                left: 78%;
                outline: none;
                width: 20%;	
            }

            #miModalVerAnexos {
                top:2%;
                right: 10%;
                outline: none;
            }

            #miModalBusquedaRef {
                top:5%;
                left: 53%;
                outline: none;
            }

            #miModalAgregarRef {
                top:5%;
                left: 53%;
                outline: none;
            }

        </style>
        <script type="text/javascript">

            //Dar formato a las tablas
            $(document).ready(function () {
                $('table.display').DataTable();
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
            });
            //Variable global para ContextPath
            var ctx_path = "<%= request.getContextPath()%>";

            function mostrar(nombreCapa) {
                document.getElementById(nombreCapa).style.visibility = "visible";
            }

            function ocultar(nombreCapa) {
                document.getElementById(nombreCapa).style.visibility = "hidden";
            }
            /*
             * 
             *    FIRMA DIGITAL
             */

            var ajaxNroUnico = null;
            function funcionCallbackNroUnico() {
                if (ajaxNroUnico.readyState === 4 && ajaxNroUnico.status === 200) {
                    document.all.div_Nro_Unico_OF.innerHTML = ajaxNroUnico.responseText;
                    //$('.selectpicker').selectpicker({style: 'btn-info',size: 10 });
                }
            }

            function f_FirmaDigital() {

                var reporte = "REV_08";
                if (window.XMLHttpRequest) {
                    ajaxNroUnico = new XMLHttpRequest();
                } else {
                    ajaxNroUnico = new ActiveXObject("Microsoft.XMLHTTP");
                }
                ajaxNroUnico.onreadystatechange = funcionCallbackNroUnico;
                var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=" + new Date().getTime() + "&reporte=" + reporte;
                ajaxNroUnico.open("GET", ruta, true);
                ajaxNroUnico.send("");

                alert("Firma Digital con el Sistema GEDAD - CINFE");

                // Se debe llamar a la firma digital            
                // insertFrame();
                initInvoker('W');
            }



            //--------------------------------------------------------------------------------------------------------------

            function f_listar(dependencia) {
                var reporte = "REV_01";

                if (isEq(dependencia, SEL_DEPENDENCIA_VACIO)) {
                    $("#listado").html("");
                    alert("vacio");
                    return;
                }
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=",
                        new Date().getTime(),
                        "&reporte=", reporte,
                        "&dependencia=",
                        dependencia
                        );

                $("#listado").load(ruta, function () {
                    $('#example').DataTable();
                });
            }

            function f_visualizardoc(codint, clase, periodo, secuencia, r_observa) {
                document.all.area_obs.value = r_observa;
                if(r_observa!==""){
                    $('#miModalObs').modal('show');
                }
                $('#miModalREVISAR').modal({backdrop: 'static', keyboard: false});
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=",
                        new Date().getTime(),
                        "&codint=", codint,
                        "&clase=", clase,
                        "&periodo=", periodo,
                        "&secuencia=", secuencia,
                        "&reporte=", OPC_MUESTRA_OFICIO);
                $("#regmodal").load(ruta, function () {});
            }

            function f_openDistribucion(cod_org_cab, periodo, cod_interno) {
                $('#miModalObs').modal('hide');
                var verifica = document.formRevisar.txh_verifica.value;
                $('#miModalDistribucion').modal({backdrop: 'static', keyboard: false});
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Distribucion_ajax.jsp?pasacache=",
                        new Date().getTime(),
                        "&cod_org_cab=", cod_org_cab.trim(),
                        "&periodo=", periodo,
                        "&cod_interno=", cod_interno,
                        "&verifica=", verifica,
                        "&reporte=", OPC_MUESTRA_DISTRIBUCION);
                $("#modalDistribucion").load(ruta, function () {
                    $('#distri').DataTable();
                    //Retorna  Bootstrap y le da formato requerido a la Combo en Linea, solo con 10 linea visibles   
                    $('.selectpicker').selectpicker({style: 'btn-info', size: 10});
                });
                //IMPORTANTE::::Solo le cambia el valor a la caja de texto verifica apara que no deje cerrar el modal distribucion si antes no hizo cheked
                document.formRevisar.txh_verifica.value = "SI";
            }

            function f_DIS(tipo) {
                var reporte = "DIST_05";
                var interna = document.all.cbo_OrgDependencia.value;
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Distribucion_ajax.jsp?pasacache=",
                        new Date().getTime(),
                        "&reporte=", reporte,
                        "&interna=", interna,
                        "&tipo=", tipo);
                $("#dis_org").load(ruta, function () {
                    $('.selectpicker').selectpicker({style: 'btn-info', size: 10});
                });
            }

            function f_AgregarDestinatarios() {
                //Variable que s envi al AJAX para agregar a los destinatario     
                //var v_tipo_organizacion = document.formRevisar.tipoOrg.value;
                var v_destinatario = document.all.org.value;
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
                } else if (v_destinatario === "--Elija Opcion--") {
                    alert("Seleccione Organizacion");
                } else {
                    var reporte = "DIST_02";
                    var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Distribucion_ajax.jsp?pasacache=",
                            new Date().getTime(),
                            "&reporte=", reporte,
                            "&v_tipo_organizacion=", tipo,
                            "&v_destinatario=", v_destinatario);
                    $("#modalDestinatario").load(ruta, function () {
                        $('#distri').DataTable();

                    });
                }
            }

            function f_CapturaDestinarario(Nombre_dest, Grado_dest, Cargo_dest, tipo_dist, Cod_organizacion, Tipo_Organizacion) {
                document.formRevisar.txt_Grado.value = Grado_dest;
                document.formRevisar.txt_Cargo.value = Cargo_dest;
                //*para Pintar el Pie Destinatario o distribucion
                var periodo = document.formRevisar.txh_periodo.value;
                var cod_interno = document.formRevisar.txh_cod_int.value;
                document.formRevisar.txh_verifica.value = "SI";

                var reporte = "DIST_04";
                if (window.XMLHttpRequest) {
                    ajaxPieDistribucion = new XMLHttpRequest();
                } else {
                    ajaxPieDistribucion = new ActiveXObject("Microsoft.XMLHTTP");
                }
                ajaxPieDistribucion.onreadystatechange = funcionCallbackPieDistribucion;
                var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_Distribucion_ajax.jsp?pasacache=" + new Date().getTime() + "&reporte=" + reporte + "&periodo=" + periodo + "&cod_interno=" + cod_interno + "&cod_organizacion=" + Cod_organizacion + "&tipo_dist=" + tipo_dist;
                ajaxPieDistribucion.open("GET", ruta, true);
                ajaxPieDistribucion.send("");
            }

            var ajaxPieDistribucion = null;
            function funcionCallbackPieDistribucion() {
                if (ajaxPieDistribucion.readyState === 4 && ajaxPieDistribucion.status === 200) {
                    document.all.AjaxPieDestinatario.innerHTML = ajaxPieDistribucion.responseText;
                }
            }

            function f_cerrar() {
                $('#miModalDistribucion').modal('hide');
                var reporte = "DIST_06";
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Distribucion_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte
                        );
                $("#AjaxPieDestinatario").load(ruta, function (status, xhr) {
                    if (status === "error") {
                        var msg = "Error!, algo ha sucedido: ";
                        $("#AjaxPieDestinatario").html(msg + xhr.status + " " + xhr.statusText);
                    }
                });
            }

            function f_openReferencia(periodo, cod_interno) {
                $('#miModalObs').modal('hide');
                $('#miModalReferencia').modal({backdrop: 'static', keyboard: false});
                var reporte = "REF_05";
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=", new Date().getTime(),
                        "&periodo_orig=", periodo,
                        "&codint_orig=", cod_interno,
                        "&reporte=", reporte);
                $("#span_lista_ref_principal").load(ruta, function () {
                    $('#listaReferencia').DataTable();
                    $('.selectpicker').selectpicker({style: 'btn-info', size: 10});
                });
            }

            function f_MostraReferencia(periodo_origen, cod_int_origen, periodo_ref, cod_int_ref) {
                $('#miModalVerReferencia').modal('show');
                var reporte = "REF_06";
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=" + new Date().getTime() +
                        "&reporte=", reporte,
                        "&periodo_origen=", periodo_origen,
                        "&cod_int_origen=", cod_int_origen,
                        "&periodo_ref=", periodo_ref,
                        "&cod_int_ref=", cod_int_ref);
                $("#modalMostarReferencia").load(ruta, function () {});
            }

            function f_eliminarReferencia(periodo_orig, codint_orig, periodo_ref, codint_ref) {
                var reporte = "REF_11";
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=" + new Date().getTime() +
                        "&reporte=", reporte,
                        "&periodo_orig=", periodo_orig,
                        "&codint_orig=", codint_orig,
                        "&periodo_ref=", periodo_ref,
                        "&codint_ref=", codint_ref);
                $("#span_lista_ref_principal").load(ruta, function () {
                    $('#listaReferencia').DataTable();
                    var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=" + new Date().getTime() +
                            "&reporte=REF_04" +
                            "&codint_orig=" + codint_orig +
                            "&periodo_orig=" + periodo_orig;
                    $("#pinta_ref").load(ruta, function () {});
                });
            }

            function f_Ref_Opcion_Busqueda() {
                var reporte = "REF_07";
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=" + new Date().getTime() +
                        "&reporte=", reporte);
                $("#span_lista_ref_principal").load(ruta, function () {
                    $('.selectpicker').selectpicker({style: 'cbo_Periodo', size: 10});
                    $('.selectpicker').selectpicker({style: 'cbx_Clase_Doc', size: 10});
                    $('.selectpicker').selectpicker({style: 'cbo_Tipo_Organizacion', size: 10});
                    $('.selectpicker').selectpicker({style: 'org_ref', size: 10});
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

            function f_org_referencia(tipo) {
                var reporte = "REF_02";
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte,
                        "&tipo=", tipo);
                $("#dis_org_ref").load(ruta, function () {
                    $('.selectpicker').selectpicker({style: 'btn-info', size: 10});
                });
            }

            function f_Buscar_Referencia() {
                var cbo_Tipo_Organizacion = document.all.cbo_Tipo_Organizacion.value;
                var org_ref = document.all.org_ref.value;
                var txtFecDesde = document.all.txtFecDesde.value;
                var txtFecHasta = document.all.txtFecHasta.value;
                var cbx_Clase_Doc = document.all.cbx_Clase_Doc.value;
                var txt_nro_doc = document.all.txt_nro_doc.value;
                var txt_Asunto_Ref = document.all.txt_Asunto_Ref.value;
                var cbo_Periodo = document.all.cbo_Periodo.value;

                var reporte = "REF_01";
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=", new Date().getTime(),
                        "&cbo_Tipo_Organizacion=", cbo_Tipo_Organizacion,
                        "&org_ref=", org_ref,
                        "&txtFecDesde=", txtFecDesde,
                        "&txtFecHasta=", txtFecHasta,
                        "&cbx_Clase_Doc=", cbx_Clase_Doc,
                        "&txt_nro_doc=", txt_nro_doc,
                        "&txt_Asunto_Ref=", txt_Asunto_Ref,
                        "&cbo_Periodo=", cbo_Periodo,
                        "&reporte=", reporte);
                $("#modalListaBusRef").load(ruta, function () {
                    $('#listaReferenciaBusqueda').DataTable();
                });
            }

            function f_agrega_refe(periodo_ref, codint_ref) {
                var periodo_orig = document.all.txh_periodo_rev.value;
                var codint_orig = document.all.txh_cod_int_rev.value;
                var reporte = "REF_03";
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte,
                        "&periodo_ref=", periodo_ref,
                        "&codint_ref=", codint_ref,
                        "&codint_orig=", codint_orig,
                        "&periodo_orig=", periodo_orig);
                $("#span_lista_ref_principal").load(ruta, function () {
                    $('#listaReferencia').DataTable();
                });
            }

            function f_listaReferencia() {
                var periodo = document.formRevisar.txh_periodo_rev.value;
                var codint = document.formRevisar.txh_cod_int_rev.value;
                f_openReferencia(periodo, codint);
            }

            function f_Ref_Opcion_Agregar() {
                var reporte = "REF_08";
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte);
                $("#span_lista_ref_principal").load(ruta, function () {
                    $('.selectpicker').selectpicker({style: 'cbo_Periodo_Agr_ref', size: 10});
                    $('.selectpicker').selectpicker({style: 'cbx_Clase_Doc_Agr_Ref', size: 10});
                    $('.selectpicker').selectpicker({style: 'cbo_Tipo_Organizacion_Agr_Ref', size: 10});
                    $('.selectpicker').selectpicker({style: 'org_Agr_Ref', size: 10});
                    $('.selectpicker').selectpicker({style: 'cbx_Clasificacion_Agr_Ref', size: 10});
                    $('.selectpicker').selectpicker({style: 'cbx_Prioridad_Agr_Ref', size: 10});
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

            function f_Grabar_Referencia() {
                var perido_orig = document.formRevisar.txh_periodo_ref.value;
                var cod_int_orig = document.formRevisar.txh_cod_int_ref.value;
                var cbo_Periodo = document.all.cbo_Periodo_Agr_ref.value;
                var cbo_Tipo_Organizacion = document.all.cbo_Tipo_Organizacion_Agr_Ref.value;
                var org = document.all.org_Agr_Ref.value;
                var cbx_Clase_Doc = document.all.cbx_Clase_Doc_Agr_Ref.value;
                var txt_Nro_Orden = document.all.txt_Nro_Orden_Agr_Ref.value;
                var txt_Clave_Indic = document.all.txt_Clave_Indic_Agr_Ref.value;
                var txt_fecha_MP = document.all.txt_fecha_Agr_Ref.value;
                var txt_Asunto_MP = document.all.txt_Asunto_Agr_Ref.value;
                var cbx_Clasificacion = document.all.cbx_Clasificacion_Agr_Ref.value;
                var cbx_Prioridad = document.all.cbx_Prioridad_Agr_Ref.value;
                var accion = "insertar_Referencia";
                var frm_referencia = $("#frm_referencia")[0];
                frm_referencia.action = ctx_path.concat("/GrabarReferencia?cbo_Periodo=", cbo_Periodo,
                        "&cbo_Tipo_Organizacion=", cbo_Tipo_Organizacion,
                        "&org=", org,
                        "&cbx_Clase_Doc=", cbx_Clase_Doc,
                        "&txt_Nro_Orden=", txt_Nro_Orden,
                        "&txt_Clave_Indic=", txt_Clave_Indic,
                        "&txt_fecha_MP=", txt_fecha_MP,
                        "&txt_Asunto_MP=", txt_Asunto_MP,
                        "&cbx_Clasificacion=", cbx_Clasificacion,
                        "&cbx_Prioridad=", cbx_Prioridad,
                        "&perido_orig=", perido_orig,
                        "&cod_int_orig=", cod_int_orig,
                        "&accion=", accion);
                frm_referencia.submit();
                var reporte = "REF_04";
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte,
                        "&codint_orig=", cod_int_orig,
                        "&periodo_orig=", perido_orig);
                $("#pinta_ref").load(ruta, function () {
                });
            }

            function f_cancelar() {
                $('#miModalReferencia').modal('hide');
                var perido_orig = document.formRevisar.txh_periodo_ref.value;
                var cod_int_orig = document.formRevisar.txh_cod_int_ref.value;
                var reporte = "REF_04";
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", reporte,
                        "&codint_orig=", cod_int_orig,
                        "&periodo_orig=", perido_orig);
                $("#pinta_ref").load(ruta, function () {
                });
            }

            function f_openAnexoVentana(periodo, cod_interno) {
                document.all.txh_periodo_rev.value = periodo;
                document.all.txh_cod_int_rev.value = cod_interno;
                $('#miModalObs').modal('hide');
                $('#miModalAnexo').modal({backdrop: 'static', keyboard: false});
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Anexos_ajax.jsp?pasacache=", new Date().getTime(),
                        "&periodo=", periodo,
                        "&cod_interno=", cod_interno,
                        "&reporte=", OPC_LISTAR_ANEXOS);
                $("#cuerpoAnexo").load(ruta, function () {
                    $('#table_anexos').DataTable();
                });
            }

            function f_openAgregaAne() {
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Anexos_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", OPC_FORM_NUEVO_ANEXOS);
                $("#cuerpoAnexo").load(ruta, function () {
                });
            }

            function f_listaAnexo() {
                var periodo = document.all.txh_periodo_rev.value;
                var cod_interno = document.all.txh_cod_int_rev.value;
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Anexos_ajax.jsp?pasacache=", new Date().getTime(),
                        "&periodo=", periodo,
                        "&cod_interno=", cod_interno,
                        "&reporte=", OPC_LISTAR_ANEXOS);
                $("#cuerpoAnexo").load(ruta, function () {
                    $('#table_anexos').DataTable();
                });
            }

            function f_grabar_anexo() {
                var accion = "insertar_anexos";
                var periodo = document.all.txh_periodo_rev.value;
                var cod_interno = document.all.txh_cod_int_rev.value;
                var frm_anexos = $("#frm_anexos")[0];
                frm_anexos.action = ctx_path.concat("/capturaAnexos_RD?accion=", accion,
                        "&periodo=", periodo,
                        "&cod_interno=", cod_interno);
                frm_anexos.submit();
                alert("Archivo agregado con exito");
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Anexos_ajax.jsp?pasacache=", new Date().getTime(),
                        "&periodo=", periodo,
                        "&cod_interno=", cod_interno,
                        "&reporte=", OPC_LISTAR_ANEXOS);
                $("#cuerpoAnexo").load(ruta, function () {
                    $('#table_anexos').DataTable();
                });
            }

            function f_verAnexo(token, archivo) {
                if (token === "null") {
                    alert("Documento sin Token, imposible de recuperar");
                } else {
                    var extension = archivo.split(".")[1];
                    archivo = btoa(archivo);
                    if (extension === "pdf" || extension === "PDF" || extension === "txt" || extension === "TXT") {
                        $('#miModalVerAnexos').modal({backdrop: 'static', keyboard: false});
                    }
                    var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Anexos_ajax.jsp?pasacache=", new Date().getTime(),
                            "&reporte=", OPC_MOSTRAR_ANEXO,
                            "&token=", token,
                            "&archivo=", archivo);
                    $("#modalMostarAnexos").load(ruta, function () {});
                }
            }

            function f_eliminarAnexo(secuencia) {
                var periodo = document.all.txh_periodo_rev.value;
                var cod_interno = document.all.txh_cod_int_rev.value;
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Anexos_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", OPC_ELIMINAR_ANEXO,
                        "&periodo=", periodo,
                        "&cod_interno=", cod_interno,
                        "&secuencia=", secuencia);
                alert("Archivo eliminado con exito");
                $("#modalMostarAnexos").load(ruta, function () {
                    $('#table_anexos').DataTable();
                });
            }

            function f_terminar(firma, recibe) {

                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", OPC_MUESTRA_ENVIO,
                        "&firma=", firma,
                        "&recibe=", recibe,
                         "&formulario=revisar");
                $("#div_cbx_firmado").load(ruta, function () {
                    var usuario_logeado = "<%=objBeanU.getVUSUARIO_CODIGO()%>";
                    if (document.all.cbo_firmadoPor.value === document.all.cbo_revisadoPor.value &&
                            document.all.cbo_firmadoPor.value === usuario_logeado) {
                        document.all.txh_accion_botones.value = "Btn_firma_digital";
                    } else {
                        if (document.all.cbo_firmadoPor.value === document.all.cbo_revisadoPor.value) {
                            document.all.txh_accion_botones.value = "Btn_Al_Parte";
                        } else {
                            document.all.txh_accion_botones.value = "Btn_Revisar";
                        }
                    }
                    var accion_Botones = document.all.txh_accion_botones.value;
                    ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=", new Date().getTime(),
                            "&reporte=REV_07",
                            "&accion_Botones=", accion_Botones);
                    $("#div_accion_btn").load(ruta, function () {});
                    $('#miModalObs').modal('hide');
                    $('#miModalEnvio').modal({backdrop: 'static', keyboard: false});
                    $('#miModalDevolver').modal('hide');
                });

            }

            var ajaxAccionBtn = null;
            function funcionCallbackAccionBtn() {
                if (ajaxAccionBtn.readyState === 4 && ajaxAccionBtn.status === 200) {
                    document.all.div_accion_btn.innerHTML = ajaxAccionBtn.responseText;
                    //$('.selectpicker').selectpicker({style: 'btn-info',size: 10 });
                }
            }


            var ajaxSalida = null;
            function funcionCallbackSalida() {
                if (ajaxSalida.readyState === 4 && ajaxSalida.status === 200) {
                    document.all.salida.innerHTML = ajaxSalida.responseText;
                }
            }
            function f_vistaprevia() {
                if (document.all.cbo_firmadoPor.value !== "000") {
                    var reporte = "REV_05";
                    var orgint_origen = btoa(document.all.cbo_OrgDependencia.options[document.all.cbo_OrgDependencia.selectedIndex].text);
                    var nombreanio = btoa(document.all.txt_NombreAnio.value);
                    var guarnicion = btoa(document.all.txt_Guarnicion.value);
                    var fecha = btoa(document.all.txt_Fecha.value);
                    var orgint_redacta = btoa(document.all.txt_Clave.value);
                    var archivo = btoa(document.all.cboArchivoIndicativo.options[document.all.cboArchivoIndicativo.selectedIndex].text);
                    var grado_distribucion = btoa(document.all.txt_Grado.value);
                    var cargo_distribucion = btoa(document.all.txt_Cargo.value);
                    var asunto = btoa(document.all.txt_Asunto.value);
                    var cuerpo = btoa(btoa(CKEDITOR.instances.cuerpo.getData()));
                    var cargo_firmante = btoa(document.all.cbo_firmadoPor.options[document.all.cbo_firmadoPor.selectedIndex].text);
                    $('#miModalVP').modal('show');
                    var ruta = "pasacache=" + new Date().getTime() +
                            "&orgint_origen=" + orgint_origen +
                            "&nombreanio=" + nombreanio +
                            "&guarnicion=" + guarnicion +
                            "&fecha=" + fecha +
                            "&orgint_redacta=" + orgint_redacta +
                            "&archivo=" + archivo +
                            "&grado_distribucion=" + grado_distribucion +
                            "&cargo_distribucion=" + cargo_distribucion +
                            "&asunto=" + asunto +
                            "&cuerpo=" + cuerpo +
                            "&cargo_firmante=" + cargo_firmante +
                            "&reporte=" + reporte;
                    $.ajax({
                        type: "post",
                        url: "<%= request.getContextPath()%>/r_oficioRevisarvp",
                        data: ruta,
                        cache: false,
                        success: function (xhr) {
                            var blob = b64toBlob(xhr, "application/pdf");
                            if (window.navigator && window.navigator.msSaveOrOpenBlob) {
                                window.navigator.msSaveOrOpenBlob(blob, 'vprevia.pdf');
                                $("#mns").css("visibility", "visible");
                                $("#salida2").css("visibility", "hidden");
                            } else {
                                //console.log(xhr);
                                //var blob = b64toBlob(xhr, "application/pdf");
                                var hrefShowInObject = window.URL.createObjectURL(blob);
                                $("#salida2").attr("src", hrefShowInObject);
                                //console.log(hrefShowInObject);
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

            function f_habilitar(f_accion) {
                /*
                 * 
                 * @Muestra la simulacion de la firma Digital
                 */

                var usuario_logeado = "<%=objBeanU.getVUSUARIO_CODIGO()%>";
                if (f_accion === 'firmado_por') {
                    var posTO = document.all.cbo_firmadoPor.options.selectedIndex;
                    var des_to = document.all.cbo_firmadoPor.options[posTO].text;
                    document.all.txt_firma_dig.value = des_to;
                    document.location.href = "#ancla_revisa_arriba";
                    mostrar("div_firma_digital");
                    //mostrar("div_revisado_por");    
                }
                if (f_accion === 'revisado_por') {

                    mostrar("div_observacion_enviar");
                }


                /*
                 * 
                 * @Accion cuando se elije en el Combo Firmado por y Revisado por
                 */

                if (document.all.cbo_firmadoPor.value === document.all.cbo_revisadoPor.value &&
                        document.all.cbo_firmadoPor.value === usuario_logeado) {
                    document.all.txh_accion_botones.value = "Btn_firma_digital";

                } else {
                    if (document.all.cbo_firmadoPor.value === document.all.cbo_revisadoPor.value) {
                        document.all.txh_accion_botones.value = "Btn_Al_Parte";

                    } else {
                        document.all.txh_accion_botones.value = "Btn_Revisar";

                    }
                }
                var accion_Botones = document.all.txh_accion_botones.value;

                var reporte = "REV_07";
                if (window.XMLHttpRequest) {
                    ajaxAccionBtn = new XMLHttpRequest();
                } else {
                    ajaxAccionBtn = new ActiveXObject("Microsoft.XMLHTTP");
                }
                ajaxAccionBtn.onreadystatechange = funcionCallbackAccionBtn;
                var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=" + new Date().getTime() + "&reporte=" + reporte + "&accion_Botones=" + accion_Botones;
                ajaxAccionBtn.open("GET", ruta, true);
                ajaxAccionBtn.send("");


            }


            function f_tranferencia(accion) {
             

                var cboDependencia = document.all.cboDependencia.value;               
                var cbo_OrgDependencia = document.all.cbo_OrgDependencia.value;                 
                var txt_Clave = document.all.txt_Clave.value;                
                var cboArchivoIndicativo = document.all.cboArchivoIndicativo.value;                  
                var txt_Asunto = btoa(document.all.txt_Asunto.value);                
                var cuerpo = btoa(btoa(CKEDITOR.instances.cuerpo.getData()));                  
                var cbo_Prioridad = document.all.cbo_Prioridad.value;                
                if (accion=='BORRADOR'){
                      var cbo_revisadoPor = "";
                      var cbo_firmadoPor = ""
                }else {
                 var cbo_revisadoPor = document.all.cbo_revisadoPor.value;                
                 var cbo_firmadoPor = document.all.cbo_firmadoPor.value;                
                
                 }             
                var txA_Obs_Enviar = btoa(document.all.area_obs_enviar.value);
                
                if ((cbo_revisadoPor == "000") || (cbo_firmadoPor == "000")) {
                    alert("Eliga Quien firmara");

                } else {
                    var accion_enviar = accion;
                    var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=", new Date().getTime(),
                            "&reporte=REV_03",
                            "&cbo_OrgDependencia=", cbo_OrgDependencia,
                            "&txt_Clave=", txt_Clave,
                            "&cboArchivoIndicativo=", cboArchivoIndicativo,
                            "&txt_Asunto=", txt_Asunto,
                            "&txt_cuerpo=", cuerpo,
                            "&cbo_Prioridad=", cbo_Prioridad,
                            "&cbo_revisadoPor=", cbo_revisadoPor,
                            "&cbo_firmadoPor=", cbo_firmadoPor,
                            "&txA_Obs_Enviar=", txA_Obs_Enviar,
                            "&accion_enviar=", accion_enviar);
                    $("#modalMostarAnexos").load(ruta, function () {
                        $('#miModalEnvio').modal('hide');
                        $('#miModalREVISAR').modal('hide');
                        var posTO = document.all.cbo_revisadoPor.options.selectedIndex;
                        var des_to = document.all.cbo_revisadoPor.options[posTO].text;
                        document.all.txh_alerta_revisa.value = des_to;
                        $('#miModalAlerta').modal({backdrop: 'static', keyboard: false});
                        ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=",
                                new Date().getTime(),
                                "&reporte=REV_01",
                                "&dependencia=", cboDependencia);
                        $("#listado").load(ruta, function () {
                            $('#example').DataTable();
                        });
                    });
                }
            }

            var ajaxEnviaRevisar = null;
            function funcionCallbackEnviaRevisar() {
                if (ajaxEnviaRevisar.readyState === 4 && ajaxEnviaRevisar.status === 200) {
                    document.all.ajaxrevisar.innerHTML = ajaxEnviaRevisar.responseText;
                }
            }


/*

            function f_devolverdocumento() {         
            

                var cbo_OrgDependencia = document.all.cbo_OrgDependencia.value;
                var txt_Clave = document.all.txt_Clave.value;
                var cboArchivoIndicativo = document.all.cboArchivoIndicativo.value;
                var txt_Asunto = btoa(document.all.txt_Asunto.value);
                var cuerpo = btoa(btoa(CKEDITOR.instances.cuerpo.getData()));
                var cbo_Prioridad = document.all.cbo_Prioridad.value;
                var txA_Obs_Enviar = btoa(document.all.txA_Obs.value);

                var accion_enviar = "DEVOLVER";

                var reporte = "REV_04";
                if (window.XMLHttpRequest) {
                    ajaxEnviaRevisar = new XMLHttpRequest();
                } else {
                    ajaxEnviaRevisar = new ActiveXObject("Microsoft.XMLHTTP");
                }
                ajaxEnviaRevisar.onreadystatechange = funcionCallbackEnviaRevisar;
                var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=" + new Date().getTime() + "&reporte=" + reporte +
                        "&cbo_OrgDependencia=" + cbo_OrgDependencia +
                        "&txt_Clave=" + txt_Clave +
                        "&cboArchivoIndicativo=" + cboArchivoIndicativo +
                        "&txt_Asunto=" + txt_Asunto +
                        "&txt_cuerpo=" + cuerpo +
                        "&cbo_Prioridad=" + cbo_Prioridad +
                        "&txA_Obs_Enviar=" + txA_Obs_Enviar +
                        "&accion_enviar=" + accion_enviar;
                
                ajaxEnviaRevisar.open("GET", ruta, true);
                ajaxEnviaRevisar.send("");

                $('#miModalEnvio').modal('hide');
                $('#miModalREVISAR').modal('hide');
                $('#miModalDevolver').modal('hide');

                $('#miModalAlertaDevolver').modal({backdrop: 'static', keyboard: false});

                setTimeout(f_listar(cboDependencia), 2000);

            }
            
            */
               
               
    function f_devolverdocumento() {   
                var cbo_OrgDependencia = document.all.cbo_OrgDependencia.value;
                var txt_Clave = document.all.txt_Clave.value;
                var cboArchivoIndicativo = document.all.cboArchivoIndicativo.value;
                var txt_Asunto = btoa(document.all.txt_Asunto.value);
                var cuerpo = btoa(btoa(CKEDITOR.instances.cuerpo.getData()));
                var cbo_Prioridad = document.all.cbo_Prioridad.value;
                var txA_Obs_Enviar = btoa(document.all.txA_Obs.value);
                var cboDependencia = document.all.cboDependencia.value;  

                var accion_enviar = "DEVOLVER";

                var reporte = "REV_04";
              
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=",new Date().getTime(),
                        "&reporte=", reporte,
                        "&cbo_OrgDependencia=",cbo_OrgDependencia,
                        "&txt_Clave=",txt_Clave ,
                        "&cboArchivoIndicativo=",cboArchivoIndicativo,
                        "&txt_Asunto=", txt_Asunto,
                        "&txt_cuerpo=",cuerpo,
                        "&cbo_Prioridad=",cbo_Prioridad,
                        "&txA_Obs_Enviar=",txA_Obs_Enviar,
                        "&accion_enviar=",accion_enviar);
                        
                    $("#ajaxrevisar").load(ruta, function () {                        
                        $('#miModalEnvio').modal('hide');
                        $('#miModalREVISAR').modal('hide');
                        $('#miModalDevolver').modal('hide');
                        $('#miModalAlertaDevolver').modal({backdrop: 'static', keyboard: false});                          
                      
                        ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=",
                                new Date().getTime(),
                                "&reporte=REV_01",
                                "&dependencia=", cboDependencia);
                        $("#listado").load(ruta, function () {
                            $('#example').DataTable();
                        });
                    });
   
            }
           
               
    
    
    


            function f_Borrador() {

            }
            function f_Abredevolver() {
                $('#miModalObs').modal('hide');
                $('#miModalDevolver').modal({backdrop: 'static', keyboard: false});
                $('#miModalEnvio').modal('hide');

            }

            //Cerrado de Modales
            function f_cerrar_moObs() {
                $('#miModalObs').modal('hide');
            }
            function f_cerrar_moDistribucion() {
                $('#miModalDistribucion').modal('hide');

            }
            function f_cerrar_moReferencia() {
                $('#miModalReferencia').modal('hide');
                var periodo_orig = document.all.txh_periodo_rev.value;
                var codint_orig = document.all.txh_cod_int_rev.value;
                var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=" + new Date().getTime() +
                        "&reporte=REF_04" +
                        "&codint_orig=" + codint_orig +
                        "&periodo_orig=" + periodo_orig;
                $("#pinta_ref").load(ruta, function () {});
            }
            function f_cerrar_verReferencia() {
                $('#miModalVerReferencia').modal('hide');
            }
            function f_cerrar_moAnexos() {
                $('#miModalAnexo').modal('hide');
                var periodo = document.all.txh_periodo_rev.value;
                var cod_interno = document.all.txh_cod_int_rev.value;
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Anexos_ajax.jsp?pasacache=", new Date().getTime(),
                        "&reporte=", OPC_DEVUELVE_ANEXOS_OFICIO,
                        "&periodo=", periodo,
                        "&cod_interno=", cod_interno);
                $("#listaAnexos").load(ruta, function () {});
            }

            function f_cerrar_verAnexos() {
                $('#miModalVerAnexos').modal('hide');
            }

            function f_cerrar_moAlerta() {
                $('#miModalAlerta').modal('hide');
            }

            function f_cerrar_moDetalleEnvio() {
                $('#miModalEnvio').modal('hide');
                document.all.txh_accion_botones.value = "";
            }
             function f_cerrar_moAlertaDelvolver() {
                $('#miModalAlertaDevolver').modal('hide');
               
            }
            
            

        </script>

    </head>

    <body>
        <form id="formRevisar" name="formRevisar" method="post" action="">
            <input type="hidden" name="txh_verifica" id="txh_verifica" />
            <input name="txh_accion_botones" type="hidden"  />
            <%-- INICIOOOOOO  CABECERA --%>   
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="background-color:#D4FD89">
                <tr>
                    <td height="90" align="center" valign="middle" bgcolor="#B7BCBF"  background="<%= request.getContextPath()%>/imagenes/fondos/fondo_cabecera.fw.png"  >
                        <table width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr>                               
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
                                    <span class="glyphicon glyphicon-user" style="color:rgb(217, 81, 77);">&nbsp;<b><i>Usuario:</i>&nbsp;<%=objBeanU.getVUSUARIO_CARGO()%></b></span>
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
                                    <a class="navbar-brand" href="#">REVISAR DOCUMENTO </a>
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
            <table width="100%" >
                <tr>
                    <td rowspan="2" VALIGN="TOP" height="550px" style="background-color: #cdcec8" >
                        <div align="left" >
                            <table width="50%" align="left" >
                                <tr >                                             
                                    <td width="100%"  >
                                        <select name="cboDependencia" id="cboDependencia" onchange="f_listar(this.value)" class="selectpicker" data-style="btn-info"  data-live-search="true">
                                            <option value="<%=objBeanU.getCUSUARIO_COD_ORG()%>">--- Seleccione Organización---</option>
                                            <lb:TagComboUsuarioNivelInferior></lb:TagComboUsuarioNivelInferior>
                                            </select> 
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td valign="top"> <div id="listado">
                            <%
                                ArrayList listaPorRevisar = (ArrayList) objRD.ObtenerListaDocumentosXRevisar("A", objBeanU.getVUSUARIO_CODIGO(), objBeanU.getCUSUARIO_COD_ORG());
                            %>  
                            <table class="display" width="90%" border="1"  id="example">
                                <thead>
                                    <tr style="background-color:#B0B199">
                                        <th ><div align="center">AÑO</div></th>
                                        <th><div align="center">FECHA_ENVIO</div></th>
                                        <th bgcolor="#CCD272"><div align="center">CODIGO GEDAD</div></th>
                                        <th><div align="center">DEPENDENCIA</div></th>
                                        <th><div align="center">CLASE</div></th>                                       
                                        <th><div align="center">ASUNTO</div></th>
                                        <th><div align="center">DESTINO</div></th>
                                        <th><div align="center">OBSERVACIÓN</div></th>
                                        <th><div align="center">VER</div></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = 0; i < listaPorRevisar.size(); i++) {
                                            BeanRevisarDocumento objBeanD = (BeanRevisarDocumento) listaPorRevisar.get(i);
                                            if(objBeanD.getVHDOCUMENTO_OBSERVACION()==null){
                                                objBeanD.setVHDOCUMENTO_OBSERVACION("");
                                            }
                                    %>
                                    <tr>
                                        <td><%=objBeanD.getCDOCUMENTO_PERIODO()%></td>
                                        <td><%=objBeanD.getDHDOCUMENTO_FECH_ESTADO()%></td>
                                        <td bgcolor="#CCD272"><%=objBeanD.getCDOCUMENTO_COD_DOC_INT()%></td>
                                        <td><%=objBeanD.getVHDOCUMENTO_COD_USU_ENV()%></td>                                                  
                                        <td><%=objBeanD.getVCLASE_NOM_CORTO()%></td>                                     
                                        <td><%=objBeanD.getVDOCUMENTO_ASUNTO()%></td>
                                        <td><%=objBeanD.getDESTINATARIO()%></td>
                                        <td><%=objBeanD.getVHDOCUMENTO_OBSERVACION()%></td>
                                        <td><div align="center"><a href="javascript:f_visualizardoc('<%=objBeanD.getCDOCUMENTO_COD_DOC_INT()%>','<%=objBeanD.getCDOCUMENTO_CLASE()%>','<%=objBeanD.getCDOCUMENTO_PERIODO()%>','<%=objBeanD.getCHDOCUMENTO_SECUENCIA()%>','<%=objBeanD.getVHDOCUMENTO_OBSERVACION()%>');" ><img src="<%= request.getContextPath()%>/imagenes/icono/verdoc.png" height="25px" width="25px" /></a></div></td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>

            <!-- Modal (01)::Inicio Modal Revisar-->
            <div class="modal fade" id="miModalREVISAR" style="overflow-y: scroll;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body" id="regmodal">&nbsp;</div>
                    </div>
                </div>
            </div>
            <!--Fin Modal Revisar-->

            <div id="ajaxrevisar"></div>

            <!-- Modal (02)::Modal Distribucion -->                        
            <div class="modal fade" id="miModalDistribucion"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

                <div class="modal-dialog " role="document">                                 
                    <div class="modal-content">                                    
                        <div class="modal-header"  style="background-color:rgb(51, 122, 183)"> <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Distribución</b></span>  
                            <a href="javascript:f_cerrar();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>Cerrar</i></b>&nbsp;<span class="glyphicon glyphicon-remove"></span></p>  </a>                                      
                        </div>
                        <div id="modalDistribucion">&nbsp;</div>
                    </div>
                </div>
            </div>
            <!--Fin Modal Distribucion-->

            <!-- Modal (03)::Modal Envio-->                        
            <div class="modal fade" id="miModalEnvio"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">                                 
                    <div class="modal-content">                                    
                        <div class="modal-header"  style="background-color:rgb(0, 159, 246)"> <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Detalles de Envio</b></span> 
                            <a href="javascript:f_cerrar_moDetalleEnvio();">  <p style="color:rgb(240, 235, 235);" align="center"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                        </div>
                        <div>  
                            <table>
                                <tr>                                                                                        
                                    <td>
                                        <table>
                                            <tr>                                                            
                                                <td rowspan="2"> <a href="javascript:f_clasificacion();"><img src="<%=request.getContextPath()%>/imagenes/icono/prioridad.jpg" width="70px" height="60px" align="center" title="Seleccione la clasificación del documento.." /></a> </td>
                                                <td>CLASIFICACIÓN</td>
                                            </tr>
                                            <tr>
                                                <td>                                                     
                                                    <select name="cbo_Prioridad" class="form-control" id="cbo_Prioridad" >
                                                        <lb:TagListaPrioridad></lb:TagListaPrioridad>
                                                        </select>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>                                                
                                    </tr>                                              
                                    <tr>                                                                                        
                                        <td>
                                            <div id="div_cbx_firmado">&nbsp;</div>
                                        </td>                                                
                                    </tr>
                                    <tr>
                                        <td>
                                            <div id="div_observacion_enviar">
                                                <table>
                                                    <tr>
                                                        <td>                                                                   
                                                            <a href="javascript:f_clasificacion();">
                                                                <img src="<%=request.getContextPath()%>/imagenes/icono/chat.png" width="70px" height="60px" align="center" />ANOTACION PARA ENVIAR</a>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>                                                       
                                                        <div class="form-group">
                                                            <div class="col-sm-5">
                                                                <textarea class="form-control inputstl" rows="5" cols="100" id="area_obs_enviar" ></textarea>
                                                            </div>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>                              
                                        </div> 
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div id="div_accion_btn" >&nbsp;</div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!--FIN MODAL Modal Envio-->

            <!-- Modal (04)::Modal devolver-->                        
            <div class="modal fade" id="miModalDevolver"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">                                 
                    <div class="modal-content">                                    
                        <div class="modal-header" style="background-color:rgb(254, 0, 0)"> <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Devolver Documento</b></span> 
                            <a href="javascript:f_cerrar_moDevolver();">  <p style="color:rgb(240, 235, 235);" align="center"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                        </div>
                        <div  id="modalEnvio">
                            <table>
                                <tr>                                                                                        
                                    <td>
                                        <table>
                                            <tr>
                                                <td rowspan="2">
                                                    <a href="javascript:f_devolverdocumento();"><img src="<%=request.getContextPath()%>/imagenes/icono/devolver.png" width="70px" height="60px" align="center" title="Se devolvera el documento a quien lo formulo, añada observación .." /></a>                                                            
                                                </td>                                                           
                                            </tr>
                                            <tr>                                                           
                                                <td>
                                                    <div class="form-group">
                                                        <textarea class="form-control rounded-0" id="txA_Obs" rows="8" cols="35"  ></textarea>
                                                    </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!--FIN MODAL Modal devolver-->

            <!-- Modal (05)::Modal ALERTA Envio exitoso-->                        
            <div class="modal fade" id="miModalAlerta"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog " role="document">
                    <div class="modal-content">                                    
                        <div class="modal-header"  style="background-color:rgb(39, 204, 51)"> <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Envio Exitoso!!!!</b></span> 
                            <a href="javascript:f_cerrar_moAlerta();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>Cerrar  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                        </div>
                        <div>  
                            <table>
                                <tr>                                                                                        
                                    <td>                                                    
                                        El documento fue enviado al :<input name="txh_alerta_revisa" type="text"  />para la REVISIÓN correspondiente!!!
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

            <!-- Modal (06)::Modal ALERTA DEVOLVER-->                        
            <div class="modal fade" id="miModalAlertaDevolver"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog " role="document">                                 
                    <div class="modal-content">                                    
                        <div class="modal-header"  style="background-color:rgb(254, 0, 0)"> <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Envio Exitoso!!!!</b></span> 
                            <a href="javascript:f_cerrar_moAlertaDelvolver();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>Cerrar  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                        </div>
                        <div>  
                            <table>
                                <tr>                                                                                        
                                    <td>                                                    
                                        El documento fue devuelto!!!
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!--FIN MODAL Modal ALERTA DEVOLVER-->

            <!-- Modal (07)::Modal OBSERVACION-->                        
            <div class="modal fade" id="miModalObs"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog " role="document">                                 
                    <div class="modal-content">                                    
                        <div class="modal-header"  style="background-color:rgb(87, 35, 100)"> 
                            <img src="<%=request.getContextPath()%>/imagenes/icono/chat.png" width="90px" height="50px" align="left" />
                            <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Anotaciones</b></span> 
                            <a href="javascript:f_cerrar_moObs();">  <p style="color:rgb(240, 235, 235);" align="left"><b><i>Cerrar  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                        </div>
                        <div id="modalAnotacion">  
                            <table align="center">
                                <tr>                                                                                        
                                    <td>
                                        <div class="form-group">
                                            <div class="col-sm-5">
                                                <textarea class="form-control inputstl" rows="7" cols="90" id="area_obs"></textarea>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
            <!--FIN MODAL Modal OBSERVACION-->

            <%-- MODAL (08):: VISTA PREVIA --%>
            <div class="modal fade" id="miModalVP" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title" id="myModalLabel">VISTA PREVIA</h4>
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
            <!--Fin Modal VISTA PREVIA-->

        </form>

        <!-- CUADROS DE DIALOGO -->

        <!-- Modal (09)::Modal Anexo -->                        
        <div class="modal fade" id="miModalAnexo"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog " role="document">                                 
                <div class="modal-content">                                    
                    <div class="modal-header" style="background-color:rgb(91, 192, 222)"> <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Anexos</b></span> 
                        <a href="javascript:f_cerrar_moAnexos();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                    </div>
                    <div class="modal-body">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="javascript:f_listaAnexo()">Lista</a></li>
                            <li><a href="javascript:f_openAgregaAne()">Agregar</a></li>
                        </ul>
                        <span id="cuerpoAnexo">&nbsp;</span>
                    </div>
                </div>
            </div>
        </div>
        <!--FIN MODAL Modal Anexo-->

        <!-- Modal (10)::Modal Ver Anexos -->                        
        <div class="modal fade" id="miModalVerAnexos"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog " role="document">                                 
                <div class="modal-content">                                    
                    <div class="modal-header"  style="background-color:rgb(222,97,94)">  
                        <a href="javascript:f_cerrar_verAnexos();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                    </div>
                    <div id="modalMostarAnexos">&nbsp;</div>
                </div>
            </div>
        </div>
        <!--FIN MODAL Ver Anexos-->

        <!-- Modal (11)::Modal Referencia -->                        
        <div class="modal fade" id="miModalReferencia"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">                                 
                <div class="modal-content">                                    
                    <div class="modal-header" style="background-color:rgb(51, 122, 183)"> <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Referencia</b></span> 
                        <a href="javascript:f_cerrar_moReferencia();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                    </div>
                    <div class="modal-body">
                        <ul class="nav nav-tabs">
                            <li class="active"><a href="javascript:f_listaReferencia()">Lista</a></li>
                            <li><a href="javascript:f_Ref_Opcion_Busqueda()">Busqueda</a></li>
                            <li><a href="javascript:f_Ref_Opcion_Agregar()">Agregar</a></li>
                        </ul>
                        <span id="span_lista_ref_principal">&nbsp;</span>
                    </div>
                </div>
            </div>
        </div>
        <!--FIN MODAL Modal Referencia--> 

        <!-- Modal (02)::Modal Ver Referencia -->                        
        <div class="modal fade" id="miModalVerReferencia"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

            <div class="modal-dialog " role="document">                                 
                <div class="modal-content">                                    
                    <div class="modal-header"  style="background-color:rgb(222,97,94)">  
                        <a href="javascript:f_cerrar_verReferencia();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                    </div>
                    <div id="modalMostarReferencia">&nbsp;</div>
                </div>
            </div>
        </div>
        <!--FIN MODAL Ver Referencia-->

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
        <!-- COMPONENTE RENIEC PARA LA AUTENTICACION POR API -->
        <input type="hidden" id="argumentos" value="" />
        <div id="addComponent"></div>
    </body>
</html>