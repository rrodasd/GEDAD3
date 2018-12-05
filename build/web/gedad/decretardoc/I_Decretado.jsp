<%@include file="cerrarSesion.jsp" %>
<%@page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%  response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setDateHeader("Expires", 0);

    ArrayList ListarDocDecreto = null;
    if (request.getAttribute("listaDocumentoDecreto") != null) {
        ListarDocDecreto = (ArrayList) request.getAttribute("listaDocumentoDecreto");
    }

    BeanUsuarioAD objBean = (BeanUsuarioAD) session.getAttribute("usuario");

    ArrayList ListarDecreto = new ArrayList();

%>
<%@page session="true"%>
<%@taglib uri="/WEB-INF/tlds/libreria.tld" prefix="lb"%>
<%@page import="sagde.bean.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta http-equiv="x-ua-compatible" content="ie=edge" />
        <title>Documentos Recibidos</title>
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
        <style type="text/css">

            #modalDecreto {
                top:2%;
                left: 78%;
                outline: none;
                width: 20%;	
            }

            #modalElevacion {
                top:2%;
                left: 78%;
                outline: none;
                width: 20%;	
            }

            .red {
                background-color: red !important;
            }

            .orange {
                background-color: orange !important;
            }

        </style>
        <script type="text/javascript">

            $(document).ready(function () {
                $('#listaDoc').DataTable({
                    "fnRowCallback": function (row, data, dataIndex) {
                        if (data[9] === "<div align=\"center\">MUY URGENTE</div>") {
                            $(row).addClass('red');
                        }
                        if (data[9] === "<div align=\"center\">URGENTE</div>") {
                            $(row).addClass('orange');
                        }
                    }
                });
            });

            function f_ir(lugar) {
                document.frm_Manto.action = lugar;
                document.frm_Manto.submit();
            }

            var ajaxA = null;
            function funcionCallbackDocumentoVP() {
                if (ajaxA.readyState === 4 && ajaxA.status === 200) {
                    document.all.documentovp.innerHTML = ajaxA.responseText;
                }
            }

            var ajaxB = null;
            function funcionCallbackLista() {
                if (ajaxB.readyState === 4 && ajaxB.status === 200) {
                    document.all.lista.innerHTML = ajaxB.responseText;
                    $('#listaDoc').DataTable({
                        "fnRowCallback": function (row, data, dataIndex) {
                            if (data[9] === "<div align=\"center\">MUY URGENTE</div>") {
                                $(row).addClass('red');
                            }
                            if (data[9] === "<div align=\"center\">URGENTE</div>") {
                                $(row).addClass('orange');
                            }
                        }
                    });
                }
            }

            var ajaxC = null;
            function funcionCallbackDecretoBodyMod() {
                if (ajaxC.readyState === 4 && ajaxC.status === 200) {
                    document.all.decretoBodyMod.innerHTML = ajaxC.responseText;
                    $('#txtFecRpta').datepicker({
                        startDate : "0",
                        format: "dd/mm/yyyy",
                        maxViewMode: 2,
                        todayBtn: "linked",
                        language: "es",
                        daysOfWeekHighlighted: "0,6",
                        calendarWeeks: true,
                        autoclose: true,
                        todayHighlight: true
                    });
                    $('#cboAccion').selectpicker();
                    $('#cboEncargaturaInterna').selectpicker();

                }
            }

            var ajaxCA = null;
            function funcionCallbackCA() {
                if (ajaxCA.readyState === 4 && ajaxCA.status === 200) {
                    document.all.cuerpoAnexo.innerHTML = ajaxCA.responseText;
                    $('#dt_aneDecr').DataTable({
                        "scrollCollapse": true,
                        "paging": false
                    });
                }
            }

            var ajaxDAVP = null;
            function funcionCallbackDAVP() {
                if (ajaxDAVP.readyState === 4 && ajaxDAVP.status === 200) {
                    document.all.docanevp.innerHTML = ajaxDAVP.responseText;
                }
            }

            function f_ver(periodo, documento, interna, token, tipodecreto, prioridad, internaencargada, observacion, fecharpta, tipoorigen, internaorigen,archivo) {
                if (token === "null") {
                    alert("Documento sin Token, imposible de recuperar");
                } else {
                    //internaencargada = btoa(internaencargada);
                    $('#modalDocumento').modal({backdrop: 'static', keyboard: false});
                    var reporte = "01";
                    if (window.XMLHttpRequest) {
                        ajaxA = new XMLHttpRequest();
                    } else {
                        ajaxA = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    ajaxA.onreadystatechange = funcionCallbackDocumentoVP;
                    observacion = btoa(observacion);
                    var ruta = "<%= request.getContextPath()%>/gedad/decretardoc/I_Decretado_ajax.jsp?pasacache=" + new Date().getTime() +
                            "&reporte=" + reporte +
                            "&periodo=" + periodo +
                            "&documento=" + documento +
                            "&interna=" + interna +
                            "&internaencargada=" + internaencargada +
                            "&observacion=" + observacion +
                            "&token=" + token +
                            "&tipodecreto=" + tipodecreto +
                            "&prioridad=" + prioridad +
                            "&fecharpta=" + fecharpta +
                            "&internaorigen=" + internaorigen +
                            "&archivo=" + archivo +
                            "&tipoorigen=" + tipoorigen;
                    ajaxA.open("GET", ruta, true);
                    ajaxA.send("");
                    f_buttonDisable(false, tipodecreto);
                }
            }

            function f_buttonDisable(state, tipodecreto) {
                document.getElementById("btnResponder").disabled = state;
                document.getElementById("btnDecretar").disabled = state;
                document.getElementById("btnElevar").disabled = state;
                if (tipodecreto == "E") {
                    document.getElementById("btnElevar").disabled = state;
                } else {
                    document.getElementById("btnElevar").disabled = true;
                }
            }

            function f_IniDecreto() {
                var periodo = document.frm_Manto.txh_periodo.value;
                var documento = document.frm_Manto.txh_documento.value;
                var tipodecreto = document.frm_Manto.txh_tipodecreto.value;
                $('#modalDecreto').modal({backdrop: 'static', keyboard: false});
                f_buttonDisable(true, tipodecreto);
                var reporte = "04";
                if (window.XMLHttpRequest) {
                    ajaxC = new XMLHttpRequest();
                } else {
                    ajaxC = new ActiveXObject("Microsoft.XMLHTTP");
                }
                ajaxC.onreadystatechange = funcionCallbackDecretoBodyMod;
                var ruta = "<%= request.getContextPath()%>/gedad/decretardoc/I_Decretado_ajax.jsp?pasacache=" + new Date().getTime() +
                        "&reporte=" + reporte +
                        "&periodo=" + periodo +
                        "&documento=" + documento;
                ajaxC.open("GET", ruta, true);
                ajaxC.send("");
            }

            function f_cerrar_modDec() {
                $('#modalDecreto').modal('hide');
                var tipodecreto = document.frm_Manto.txh_tipodecreto.value;
                f_buttonDisable(false, tipodecreto);
            }

            function f_cerrar_modEle() {
                $('#modalElevacion').modal('hide');
                var tipodecreto = document.frm_Manto.txh_tipodecreto.value;
                f_buttonDisable(false, tipodecreto);
            }

            function f_cerrar_ModDoc() {
                document.all.documentovp.innerHTML = "&nbsp;";
                $('#modalDocumento').modal('hide');
                document.all.decretoBodyMod.innerHTML = "&nbsp;";
                $('#modalDecreto').modal('hide');
                $('#modalElevacion').modal('hide');
            }

            function f_listar(internaFiltro) {
                if (internaFiltro === "SIN_FILTRO") {
                    var reporte = "02";
                    if (window.XMLHttpRequest) {
                        ajaxB = new XMLHttpRequest();
                    } else {
                        ajaxB = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    ajaxB.onreadystatechange = funcionCallbackLista;
                    var ruta = "<%= request.getContextPath()%>/gedad/decretardoc/I_Decretado_ajax.jsp?pasacache=" + new Date().getTime() +
                            "&reporte=" + reporte;
                    ajaxB.open("GET", ruta, true);
                    ajaxB.send("");
                } else {
                    var reporte = "03";
                    if (window.XMLHttpRequest) {
                        ajaxB = new XMLHttpRequest();
                    } else {
                        ajaxB = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    ajaxB.onreadystatechange = funcionCallbackLista;
                    var ruta = "<%= request.getContextPath()%>/gedad/decretardoc/I_Decretado_ajax.jsp?pasacache=" + new Date().getTime() +
                            "&reporte=" + reporte +
                            "&internaFiltro=" + internaFiltro;
                    ajaxB.open("GET", ruta, true);
                    ajaxB.send("");
                }
            }

            function f_FinDecreto() {
                var internaFiltro = document.frm_Manto.cboDependencia.value;
                var interna = document.frm_Manto.txh_interna.value;
                var internaencargada = document.frm_Manto.txh_internaencargada.value;
                var periodo = document.frm_Manto.txh_periodo.value;
                var documento = document.frm_Manto.txh_documento.value;
                var nrodecreto = document.frm_Manto.txh_nrodecreto.value;
                var accion = [], internasubordinada = [], opt;
                for (var i = 0, len = document.frm_Manto.cboEncargaturaInterna.options.length; i < len; i++) {
                    opt = document.frm_Manto.cboEncargaturaInterna.options[i];
                    if (opt.selected) {
                        internasubordinada.push(opt.value);
                    }
                }
                for (var i = 0, len = document.frm_Manto.cboAccion.options.length; i < len; i++) {
                    opt = document.frm_Manto.cboAccion.options[i];
                    if (opt.selected) {
                        accion.push(opt.value);
                    }
                }
                var prioridad = document.frm_Manto.cboPrioridad.value;
                var observacion = document.frm_Manto.txtObservacion.value;
                var fecharpta = document.frm_Manto.txtFecRpta.value;

                if (internasubordinada == "") {
                    alert("Debe seleccionar al menos un elemento de su organizacion a quien decretar");
                } else if (accion == "") {
                    alert("Debe seleccionar al menos una accion");
                } else {
                    var reporte = "05";
                    if (window.XMLHttpRequest) {
                        ajaxB = new XMLHttpRequest();
                    } else {
                        ajaxB = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    ajaxB.onreadystatechange = funcionCallbackLista;
                    var ruta = "<%= request.getContextPath()%>/gedad/decretardoc/I_Decretado_ajax.jsp?pasacache=" + new Date().getTime() +
                            "&reporte=" + reporte +
                            "&interna=" + interna +
                            "&internaFiltro=" + internaFiltro +
                            "&periodo=" + periodo +
                            "&documento=" + documento +
                            "&nrodecreto=" + nrodecreto +
                            "&accion=" + accion +
                            "&internasubordinada=" + internasubordinada +
                            "&internaencargada=" + internaencargada +
                            "&observacion=" + observacion +
                            "&prioridad=" + prioridad +
                            "&fecharpta=" + fecharpta;
                    ajaxB.open("GET", ruta, true);
                    ajaxB.send("");
                    f_cerrar_ModDoc();
                }
            }

            function f_Formular() {
                var periodo = document.frm_Manto.txh_periodo.value;
                var documento = document.frm_Manto.txh_documento.value;
                var token = document.frm_Manto.txh_token.value;
                var tipoorigen = document.frm_Manto.txh_tipoorigen.value;
                var internaorigen = document.frm_Manto.txh_internaorigen.value;
                var reporte = "10";
                if (window.XMLHttpRequest) {
                    ajaxB = new XMLHttpRequest();
                } else {
                    ajaxB = new ActiveXObject("Microsoft.XMLHTTP");
                }
                ajaxB.onreadystatechange;
                var ruta = "<%= request.getContextPath()%>/gedad/decretardoc/I_Decretado_ajax.jsp?pasacache=" + new Date().getTime() +
                        "&reporte=" + reporte +
                        "&periodo=" + periodo +
                        "&token=" + token +
                        "&tipoorigen=" + tipoorigen +
                        "&internaorigen=" + internaorigen +
                        "&documento=" + documento;
                ajaxB.open("GET", ruta, true);
                ajaxB.send("");
                document.forms[0].action = '<%=request.getContextPath()%>/formular';
                document.forms[0].submit();
            }

            function f_Elevar() {
                var tipodecreto = document.frm_Manto.txh_tipodecreto.value;
                f_buttonDisable(true, tipodecreto);
                $('#modalElevacion').modal({backdrop: 'static', keyboard: false});
                document.frm_Manto.txtObsElevacion.value = "";
            }

            function f_FinElevacion() {
                var internaFiltro = document.frm_Manto.cboDependencia.value;
                var periodo = document.frm_Manto.txh_periodo.value;
                var documento = document.frm_Manto.txh_documento.value;
                var interna = document.frm_Manto.txh_interna.value;
                var internaencargada = document.frm_Manto.txh_internaencargada.value;
                var nrodecreto = document.frm_Manto.txh_nrodecreto.value;
                var prioridad = document.frm_Manto.txh_prioridad.value;
                var observacion = document.frm_Manto.txtObsElevacion.value;
                var reporte = "06";
                if (window.XMLHttpRequest) {
                    ajaxB = new XMLHttpRequest();
                } else {
                    ajaxB = new ActiveXObject("Microsoft.XMLHTTP");
                }
                ajaxB.onreadystatechange = funcionCallbackLista;
                var ruta = "<%= request.getContextPath()%>/gedad/decretardoc/I_Decretado_ajax.jsp?pasacache=" + new Date().getTime() +
                        "&reporte=" + reporte +
                        "&interna=" + interna +
                        "&internaencargada=" + internaencargada +
                        "&internaFiltro=" + internaFiltro +
                        "&periodo=" + periodo +
                        "&documento=" + documento +
                        "&nrodecreto=" + nrodecreto +
                        "&observacion=" + observacion +
                        "&prioridad=" + prioridad;
                ajaxB.open("GET", ruta, true);
                ajaxB.send("");
                f_cerrar_ModDoc();
            }

            function f_Archivar() {
                var internaFiltro = document.frm_Manto.cboDependencia.value;
                var periodo = document.frm_Manto.txh_periodo.value;
                var documento = document.frm_Manto.txh_documento.value;
                var interna = document.frm_Manto.txh_interna.value;
                var internaencargada = document.frm_Manto.txh_internaencargada.value;
                var reporte = "07";
                if (window.XMLHttpRequest) {
                    ajaxB = new XMLHttpRequest();
                } else {
                    ajaxB = new ActiveXObject("Microsoft.XMLHTTP");
                }
                ajaxB.onreadystatechange = funcionCallbackLista;
                var ruta = "<%= request.getContextPath()%>/gedad/decretardoc/I_Decretado_ajax.jsp?pasacache=" + new Date().getTime() +
                        "&reporte=" + reporte +
                        "&interna=" + interna +
                        "&internaencargada=" + internaencargada +
                        "&internaFiltro=" + internaFiltro +
                        "&periodo=" + periodo +
                        "&documento=" + documento;
                ajaxB.open("GET", ruta, true);
                ajaxB.send("");
                f_cerrar_ModDoc();
            }

            function f_verAnexos(periodo, interna) {
                $('#miModalAnexos').modal({backdrop: 'static', keyboard: false});
                var reporte = "08";
                if (window.XMLHttpRequest) {
                    ajaxCA = new XMLHttpRequest();
                } else {
                    ajaxCA = new ActiveXObject("Microsoft.XMLHTTP");
                }
                ajaxCA.onreadystatechange = funcionCallbackCA;
                var ruta = "<%= request.getContextPath()%>/gedad/decretardoc/I_Decretado_ajax.jsp?pasacache=" + new Date().getTime() +
                        "&reporte=" + reporte +
                        "&periodo=" + periodo +
                        "&interna=" + interna;
                ajaxCA.open("GET", ruta, true);
                ajaxCA.send("");
            }

            function f_cerrar_moAnexos() {
                $('#miModalAnexos').modal('hide');
            }

            function f_cerrar_ModDocAne() {
                $('#modalDocAnexo').modal('hide');
            }

            function f_verAnexo(token, archivo) {
                if (token === "null") {
                    alert("Documento sin Token, imposible de recuperar");
                } else {
                    var reporte = "09";
                    var extension = archivo.split(".")[1];
                    if (extension === "pdf" || extension === "PDF" || extension === "txt" || extension === "TXT") {
                        $('#modalDocAnexo').modal({backdrop: 'static', keyboard: false});
                    }
                    if (window.XMLHttpRequest) {
                        ajaxDAVP = new XMLHttpRequest();
                    } else {
                        ajaxDAVP = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    ajaxDAVP.onreadystatechange = funcionCallbackDAVP;
                    var ruta = "<%= request.getContextPath()%>/gedad/decretardoc/I_Decretado_ajax.jsp?pasacache=" + new Date().getTime() +
                            "&reporte=" + reporte +
                            "&token=" + token +
                            "&archivo=" + archivo;
                    ajaxDAVP.open("GET", ruta, true);
                    ajaxDAVP.send("");
                }
            }

        </script>
    </head>	
    <body>
        <form name="frm_Manto" method="post" action="">
            <input type="hidden" name="txh_Accion" />

            <%-- INICIOOOOOO  CABECERA --%>   
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
                                    <a class="navbar-brand" href="#">DOCUMENTOS RECIBIDOS</a>
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
                    <td valign="top" style="background-color: #cdcec8" >
                        <div align="left" >
                            <table width="50%" align="left" >
                                <tr>                                             
                                    <td width="100%"  >
                                        <select name="cboDependencia" id="cboDependencia" onchange="f_listar(this.value)" class="selectpicker" data-style="btn-info"  data-live-search="true">
                                            <option value="SIN_FILTRO">--- Seleccione Organización---</option>
                                            <lb:ComboEncargaturaDecreto></lb:ComboEncargaturaDecreto>
                                            </select> 
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    
                        <td valign="top">
                            <div align="center" id="lista">
                                <table class="display" border="1" id="listaDoc">
                                    <thead>
                                        <tr bgcolor="#B0B199">
                                            <th><div align="center">AÑO</div></th>
                                            <th><div align="center">FECHA_REG</div></th>
                                            <th><div align="center">CODIGO GEDAD</div></th> 
                                            <th><div align="center">REMITENTE</div></th>
                                            <th><div align="center">CLASE</div></th>
                                            <th><div align="center">NRO. DOC</div></th>
                                            <th><div align="center">FECHA DOC</div></th>
                                            <th><div align="center">ASUNTO_DEL_DOCUMENTO</div></th>                                            
                                            <th><div align="center">TIP DIST.</div></th>
                                            <th><div align="center">PRIORIDAD</div></th>
                                            <th><div align="center">VER DOC</div></th>
                                            <th><div align="center">VER ANEXOS</div></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    <%
                                        for (int i = 0; i < ListarDocDecreto.size(); i++) {
                                            BeanDecreto objBeanD = (BeanDecreto) ListarDocDecreto.get(i);
                                    %>
                                    <tr>
                                        <td><div align="center"><%=objBeanD.getCDOCUMENTO_PERIODO()%></div></td>
                                        <td><div align="center"><%=objBeanD.getDDECRETO_FECH_DEC()%></div></td>
                                        <td bgcolor="#CCD272" ><div align="center"><%=objBeanD.getCDOCUMENTO_COD_DOC_INT()%></div></td>
                                        <td><div align="center"><%=objBeanD.getVOINTERNA_NOM_CORTO()%></div></td>
                                        <td><div align="center"><%=objBeanD.getVCLASE_NOM_CORTO()%></div></td>
                                        <td><div align="center"><%=objBeanD.getCDOCUMENTO_NRO_ORDEN()%></div></td>
                                        <td><div align="center"><%=objBeanD.getDDOCUMENTO_FECHA()%></div></td>
                                        <td><%=objBeanD.getVDOCUMENTO_ASUNTO()%></td>                                        
                                        <td><div align="center"><%=objBeanD.getCDISTRIBUCION_TIPO_DISTRIB()%></div></td>
                                        <td><div align="center"><%=objBeanD.getVPRIORIDAD_NOMBRE()%></div></td>
                                        <td><div align="center"><a href="javascript:f_ver('<%=objBeanD.getCDOCUMENTO_PERIODO()%>','<%=objBeanD.getCDOCUMENTO_COD_DOC_INT()%>','<%=objBeanD.getCDECRETO_COD_ORG()%>','<%=objBeanD.getVDISTRIBUCION_TOKEN()%>','<%=objBeanD.getTIPO_DECRETO()%>','<%=objBeanD.getCDECRETO_PRIORIDAD()%>','<%=objBeanD.getCDECRETO_COD_ORG_ENC()%>','<%=objBeanD.getVDECRETO_OBSERVACION()%>','<%=objBeanD.getDDECRETO_FECH_EJEC()%>','<%=objBeanD.getCDOCUMENTO_TIPO_ORG_ORIG()%>','<%=objBeanD.getCDOCUMENTO_COD_ORG_DEP()%>','<%=objBeanD.getVDISTRIBUCION_NOM_FILE()%>');"><img src="<%= request.getContextPath()%>/imagenes/icono/pdf.png" height="25px" width="25px" alt="Editar" /></a></div></td>
                                        <td><div align="center"><a href="javascript:f_verAnexos('<%=objBeanD.getCDOCUMENTO_PERIODO()%>','<%=objBeanD.getCDOCUMENTO_COD_DOC_INT()%>');"><img src="<%= request.getContextPath()%>/imagenes/icono/anexos.fw.png" height="25px" width="25px" alt="VerAnexos" /></a></div></td>                                        
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
                        </div>
                    </td>
                </tr>
                
            </table>
            <!--Fin Tabla Bandeja-->

            <!--Inicio Modal Documento-->
            <div class="modal fade" id="modalDocumento" role="dialog">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color:rgb(76, 175, 80)">
                            <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Documento Recibido</b></span>
                            <a href="javascript:f_cerrar_ModDoc();"><p style="color:rgb(240, 235, 235);" align="right"><b><i>Cerrar</i></b>&nbsp;<span class="glyphicon glyphicon-remove"></span></p></a>
                        </div>
                        <div class="modal-body">
                            <span id="documentovp">&nbsp;</span>
                        </div>
                        <div class="modal-footer">
                            <button id="btnElevar" type="button" class="btn btn-warning btn-lg" onclick="javascript:f_Elevar();">Elevar</button>
                            <button id="btnDecretar" type="button" class="btn btn-primary btn-lg" onclick="javascript:f_IniDecreto();">Decretar</button>
                            <button id="btnResponder" type="button" class="btn btn-success btn-lg" onclick="javascript:f_Formular();">Responder</button>
                            <button id="btnArchivar" type="button" class="btn btn-default btn-lg" onclick="javascript:f_Archivar();">Archivar</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Fin Modal Documento-->

            <!--Inicio Modal Decreto-->
            <div class="modal fade" id="modalDecreto" role="dialog">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color:rgb(51, 122, 183)">
                            <img src="<%=request.getContextPath()%>/imagenes/icono/decreto.png" width="90px" height="50px" align="left" />
                            &nbsp;<span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Decreto</b></span>
                            <a href="javascript:f_cerrar_modDec();"><p style="color:rgb(240, 235, 235);" align="right"><b><i>Cerrar</i></b>&nbsp;<span class="glyphicon glyphicon-remove"></span></p></a>
                        </div>
                        <div class="modal-body">
                            <div id="decretoBodyMod">&nbsp;</div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-success" onclick="javascript:f_FinDecreto();">Enviar</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Fin Modal Decreto-->

            <!--Inicio Modal Elevar-->
            <div class="modal fade" id="modalElevacion" role="dialog">
                <div class="modal-dialog modal-sm">
                    <div class="modal-content">
                        <div class="modal-header" style="background-color:rgb(240, 173, 78)">
                            <img src="<%=request.getContextPath()%>/imagenes/icono/decreto.png" width="90px" height="50px" align="left" />
                            &nbsp;<span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Elevacion</b></span>
                            <a href="javascript:f_cerrar_modEle();"><p style="color:rgb(240, 235, 235);" align="right"><b><i>Cerrar</i></b>&nbsp;<span class="glyphicon glyphicon-remove"></span></p></a>
                        </div>
                        <div class="modal-body">
                            <div>Observaciones:</div>
                            <div><textarea class="form-control inputstl" rows="7" name="txtObsElevacion" id="txtObsElevacion"></textarea></div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-warning" onclick="javascript:f_FinElevacion();">Elevar</button>
                        </div>
                    </div>
                </div>
            </div>
            <!-- Fin Modal Decreto-->
        </form>
        <%-- VENTANA DE ANEXOS --%>
        <div class="modal fade" id="miModalAnexos" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="background-color:rgb(91, 192, 222)">
                        <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Anexos</b></span>
                        <a href="javascript:f_cerrar_moAnexos();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>Cerrar</i></b>&nbsp;<span class="glyphicon glyphicon-remove"></span></p></a>
                    </div>
                    <div class="modal-body">
                        <span id="cuerpoAnexo">&nbsp;</span>
                    </div>
                    <!--FIN -->                                                                     
                </div>
            </div>                        
        </div>
        <!--Inicio Modal VP Anexos-->
        <div class="modal fade" id="modalDocAnexo" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header" style="background-color:rgb(76, 175, 80)">
                        <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Vista de Anexos</b></span>
                        <a href="javascript:f_cerrar_ModDocAne();"><p style="color:rgb(240, 235, 235);" align="right"><b><i>Cerrar</i></b>&nbsp;<span class="glyphicon glyphicon-remove"></span></p></a>
                    </div>
                    <div class="modal-body">
                        <span id="docanevp">&nbsp;</span>
                    </div>
                </div>
            </div>
        </div>
        <!-- Fin Modal VP Referencia-->
        <!--Pie-->
        <div id="pie">
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
                <tr>
                    <td align="center" valign="middle" bgcolor="#9A9FA3" height="7"></td>
                </tr>
                <tr>
                    <td height="66" align="center" valign="middle" bgcolor="#B7BCBF">
                        <div>DEPARTAMENTO DE SISTEMAS - DESI</div>
                        <div>® 2018</div>
                        <div>Todos los Derechos Reservados</div>
                    </td>
                </tr>
            </table>
        </div>
        <!--Pie-->
    </body>
</html>