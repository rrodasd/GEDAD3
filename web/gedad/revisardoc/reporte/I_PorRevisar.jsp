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
        
        
         <%
            BeanUsuarioAD objBeanU = (BeanUsuarioAD) session.getAttribute("usuario");
            String msg_oficio = request.getParameter("msg");
            session.setAttribute("anexos", null);
            String guarn = (String) session.getAttribute("ses_guarnicion");
            String alafirma = (String) session.getAttribute("alafirma");
            //String codusu = (String) session.getAttribute("admusuario");
            DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
            ComboboxDAO objCombobox = objDAOFactory.getComboboxDAO(); 
            
            RevisaDocumentoDAO objRD = objDAOFactory.getRevisaDocumentoDAO();
            //System.out.println("Sesion Grado: "+session.getAttribute("grado"));
        %>
      
        
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
            
            $(document).ready(function() {       
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
            
              
            } );  

         
            var ctx_path = "<%= request.getContextPath()%>";
            
            // Mostrar y Ocultar Capas
            function mostrar(nombreCapa) {
                document.getElementById(nombreCapa).style.visibility = "visible";
            }

            function ocultar(nombreCapa) {
                document.getElementById(nombreCapa).style.visibility = "hidden";
            }
            
            /*
            $('.modal.draggable>.modal-dialog').draggable({
                cursor: 'move',
                handle: '.modal-header'
            });
            $('.modal.draggable>.modal-dialog>.modal-content>.modal-header').css('cursor', 'move');
            
             $("#miModalObs").draggable({ handle: ".modal-header" });
             */   
                

/*
 * 
 * ------------------------------------------------------------------01 REVISAR DOCUEMNTO --------------------------------------------------------------------
 */  
            /**
             * Retorna el listado de los documentos por Revisar
             * @param {type} dependencia
             * @returns {undefined}
             */
            function f_listar(dependencia) {
               
             var reporte = "REV_01";     
      
                if( isEq(dependencia, SEL_DEPENDENCIA_VACIO) ){
                    $("#listado").html("");
                     alert("vacio");
                    return; 
                }
               
                 
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=", 
                                            new Date().getTime(), 
                                            "&reporte=",reporte,
                                            "&dependencia=", 
                                            dependencia 
                                            );
                
                $("#listado").load(ruta, function(){
                    $('#example').DataTable();
                });
            }
            
            /*
             * 
             * @param {type} codint
             * @param {type} clase
             * @param {type} periodo
             * @param {type} secuencia
             * @param {type} r_observa
             * @returns {undefined}
             */
           
            function f_visualizardoc(codint,clase,periodo,secuencia,r_observa) {
                
                            
               document.all.area_obs.value=r_observa;
               
                $('#miModalObs').modal('show');
            
                //ABRE MODAL DE REVISAR    
                $('#miModalREVISAR').modal({backdrop: 'static', keyboard: false});
                
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=", 
                                            new Date().getTime(), 
                                            "&codint=", 
                                            codint, 
                                            "&clase=", 
                                            clase, 
                                            "&periodo=", 
                                            periodo, 
                                            "&secuencia=", 
                                            secuencia, 
                                            "&reporte=", 
                                            OPC_MUESTRA_OFICIO);
                
                $("#regmodal").load(ruta, function(){
                    CKEDITOR.replace('cuerpo');
                });
                
                  
            }


  /* 
             * Funcion(1). Funcion Devolver Documento
             */

            function f_Abredevolver() { 
                $('#miModalObs').modal('hide');      
                $('#miModalDevolver').modal({backdrop: 'static', keyboard: false});
                $('#miModalEnvio').modal('hide');
            }


            var ajaxEnviaRevisar = null;
                            function funcionCallbackEnviaRevisar() {
                               if (ajaxEnviaRevisar.readyState === 4 && ajaxEnviaRevisar.status === 200) {
                                   document.all.ajaxrevisar.innerHTML = ajaxEnviaRevisar.responseText;                     
                               }
                             }

            function f_tranferencia(accion){
          
             var cboDependencia  = document.all.cboDependencia.value;
             var cbo_OrgDependencia  = document.all.cbo_OrgDependencia.value;
             var txt_Clave  = document.all.txt_Clave.value;
             var cboArchivoIndicativo  = document.all.cboArchivoIndicativo.value;
             var txt_Asunto  = btoa(document.all.txt_Asunto.value);
             //var cuerpo  = document.all.cuerpo.value;
             var cuerpo = btoa(btoa(CKEDITOR.instances.cuerpo.getData())); 
             var cbo_Prioridad  = document.all.cbo_Prioridad.value;
             var cbo_revisadoPor  = document.all.cbo_revisadoPor.value;
             var cbo_firmadoPor  = document.all.cbo_firmadoPor.value;
             var txA_Obs_Enviar  = btoa(document.all.area_obs_enviar.value) ;
                       
                if ((cbo_revisadoPor == "000")||(cbo_firmadoPor == "000")){
                    alert("Eliga Quien firmara");

                }else {                         
                          var accion_enviar=accion; 
                          var reporte = "REV_03";         
                           if (window.XMLHttpRequest) {
                               ajaxEnviaRevisar = new XMLHttpRequest();
                           } else {
                               ajaxEnviaRevisar = new ActiveXObject("Microsoft.XMLHTTP");
                           }
                           ajaxEnviaRevisar.onreadystatechange = funcionCallbackEnviaRevisar;
                           var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=" + new Date().getTime() +"&reporte=" + reporte+
                                   "&cbo_OrgDependencia=" + cbo_OrgDependencia+
                                   "&txt_Clave=" + txt_Clave+
                                   "&cboArchivoIndicativo=" + cboArchivoIndicativo+
                                   "&txt_Asunto=" + txt_Asunto+
                                   "&txt_cuerpo=" + cuerpo+
                                   "&cbo_Prioridad=" + cbo_Prioridad+
                                   "&cbo_revisadoPor=" + cbo_revisadoPor+
                                   "&cbo_firmadoPor=" + cbo_firmadoPor+
                                   "&txA_Obs_Enviar=" + txA_Obs_Enviar+
                                   "&accion_enviar=" + accion_enviar;
                           ajaxEnviaRevisar.open("GET", ruta, true);
                           ajaxEnviaRevisar.send(""); 

                              $('#miModalEnvio').modal('hide');
                              $('#miModalREVISAR').modal('hide');
                            

                             var posTO = document.all.cbo_revisadoPor.options.selectedIndex;                
                             var des_to = document.all.cbo_revisadoPor.options[posTO].text; 
                             document.all.txh_alerta_revisa.value=des_to;
                             $('#miModalAlerta').modal({backdrop: 'static', keyboard: false}); 
                             
                            //setTimeout(f_listar(cboDependencia),2000);
                         
                              var reporte = "REV_01";     

                               var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=", 
                                                            new Date().getTime(), 
                                                            "&reporte=",reporte,
                                                            "&dependencia=", 
                                                            cboDependencia 
                                                            );

                                $("#listado").load(ruta, function(){
                                    $('#example').DataTable();
                                });
                            
                             
                            
                 }        
              
          }
             
     var ajaxSalida = null;
            function funcionCallbackSalida() {
                if (ajaxSalida.readyState === 4 && ajaxSalida.status === 200) {
                    document.all.salida.innerHTML = ajaxSalida.responseText;
                }
            }
     function f_vistaprevia1() {
         
              
    if (document.all.cbo_firmadoPor.value !== "000") {
                    if (document.all.cbo_revisadoPor.value !== "000") {
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
                        if (window.XMLHttpRequest) {
                            ajaxSalida = new XMLHttpRequest();
                        } else {
                            ajaxSalida = new ActiveXObject("Microsoft.XMLHTTP");
                        }
                        ajaxSalida.onreadystatechange = funcionCallbackSalida;
                        var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=" + new Date().getTime() + "&orgint_origen=" + orgint_origen + "&nombreanio=" + nombreanio + "&guarnicion=" + guarnicion + "&fecha=" + fecha + "&orgint_redacta=" + orgint_redacta + "&archivo=" + archivo + "&grado_distribucion=" + grado_distribucion + "&cargo_distribucion=" + cargo_distribucion + "&asunto=" + asunto + "&cuerpo=" + cuerpo + "&cargo_firmante=" + cargo_firmante + "&reporte=" + reporte;
                        ajaxSalida.open("GET", ruta, true);
                        ajaxSalida.send("");
                    } else {
                        alert("Falta Seleccionar Combo Revisar Por");
                    }
                } else {
                    alert("Falta Seleccionar Combo A la firma");
                }
            }


      function f_devolverdocumento(){
          
             var cboDependencia  = document.all.txh_cog_org.value;          
             var cbo_OrgDependencia  = document.all.cbo_OrgDependencia.value;
             var txt_Clave  = document.all.txt_Clave.value;
             var cboArchivoIndicativo  = document.all.cboArchivoIndicativo.value;
             var txt_Asunto  = btoa(document.all.txt_Asunto.value);
             //var cuerpo  = document.all.cuerpo.value;
             var cuerpo = btoa(btoa(CKEDITOR.instances.cuerpo.getData())); 
             var cbo_Prioridad  = document.all.cbo_Prioridad.value;            
             var txA_Obs_Enviar  = btoa(document.all.txA_Obs.value) ;
                       
              
                        
                         var accion_enviar="DEVOLVER";
                     

                           var reporte = "REV_04";         
                           if (window.XMLHttpRequest) {
                               ajaxEnviaRevisar = new XMLHttpRequest();
                           } else {
                               ajaxEnviaRevisar = new ActiveXObject("Microsoft.XMLHTTP");
                           }
                           ajaxEnviaRevisar.onreadystatechange = funcionCallbackEnviaRevisar;
                           var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=" + new Date().getTime() +"&reporte=" + reporte+
                                   "&cbo_OrgDependencia=" + cbo_OrgDependencia+
                                   "&txt_Clave=" + txt_Clave+
                                   "&cboArchivoIndicativo=" + cboArchivoIndicativo+
                                   "&txt_Asunto=" + txt_Asunto+
                                   "&txt_cuerpo=" + cuerpo+
                                   "&cbo_Prioridad=" + cbo_Prioridad+                                  
                                   "&txA_Obs_Enviar=" + txA_Obs_Enviar+
                                   "&accion_enviar=" + accion_enviar;
                           ajaxEnviaRevisar.open("GET", ruta, true);
                           ajaxEnviaRevisar.send(""); 

                              $('#miModalEnvio').modal('hide');
                              $('#miModalREVISAR').modal('hide');
                              $('#miModalDevolver').modal('hide');
                            
                             $('#miModalAlertaDevolver').modal({backdrop: 'static', keyboard: false}); 
                               
                           setTimeout(f_listar(cboDependencia),2000);
                              
                        
              
          }
                     
            
          




/*
 * 
 * ------------------------------------------------------------------02 DISTRIBUCION --------------------------------------------------------------------
 */           
              /**
             * Funcion(03). RETORNA EL COMBO
             
             */

            var ajaxDO = null;
            function funcionCallbackDO() {
                if (ajaxDO.readyState === 4 && ajaxDO.status === 200) {
                    document.all.dis_org.innerHTML = ajaxDO.responseText;                    
                    $('.selectpicker').selectpicker({style: 'btn-info',size: 10 });
                }
            }

            function f_DIS(tipo) {
                
                var reporte = "DIST_05";
                var interna = document.all.cbo_OrgDependencia.value;
                
                if (window.XMLHttpRequest) {
                    ajaxDO = new XMLHttpRequest();
                } else {
                    ajaxDO = new ActiveXObject("Microsoft.XMLHTTP");
                }
                ajaxDO.onreadystatechange = funcionCallbackDO;
                var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_Distribucion_ajax.jsp?pasacache=" + new Date().getTime() + "&reporte=" + reporte + "&interna=" + interna + "&tipo=" + tipo;
                ajaxDO.open("GET", ruta, true);
                ajaxDO.send("");
            }



            /**
             * Funcion(03).  VIENE DEL AJAX I_PorRevisar.ajax reporte:02 - Abre el modal de Distribucion
             * @param {type} cod_org_cab
             * @param {type} periodo
             * @param {type} cod_interno
             * @returns {undefined}
             */
            
            function f_openDistribucion(cod_org_cab, periodo, cod_interno) {
                $('#miModalObs').modal('hide');               
                var verifica=document.formRevisar.txh_verifica.value; 
               
                $('#miModalDistribucion').modal({backdrop: 'static', keyboard: false});

                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Distribucion_ajax.jsp?pasacache=" , 
                                        new Date().getTime(),
                                        "&cod_org_cab=", 
                                        cod_org_cab.trim(), 
                                        "&periodo=", 
                                        periodo, 
                                        "&cod_interno=", 
                                        cod_interno,
                                         "&verifica=", 
                                        verifica,
                                        "&reporte=", 
                                        OPC_MUESTRA_DISTRIBUCION)
                                  
                $("#modalDistribucion").load(ruta, function(){
                     $('#distri').DataTable(                            
                        );
                
                 //Retorna  Bootstrap y le da formato requerido a la Combo en Linea, solo con 10 linea visibles   
                     $('.selectpicker').selectpicker({style: 'btn-info',size: 10 });
                     //,multiple data-max-options:'1' ,data-live-search:'true'
                });
                
                 //IMPORTANTE::::Solo le cambia el valor a la caja de texto verifica apara que no deje cerrar el modal distribucion si antes no hizo cheked
                    document.formRevisar.txh_verifica.value="NO"  

            }


            
            /**
             * Funcion(04). Añadira Lista de Destinatario sne el Modal DISTRIBUCION
             * @param {type} valor
             * @returns {undefined}
             */
            
            
/*
            function f_AgregarDestinatarios(valor) {

                //Variable que s envi al AJAX para agregar a los destinatario     
            var v_tipo_organizacion = document.formRevisar.tipoOrg.value;
            var v_destinatario = document.formRevisar.org.value;
                               
            var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=",
                                            new Date().getTime(),
                                            "&v_tipo_organizacion=",
                                            v_tipo_organizacion,
                                            "&v_destinatario=",
                                            v_destinatario,
                                            "&reporte=", 
                                            OPC_AGREGAR_DESTINATARIO)
                                            
                  $("#modalDestinatario").load(ruta, function(){
                     $('#distri').DataTable(
                                {
                                    "scrollY": "200px",
                                    "scrollCollapse": true,
                                    "paging": false
                                }
                        );
                
                
                
                });
                
                
            }

          */
         
          function f_Agregar(){ 
           alert("Elige el Tipo de Organización");
          }
          
         
         
           function f_AgregarDestinatarios(){  
              // alert("agregara una nueva DISTRIBUCIÓN!...");
            
                //Variable que s envi al AJAX para agregar a los destinatario     
                    var v_tipo_organizacion=document.formRevisar.tipoOrg.value;                  
                    var v_destinatario=document.all.org.value;                 
                    var reporte = "DIST_02";
                        
                           if (window.XMLHttpRequest) {
                               ajaxDestinatario = new XMLHttpRequest();
                           } else {
                               ajaxDestinatario = new ActiveXObject("Microsoft.XMLHTTP");
                           }
                           ajaxDestinatario.onreadystatechange = funcionCallbackDestinatario;     
                                 
                           var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_Distribucion_ajax.jsp?pasacache=" + new Date().getTime() +"&reporte=" + reporte+"&v_tipo_organizacion=" + v_tipo_organizacion+"&v_destinatario=" + v_destinatario;                       
                           ajaxDestinatario.open("GET", ruta, true);
                           ajaxDestinatario.send("");   
                }

                        var ajaxDestinatario = null;
                       function funcionCallbackDestinatario() {                          
                           if (ajaxDestinatario.readyState === 4 && ajaxDestinatario.status === 200) {                                
                               document.all.modalDestinatario.innerHTML = ajaxDestinatario.responseText; 
                            //Retorna tabla Bootstrap y le da formato requerido a la tabla Distribucion
                            $(document).ready(function() { $('#distri').DataTable(); } );                      
                             
                               
                           }
             }
            
         
         
         
            /**
             * Funcion(05). Eimina  Lista de Destinatario sne el Modal DISTRIBUCION, Utiliza el mismo funcionCallbackDestinatario que el añadirDestinatarios
             * @param {type} v_tipo_organizacion
             * @param {type} v_destinatario
             * @returns {undefined}
             */
            
            /*
            function f_EliminaListaDestinatario(v_tipo_organizacion, v_destinatario) {

            var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=",
                                            new Date().getTime(),
                                           "&v_tipo_organizacion=",
                                            v_tipo_organizacion,
                                            "&v_destinatario=",
                                            v_destinatario,
                                            "&reporte=", 
                                            OPC_ELIMINA_DESTINATARIO)
                                            
                $("#modalDestinatario").load(ruta, function(){
                  $('#distri').DataTable(
                                {
                                    "scrollY": "200px",
                                    "scrollCollapse": true,
                                    "paging": false
                                }

                        );
                });

            }

            */
           
           
           /* 
  * Funcion(05). Eimina  Lista de Destinatario sne el Modal DISTRIBUCION, Utiliza el mismo funcionCallbackDestinatario que el añadirDestinatarios
  */ 
   function f_EliminaListaDestinatario(v_tipo_organizacion,v_destinatario){
                   
            var reporte = "DIST_03";
            if (window.XMLHttpRequest) {
             ajaxDestinatario = new XMLHttpRequest();
             } else {
             ajaxDestinatario = new ActiveXObject("Microsoft.XMLHTTP");
             }
            ajaxDestinatario.onreadystatechange = funcionCallbackDestinatario;                          
            var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_Distribucion_ajax.jsp?pasacache=" + new Date().getTime() +"&reporte=" + reporte+"&v_tipo_organizacion=" + v_tipo_organizacion+"&v_destinatario=" + v_destinatario;                       
            ajaxDestinatario.open("GET", ruta, true);
            ajaxDestinatario.send("");   
             }

            var ajaxDestinatario = null;
            function funcionCallbackDestinatario() {                          
            if (ajaxDestinatario.readyState === 4 && ajaxDestinatario.status === 200) {                                
               document.all.modalDestinatario.innerHTML = ajaxDestinatario.responseText;  
               //Retorna tabla Bootstrap y le da formato requerido a la tabla Distribucion
                     $(document).ready(function() { 
                         $('#distri').DataTable(); 
            } );
                     
             }         
           
            }
           
           
           
           

            /* 
             * Funcion(06). Captura el destinatario que le llegar ael Documento OFICO como Original
             */
            
            /**
             * 
             * @param {type} Nombre_dest
             * @param {type} Grado_dest
             * @param {type} Cargo_dest
             * @param {type} valor4
             * @param {type} Cod_organizacion
             * @param {type} Tipo_Organizacion
             * @returns {undefined}
             */
           
           /*
            function f_CapturaDestinarario(Nombre_dest, Grado_dest, Cargo_dest, valor4, Cod_organizacion, Tipo_Organizacion) {
alert("entro");
                document.formRevisar.txt_Grado.value = Grado_dest;
                document.formRevisar.txt_Cargo.value = Cargo_dest;
                //*para Pintar el Pie Destinatario o distribucion
                var periodo = document.formRevisar.txh_periodo.value;
                var cod_interno = document.formRevisar.txh_cod_int.value;
                document.formRevisar.txh_verifica.value = "SI";
                       
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=",
                                            new Date().getTime(),
                                            "&periodo=",
                                            periodo,
                                            "&cod_interno=",
                                            cod_interno,
                                            "&cod_organizacion=",
                                            Cod_organizacion,
                                             "&reporte=", 
                                            OPC_CAPTURA_DESTINATARIO)
                                            
                                            
                 $("#AjaxPieDestinatario").load(ruta, function(){
                 
                });
               
            }

         */
        
        function f_CapturaDestinarario(Nombre_dest,Grado_dest,Cargo_dest,tipo_dist,Cod_organizacion,Tipo_Organizacion){
          
        document.formRevisar.txt_Grado.value=Grado_dest;
        document.formRevisar.txt_Cargo.value=Cargo_dest;  
          //*para Pintar el Pie Destinatario o distribucion
        var periodo= document.formRevisar.txh_periodo.value;
        var cod_interno= document.formRevisar.txh_cod_int.value;
        document.formRevisar.txh_verifica.value="SI";
          
        var reporte = "DIST_04";
         
                if (window.XMLHttpRequest) {
                    ajaxPieDistribucion = new XMLHttpRequest();
                } else {
                    ajaxPieDistribucion = new ActiveXObject("Microsoft.XMLHTTP");
                }
                ajaxPieDistribucion.onreadystatechange = funcionCallbackPieDistribucion;
                var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_Distribucion_ajax.jsp?pasacache=" + new Date().getTime() +"&reporte=" + reporte+"&periodo="+periodo+"&cod_interno="+cod_interno+"&cod_organizacion="+Cod_organizacion+"&tipo_dist="+tipo_dist;
                ajaxPieDistribucion.open("GET", ruta, true);
                ajaxPieDistribucion.send("");
          
          
              
            }       
  
    var ajaxPieDistribucion = null;
            function funcionCallbackPieDistribucion() {
                if (ajaxPieDistribucion.readyState === 4 && ajaxPieDistribucion.status === 200) {
                    document.all.AjaxPieDestinatario.innerHTML = ajaxPieDistribucion.responseText; 
                    
                }
            }
  
        
        
            /* 
             * Funcion(07). Cierra en moal Disribucion, verificando que se señale el Original
             */
            function f_cerrar_moDistribucion() {
                var veri = document.formRevisar.txh_verifica.value;
                if (veri == "SI") {
                    $('#miModalDistribucion').modal('hide');
                } else {
                    alert("Debera selecionar a que destinatio se remitira como ORIGINAL ");
                }
            }
/*
 * 
 * ------------------------------------------------------------------03 REFERENCIA --------------------------------------------------------------------
 */

  /**
             * Funcion(03).  VIENE DEL AJAX I_PorRevisar.ajax reporte:02 - Abre el modal de Distribucion
             * @param {type} cod_org_cab
             * @param {type} periodo
             * @param {type} cod_interno
             * @returns {undefined}
             */
            
            function f_openReferencia( periodo, cod_interno) {
                           
            
            $('#miModalReferencia').modal({backdrop: 'static', keyboard: false});
            document.formRevisar.txh_periodo_ref.value=periodo;
            document.formRevisar.txh_cod_int_ref.value=cod_interno;
            
            var reporte = "REF_05";        
            var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=" , 
                                            new Date().getTime(),                                       
                                            "&periodo_orig=", 
                                            periodo, 
                                            "&codint_orig=", 
                                            cod_interno,                                        
                                            "&reporte=", 
                                            reporte)

                    $("#lista_ref").load(ruta, function(){
                         $('#Listarefer1').DataTable();

                     //Retorna  Bootstrap y le da formato requerido a la Combo en Linea, solo con 10 linea visibles   
                         $('.selectpicker').selectpicker({style: 'btn-info',size: 10 });
                         //,multiple data-max-options:'1' ,data-live-search:'true'
                    });                
            }


        function f_Ref_Opcion_Busqueda() {
              $('#miModalBusquedaRef').modal({backdrop: 'static', keyboard: false});
        }

        function f_Ref_Opcion_Agregar() {
              $('#miModalAgregarRef').modal({backdrop: 'static', keyboard: false});
        }
        
        function f_Buscar_Referencia() {            
        
        var cbo_Tipo_Organizacion = document.all.cbo_Tipo_Organizacion.value;
        var org_ref=document.all.org_ref.value;
        var txtFecDesde=document.all.txtFecDesde.value;
        var txtFecHasta=document.all.txtFecHasta.value;
        var cbx_Clase_Doc=document.all.cbx_Clase_Doc.value;
        var txt_nro_doc=document.all.txt_nro_doc.value;
        var txt_Asunto_Ref=document.all.txt_Asunto_Ref.value;
        var cbo_Periodo=document.all.cbo_Periodo.value;
        
        var cbo_Periodo_origen=document.all.txh_periodo_ref.value;
        var cbo_codint_origen=document.all.txh_cod_int_ref.value;
        
        
         
        var reporte = "REF_01";         
        var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=" , 
                                        new Date().getTime(),                             
                                        "&cbo_Tipo_Organizacion=", 
                                        cbo_Tipo_Organizacion,
                                        "&org_ref=", 
                                        org_ref,
                                        "&txtFecDesde=", 
                                        txtFecDesde,
                                        "&txtFecHasta=", 
                                        txtFecHasta,
                                        "&cbx_Clase_Doc=", 
                                        cbx_Clase_Doc,
                                        "&txt_nro_doc=", 
                                        txt_nro_doc,
                                        "&txt_Asunto_Ref=", 
                                        txt_Asunto_Ref,
                                        "&cbo_Periodo=", 
                                        cbo_Periodo,
                                        "&cbo_Periodo_origen=", 
                                        cbo_Periodo_origen,
                                        "&cbo_codint_origen=", 
                                        cbo_codint_origen,
                                        "&reporte=", 
                                        reporte)
                                  
                $("#modalListaBusRef").load(ruta, function(){
                     $('#refer').DataTable();
                
                 
                });
                         
        }
       


            var ajaxOrgRef = null;
            function funcionCallbackOrgRef() {
                if (ajaxOrgRef.readyState === 4 && ajaxOrgRef.status === 200) {
                    document.all.dis_org_ref.innerHTML = ajaxOrgRef.responseText;                    
                    $('.selectpicker').selectpicker({style: 'btn-info',size: 10 });
                }
            }

                       
              function f_org_referencia(tipo) {
                    var reporte = "REF_02";  
                   if (window.XMLHttpRequest) {
                    ajaxOrgRef = new XMLHttpRequest();
                } else {
                    ajaxOrgRef = new ActiveXObject("Microsoft.XMLHTTP");
                }
                ajaxOrgRef.onreadystatechange = funcionCallbackOrgRef;
               
                var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=" + new Date().getTime() + "&reporte=" + reporte + "&tipo=" + tipo;
                ajaxOrgRef.open("GET", ruta, true);
                ajaxOrgRef.send("");
              }
              
              
              
               var ajaxlistarRef = null;
            function funcionCallbackListarRef() {
                  alert("(1) que paso"+ajaxlistarRef.readyState+"-(1)status-"+ajaxlistarRef.status);
                if (ajaxlistarRef.readyState === 4 && ajaxlistarRef.status === 200) {
                    document.all.lista_ref.innerHTML = ajaxlistarRef.responseText;  
                   // document.all.pinta_ref.innerHTML = ajaxlistarRef.responseText; 
                  
                   setTimeout(funcionCallbackPintarRef1,1000);
                   
                     $(document).ready(function() { $('#Listarefer').DataTable(); } );  
                   
                   
                }
            }
            
            var ajaxpintaRef = null;
            function funcionCallbackPintarRef1() {
                    alert("(2)que pasos"+ajaxpintaRef.readyState+"- (2)status-"+ajaxpintaRef.status);
                if (ajaxpintaRef.readyState === 4 && ajaxpintaRef.status === 200) {
                    alert("div555555555555555");
                    document.all.pinta_ref.innerHTML = ajaxpintaRef.responseText;                    
                   
                                     
                   
                }
            }


                       
              function f_agrega_refe(periodo_ref,codint_ref,periodo_orig,codint_orig) {
                  alert("periodo_ref-"+periodo_ref+"codint_ref"+codint_ref+"periodo_orig"+periodo_orig+"codint_orig"+codint_orig);             
                  
          
               var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=" + new Date().getTime() + "&reporte=REF_03"+
                                                        "&periodo_ref=" + periodo_ref+
                                                        "&codint_ref=" + codint_ref+
                                                        "&codint_orig=" + codint_orig+
                                                        "&periodo_orig=" + periodo_orig;             
              
                refreshDivs('lista_ref',2,ruta);
               
               var ruta2 = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=" + new Date().getTime() + "&reporte=REF_04"+
                        "&codint_orig=" + codint_orig+
                        "&periodo_orig=" + periodo_orig;
                
                refreshDivs('pinta_ref',4,ruta2);

                  
              } 
              
              
              
              
              
              
              function refreshDivs(divid,secs,url) { 
                  
                 // alert("ingreso")
                          
                var divid,secs,url,fetch_unix_timestamp;
               
                if(divid == ""){ alert('Error: escribe el id del div que quieres refrescar'); return;}
                
                else if(!document.getElementById(divid)){ alert('Error: el Div ID selectionado no esta definido: '+divid); return;}
                
                else if(secs == ""){ alert('Error: indica la cantidad de segundos que quieres que el div se refresque'); return;}
                
                else if(url == ""){ alert('Error: la URL del documento que quieres cargar en el div no puede estar vacia.'); return;}
                // The XMLHttpRequest object

                    var xmlHttp;
                    try{
                    xmlHttp=new XMLHttpRequest(); // Firefox, Opera 8.0+, Safari
                    }
                    catch (e){
                    try{
                    xmlHttp=new ActiveXObject("Msxml2.XMLHTTP"); // Internet Explorer                    
                    }                    
                    catch (e){                    
                    try{                    
                    xmlHttp=new ActiveXObject("Microsoft.XMLHTTP");                    
                    }                    
                    catch (e){                    
                    alert("Tu explorador no soporta AJAX.");                    
                    return false;                    
                    }
                    
                    }
                    
                    }
                    // Timestamp para evitar que se cachee el array GET                   
                    fetch_unix_timestamp = function()                    
                    {                       
                    return parseInt(new Date().getTime().toString().substring(0, 10)*secs)                
                    }
                                 
                    var timestamp = fetch_unix_timestamp();    
                     //alert("timestamp--"+timestamp);
                    
                    var nocacheurl = url+"&t="+timestamp; 
                    //var nocacheurl = url; 
                  
                    
                    // the ajax call
                    
                    xmlHttp.onreadystatechange=function(){                    
                    if(xmlHttp.readyState == 4 && xmlHttp.status == 200){                    
                    document.getElementById(divid).innerHTML=xmlHttp.responseText;                    
                    //setTimeout(function(){refreshDivs(divid,secs,url);},secs*1000);                    
                    }
                    
                    }
                    
                    xmlHttp.open("GET",nocacheurl,true);                    
                    xmlHttp.send(null);
                    
                    }

                
      /*
       * 
       * @param {type} periodo
       * @param {type} cod_interno
       * @returns {undefined}
       */          

        function f_Grabar_Referencia() {
            
            var perido_orig=document.formRevisar.txh_periodo_ref.value;
            var cod_int_orig=document.formRevisar.txh_cod_int_ref.value;        

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

                frm_referencia.action = ctx_path.concat("/GrabarReferencia?cbo_Periodo=" + cbo_Periodo +
                        "&cbo_Tipo_Organizacion=" + cbo_Tipo_Organizacion +
                        "&org=" + org +
                        "&cbx_Clase_Doc=" + cbx_Clase_Doc +
                        "&txt_Nro_Orden=" + txt_Nro_Orden +
                        "&txt_Clave_Indic=" + txt_Clave_Indic +
                        "&txt_fecha_MP=" + txt_fecha_MP +
                        "&txt_Asunto_MP=" + txt_Asunto_MP +
                        "&cbx_Clasificacion=" + cbx_Clasificacion +
                        "&cbx_Prioridad=" + cbx_Prioridad +
                        "&perido_orig=" + perido_orig +
                        "&cod_int_orig=" + cod_int_orig +
                        "&accion=" + accion);
                frm_referencia.submit();
                
                
            var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=" + new Date().getTime() + "&reporte=REF_05"+
                                                        "&codint_orig=" + cod_int_orig+
                                                        "&periodo_orig=" + perido_orig;
             
              
            refreshDivs('lista_ref',2,ruta);
        
               
              var ruta2 = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=" + new Date().getTime() + "&reporte=REF_04"+
                        "&codint_orig=" + cod_int_orig+
                        "&periodo_orig=" + perido_orig;
                
                refreshDivs('pinta_ref',3,ruta2);
                
               
                

                $('#miModalAgregarRef').modal('hide');
                //Importante:::Funcion para que retorne la lista}          
                //  f_openAnexoVentana(periodo_anexo,cod_int_anexos);
            }



/*
             * Funcion(005). Muestra los anexos
             * @returns {undefined}
             */
            function f_MostraReferencia(periodo_origen,cod_int_origen,periodo_ref,cod_int_ref) {  
               
               $('#miModalVerReferencia').modal('show');               
                 
                   
                        var reporte = "REF_06";
  
                        if (window.XMLHttpRequest) {
                            ajaxverReferencia = new XMLHttpRequest();
                        } else {
                            ajaxverReferencia = new ActiveXObject("Microsoft.XMLHTTP");
                        }
                         
                        ajaxverReferencia.onreadystatechange = funcionCallbackVerReferencia;
                        
                        
                        
                        var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_Referencia_ajax.jsp?pasacache=" + new Date().getTime() +
                                "&reporte=" + reporte+
                                "&periodo_origen="+periodo_origen+
                                "&cod_int_origen="+cod_int_origen+
                                "&periodo_ref="+periodo_ref+
                                "&cod_int_ref="+cod_int_ref;
                        ajaxverReferencia.open("GET", ruta, true);
                        ajaxverReferencia.send("");
                
   
                        
                                   
                            
                            
                   
             }
             
             
              var ajaxverReferencia = null;
                                function funcionCallbackVerReferencia() {                                   
                                    if (ajaxverReferencia.readyState === 4 && ajaxverReferencia.status === 200) {                                       
                                        document.all.modalMostarReferencia.innerHTML = ajaxverReferencia.responseText;                                      

                                    }
                                }

            

       
         
/*
 * 
 * ------------------------------------------------------------------04 Anexos --------------------------------------------------------------------
 */        

            
            /**
             * Funcion(001). Abre el Modal de Anexos
             * @returns {undefined}
             */
            function f_openAnexoVentana(periodo,cod_interno) {                 
                 
               alert("------Mantenimiento de Anexos---------");  
              var accion_anexos=document.all.txh_accion_anexos.value; 
                if(accion_anexos=="insertar_anexos"){
                       alert("Se Grabó Exitosamente!!"); 
                      
                  } else if(accion_anexos=="actualizar_anexos"){
                      alert("Se Actualizó Exitosamente!!"); 
                      
                  }else if(accion_anexos=="eliminar_anexos"){
                       alert("Se Eliminó Exitosamente!!");
                  }
                            
                $('#miModalObs').modal('hide');                
                $('#miModalAnexo').modal({backdrop: 'static', keyboard: false});

               // var periodo = document.formRevisar.txh_periodo_rev.value;
              //  var cod_interno = document.formRevisar.txh_cod_int_rev.value;
                
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Anexos_ajax.jsp?pasacache=",
                                            new Date().getTime(),
                                            "&periodo=",
                                            periodo,
                                            "&cod_interno=",
                                            cod_interno,
                                            "&reporte=", 
                                            OPC_MUESTRA_ANEXOS)
                                            
                    $("#modalAnexos").load(ruta, function(){
                 
                            $('#table_anexos').DataTable();
                    });
            }


 /* 
             * Funcion(002). Graba los  anexos 
             */
          
            function f_Grabar_Anexos() {   
            
            var accion_anexos=document.all.txh_accion_anexos.value; 
            var periodo_anexo = document.all.txh_perido_anexos.value;         
            var cod_int_anexos = document.all.txh_codinter_anexos.value;          
            var sec_anexos = document.all.txh_secuencia_anexos.value;  
             var file_anexos = document.all.txh_archivo_anexos.value;  
            
                    
            var frm_anexos = $("#frm_anexos")[0];               
            
                if(accion_anexos=="insertar_anexos"){

                   frm_anexos.action = ctx_path.concat( "/capturaAnexos_RD?cod_interno="+cod_int_anexos+"&accion="+accion_anexos );
                   frm_anexos.submit();         
                   //Importante:::Funcion para que retorne la lista}          
                    f_openAnexoVentana(periodo_anexo,cod_int_anexos);
                 
                 

                }else if(accion_anexos=="actualizar_anexos"){
                                 
                   frm_anexos.action = ctx_path.concat( "/capturaAnexos_RD?cod_interno="+cod_int_anexos+"&accion="+accion_anexos+"&periodo_anexo="+periodo_anexo+"&sec_anexos="+sec_anexos );
                   frm_anexos.submit();         
                   //Importante:::Funcion para que retorne la lista
                   f_openAnexoVentana(periodo_anexo,cod_int_anexos); 
                    
                  
                }            

           
            }
              
            /* 
             * Funcion(003). Captura los datos de anexo para eliminar 
             */
            function f_CapturaAnexos(periodo, docinterno, secuencia, nombre_archivo) {
               
                document.all.txh_perido_anexos.value = periodo;
                document.all.txh_codinter_anexos.value = docinterno;
                document.all.txh_secuencia_anexos.value = secuencia;
                document.all.txh_archivo_anexos.value = nombre_archivo;
            }
            /* 
             * Funcion(004). Muestra la Capa para añadir anexos 
             */
            function f_InsertarAnexos() {                
                document.all.txh_accion_anexos.value="insertar_anexos";
                mostrar("capa_add_anexos");
            }
            
            /*
             * Funcion(005). Muestra los anexos
             * @returns {undefined}
             */
            function f_MostraAnexos() {  
               
               $('#miModalVerAnexos').modal('show');
                  document.all.txh_accion_anexos.value="mostar_anexos";
                    if(document.all.txh_secuencia_anexos.value!=""){
                          
                       var txh_perido_anexos=document.all.txh_perido_anexos.value;
                       var txh_codinter_anexos=document.all.txh_codinter_anexos.value;
                       var txh_secuencia_anexos=document.all.txh_secuencia_anexos.value;
                       var txh_archivo_anexos=document.all.txh_archivo_anexos.value;

                        var reporte = "ANEX_03";
  
                        if (window.XMLHttpRequest) {
                            ajaxverAnexos = new XMLHttpRequest();
                        } else {
                            ajaxverAnexos = new ActiveXObject("Microsoft.XMLHTTP");
                        }
                         
                        ajaxverAnexos.onreadystatechange = funcionCallbackVerAnexos;
                        
                         var extension = txh_archivo_anexos.split(".")[1];                           
                            if (extension === "doc" || extension === "xls" || extension === "ppt" || extension === "docx" || extension === "xlsx" || extension === "pptx"|| extension === "mp4"|| extension === "avi") {                           
                                $('#miModalVerAnexos').modal('hide');
                            }
                        
                        var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_Anexos_ajax.jsp?pasacache=" + new Date().getTime() +
                                "&reporte=" + reporte+
                                "&txh_perido_anexos="+txh_perido_anexos+
                                "&txh_codinter_anexos="+txh_codinter_anexos+
                                "&txh_secuencia_anexos="+txh_secuencia_anexos+
                                "&txh_archivo_anexos="+txh_archivo_anexos;
                        ajaxverAnexos.open("GET", ruta, true);
                        ajaxverAnexos.send("");
                
   
                        
                                   
                            
                            
                    }else{
                     alert("Debe Selecionar el Archivo Adjunto!::");
                     }
             }
             
             
              var ajaxverAnexos = null;
                                function funcionCallbackVerAnexos() {                                   
                                    if (ajaxverAnexos.readyState === 4 && ajaxverAnexos.status === 200) {                                       
                                        document.all.modalMostarAnexos.innerHTML = ajaxverAnexos.responseText;                                      

                                    }
                                }

            
             /*
             * Funcion(006). Actualiza los anexos
             * @returns {undefined}
             */
            function f_ActualizarAnexos() { 
                 document.all.txh_accion_anexos.value="actualizar_anexos";                
                 if(document.all.txh_secuencia_anexos.value!=""){                      
                        mostrar("capa_add_anexos");  
                    }else{
                     alert("Debe Selecionar el Archivo Adjunto!::");

                     }
                
            }
            
             /*
             * Funcion(00)Eliminar Anexos 
             * @returns {undefined}
             */
            function f_EliminarAnexos() {
             
                 document.all.txh_accion_anexos.value="eliminar_anexos";                   
              
                 if(document.all.txh_secuencia_anexos.value!=""){                      
                 var txh_perido_anexos=document.all.txh_perido_anexos.value;                   
                 var txh_codinter_anexos=document.all.txh_codinter_anexos.value;                
                 var txh_secuencia_anexos=document.all.txh_secuencia_anexos.value;
                 var txh_archivo_anexos=document.all.txh_archivo_anexos.value;
                 var reporte = "ANEX_04";                     
            
            
                var ruta = ctx_path.concat("/gedad/revisardoc/I_PorRevisar_Anexos_ajax.jsp?pasacache=",
                                  new Date().getTime(),
                                  "&reporte=", 
                                  reporte,
                                  "&txh_perido_anexos=",
                                  txh_perido_anexos,
                                  "&txh_codinter_anexos=",
                                  txh_codinter_anexos,
                                  "&txh_secuencia_anexos=",
                                  txh_secuencia_anexos,
                                  "&txh_archivo_anexos=",
                                  txh_archivo_anexos);   
                                  
                         

                  $("#modalListaAnexos").load(ruta, function(){

                    f_openAnexoVentana(txh_perido_anexos,txh_codinter_anexos);
                  
                                  
                   });

            
                    }else{
                     alert("Debe Selecionar el Archivo Adjunto!::");

                     }
                
            }

  /*
 * 
 * ------------------------------------------------------------------05 ENVIO DOCUMENTO --------------------------------------------------------------------
 */         
                

            /* 
             * Funcion(14). Funcion Abrir lo detalles del Envio
             */

            var ajaxCBXF = null;
                      function funcionCallbackCBXF() {
                          if (ajaxCBXF.readyState === 4 && ajaxCBXF.status === 200) {
                              document.all.div_cbx_firmado.innerHTML = ajaxCBXF.responseText;                    
                              //$('.selectpicker').selectpicker({style: 'btn-info',size: 10 });
                          }
             }

            function f_terminar(firma,recibe) {  
              
                    /*
                     * 
                     * @Este ajax es para cargar los Btones de Firmar por y Revisador Por 
                     */
                       var reporte = "REV_06";                            
                        if (window.XMLHttpRequest) {
                            ajaxCBXF = new XMLHttpRequest();
                        } else {
                            ajaxCBXF = new ActiveXObject("Microsoft.XMLHTTP");
                        }
                        ajaxCBXF.onreadystatechange = funcionCallbackCBXF;
                        var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=" + new Date().getTime() + "&reporte=" + reporte + "&firma=" + firma + "&recibe=" + recibe;
                        ajaxCBXF.open("GET", ruta, true);
                        ajaxCBXF.send("");

                     /*
                     * 
                     * @Este ajax es Mostra los botones de acuerdo  a la accion Firma Digital-Al Parte-Revisar 
                     */   

                         if (document.all.cbo_firmadoPor.value === document.all.cbo_revisadoPor.value &&
                                document.all.cbo_firmadoPor.value === usuario_logeado) {                    
                                document.all.txh_accion_botones.value="Btn_firma_digital";
                            } else {
                                if (document.all.cbo_firmadoPor.value === document.all.cbo_revisadoPor.value) {                          
                                    document.all.txh_accion_botones.value="Btn_Al_Parte";
                                } else {
                                    document.all.txh_accion_botones.value="Btn_Revisar";
                                }
                            } 
                           var accion_Botones=document.all.txh_accion_botones.value;                  

                            var reporte = "REV_07";                            
                            if (window.XMLHttpRequest) {
                                ajaxAccionBtn = new XMLHttpRequest();
                            } else {
                                ajaxAccionBtn = new ActiveXObject("Microsoft.XMLHTTP");
                            }
                            ajaxAccionBtn.onreadystatechange = funcionCallbackAccionBtn;
                            var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=" + new Date().getTime() + "&reporte=" + reporte + "&accion_Botones=" + accion_Botones ;
                            ajaxAccionBtn.open("GET", ruta, true);
                            ajaxAccionBtn.send("");

                     /*
                     * 
                     * @Mostra y ocultar Modales 
                     */   

                        $('#miModalObs').modal('hide');      
                        $('#miModalEnvio').modal({backdrop: 'static', keyboard: false});
                        $('#miModalDevolver').modal('hide');  
                   
            }
            
            
              


 /* 
             * Funcion(15). Habilitar y desactivar botones
             */
            
              var ajaxAccionBtn = null;
                      function funcionCallbackAccionBtn() {
                          if (ajaxAccionBtn.readyState === 4 && ajaxAccionBtn.status === 200) {
                              document.all.div_accion_btn.innerHTML = ajaxAccionBtn.responseText;                    
                              //$('.selectpicker').selectpicker({style: 'btn-info',size: 10 });
                          }
             }

            
            function f_habilitar(f_accion) {
                 /*
                 * 
                 * @Muestra la simulacion de la firma Digital
                 */  
                   
                    var usuario_logeado="<%=objBeanU.getVUSUARIO_CODIGO()%>";
               
                   if(f_accion=='firmado_por'){                  
                      var posTO = document.all.cbo_firmadoPor.options.selectedIndex;                
                      var des_to = document.all.cbo_firmadoPor.options[posTO].text; 
                      document.all.txt_firma_dig.value= des_to;  
                      document.location.href = "#ancla_revisa_arriba";
                      mostrar("div_firma_digital");
                      //mostrar("div_revisado_por");           

                   }                                   
                   if(f_accion=='revisado_por'){                  
                      mostrar("div_observacion_enviar");   
                   }
                   
               /*
                 * 
                 * @Accion cuando se elije en el Combo Firmado por y Revisado por
                 */  
               
                    if (document.all.cbo_firmadoPor.value === document.all.cbo_revisadoPor.value &&
                        document.all.cbo_firmadoPor.value === usuario_logeado) {                    
                        document.all.txh_accion_botones.value="Btn_firma_digital";
                    } else {
                        if (document.all.cbo_firmadoPor.value === document.all.cbo_revisadoPor.value) {                          
                            document.all.txh_accion_botones.value="Btn_Al_Parte";
                        } else {
                            document.all.txh_accion_botones.value="Btn_Revisar";
                        }
                    } 
                   var accion_Botones=document.all.txh_accion_botones.value;                  
                   
                    var reporte = "REV_07";                            
                    if (window.XMLHttpRequest) {
                        ajaxAccionBtn = new XMLHttpRequest();
                    } else {
                        ajaxAccionBtn = new ActiveXObject("Microsoft.XMLHTTP");
                    }
                    ajaxAccionBtn.onreadystatechange = funcionCallbackAccionBtn;
                    var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=" + new Date().getTime() + "&reporte=" + reporte + "&accion_Botones=" + accion_Botones ;
                    ajaxAccionBtn.open("GET", ruta, true);
                    ajaxAccionBtn.send("");
                   
                
            }
            
            
           
            

           
// Viene de combo de Tipo de Organizacion 
            function f_cargarOrganizacion(tipoOrganizacion) {
                alert("Que tipo de organizacion es :" + tipoOrganizacion);

                var reporte = "Distribucion_01";
                if (window.XMLHttpRequest) {
                    ajaxDistribucion = new XMLHttpRequest();
                } else {
                    ajaxDistribucion = new ActiveXObject("Microsoft.XMLHTTP");
                }
                ajaxDistribucion.onreadystatechange = funcionCallbackOrganizacion;
                var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_ajax.jsp?pasacache=" + new Date().getTime() + "&reporte=" + reporte + "&tipoOrganizacion=" + tipoOrganizacion;
                ajaxDistribucion.open("GET", ruta, true);
                ajaxDistribucion.send("");


            }

           
            function f_listaanexo(codint, periodo, clase, secuencia) {
                $('#miModal').modal('show');
            }



//finciones para cerrar las ventanas  de modal

   /* 
             * Funcion(09). Cierra en moal Disribucion, verificando que se señale el Original
             */
            function f_cerrar_moAnexos() {
                $('#miModalAnexo').modal('hide');
                document.all.txh_accion_anexos.value="";
            }


            function f_cerrar_moAlerta() {

                $('#miModalAlerta').modal('hide');

            }
            
             function f_cerrar_moObs() {
                $('#miModalObs').modal('hide');
            }
            
            function f_cerrar_moDetalleEnvio() {
                
                $('#miModalEnvio').modal('hide');
                document.all.txh_accion_botones.value="";
            }
            
             function f_cerrar_moDevolver() {
                $('#miModalDevolver').modal('hide');
            }
            
              function f_cerrar_verAnexos() {
                $('#miModalVerAnexos').modal('hide');
            }
            function f_cerrar_moAlertaDelvolver() {
                $('#miModalAlertaDevolver').modal('hide');
            }
            
            function f_cerrar_moReferencia() {
                $('#miModalReferencia').modal('hide');
              
            }
            
             function f_cerrar_moAgregarRef() {
                $('#miModalAgregarRef').modal('hide');
              
            }
            function f_cerrar_moBusquedaRef() {
                $('#miModalBusquedaRef').modal('hide');
              
            }
             function f_cerrar_verReferencia() {
                $('#miModalVerReferencia').modal('hide');
              
            }



        </script>

    </head>

    <body>
        <form id="formRevisar" name="formRevisar" method="post" action="">
            <input name="tipoOrg" type="hidden" value='G' />
            <!--Variables para Verificar si antes de retornar  al revisar oficio a seleccionado el Original -->
            <input name="txh_verifica" type="hidden"  value='aaaaaa' />
            <input name="txh_url_anexo" type="hidden"  />
            <input name="txh_accion_anexos" type="hidden"  />
            <input name="txh_cog_org" type="hidden" value="<%=objBeanU.getCUSUARIO_COD_ORG()%>" />
            <input name="txh_accion_botones" type="hidden"  />
            <input name="txh_periodo_ref" type="hidden"  />
             <input name="txh_cod_int_ref" type="hidden"  />
 

            <!--Fin Variables para Cargar el "modalREVISAR" -->

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
                                    <span class="glyphicon glyphicon-user" style="color:rgb(217, 81, 77);">&nbsp;<b><i>Usuario:</i>&nbsp;<%=objBeanU.getVUSUARIO_CARGO()%></b></span>
                                    <td>
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
                                                <li><a href="<%= request.getContextPath()%>/ayuda"><span class="glyphicon glyphicon-user"></span> Ayuda</a></li>
                                                <li><a href="#"><span class="glyphicon glyphicon-user"></span> Cambiar Clave</a></li>
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
                                
                                <td VALIGN="TOP"> <div id="listado">
                                      <% 
                                        ArrayList listaPorRevisar = (ArrayList) objRD.ObtenerListaDocumentosXRevisar("A",objBeanU.getVUSUARIO_CODIGO(), objBeanU.getCUSUARIO_COD_ORG());
                                      %>  
                                       <table class="display" width="90%" border="1"  id="example">
                                            <thead>
                                                <tr style="background-color:#ADADAD">
                                                    
                                                    <th><div align="center">FECHA</div></th>
                                                    <th><div align="center">ORGANIZACIÓN</div></th>
                                                    <th><div align="center">CLASE</div></th>
                                                    <th><div align="center">N°</div></th>
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

                                                %>
                                                <tr>
                                                    <td><%=objBeanD.getDHDOCUMENTO_FECH_ESTADO()%></td>
                                                    <td><%=objBeanD.getVHDOCUMENTO_COD_USU_ENV()%></td>                                                  
                                                    <td><%=objBeanD.getVCLASE_NOM_CORTO()%></td>
                                                    <td><%=objBeanD.getCDOCUMENTO_COD_DOC_INT()%></td>
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

                            <!-- Modal (01)::Inicio Modal Registro-->
                            <div class="modal fade" id="miModalREVISAR" style="overflow-y: scroll;" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                <!-- Dentro del Modal se añade unj Tabla para el combox prioridad, a la firma de y revisado por  -->

                                <!--Fin Tabla dentro del Modal -->                                                        
                                <div class="modal-dialog modal-lg" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                                <span aria-hidden="true">&times;</span>
                                            </button>
                                        </div>
                                        <div class="modal-body" id="regmodal">
                                            <div align="right">
                                                
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <!--Fin Modal-->

                                         <div id="ajaxrevisar"></div>

                            <!-- Modal (02)::Modal Distribucion -->                        
                            <div class="modal fade" id="miModalDistribucion"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

                                <div class="modal-dialog " role="document">                                 
                                    <div class="modal-content">                                    
                                        <div class="modal-header"  style="background-color:rgb(222,97,94)"> <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Distribución</b></span>  
                                            <a href="javascript:f_cerrar_moDistribucion();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>Cerrar</i></b>&nbsp;<span class="glyphicon glyphicon-remove"></span></p>  </a>                                      
                                        </div>
                                        <div  id="modalDistribucion">                                        

                                        </div>


                                    </div>
                                </div>
                            </div>
                            <!--FIN MODAL Ventana Distribucion-->
                            
                            
                           

                            

                            <!-- Modal (03)::Modal eNVIO-->                        
                            <div class="modal fade" id="miModalEnvio"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

                                <div class="modal-dialog " role="document">                                 
                                    <div class="modal-content">                                    
                                        <div class="modal-header"  style="background-color:rgb(0, 159, 246)"> <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Detalles de Envio</b></span> 
                                            <a href="javascript:f_cerrar_moDetalleEnvio();">  <p style="color:rgb(240, 235, 235);" align="center"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                                        </div>
                                        <div  id="modalEnvio">  
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
                                                    <div id="div_cbx_firmado" >                                                    
                                                                                              
                                                    </div>
                                                </td>                                                
                                                </tr>
                                                                                           
                                               <tr>
                                                   <td>
                                                       <div id="div_observacion_enviar" >
                                                    <table>
                                                        <tr>
                                                            <td>                                                                   
                                                            <a href="javascript:f_clasificacion();"   ><img src="<%=request.getContextPath()%>/imagenes/icono/chat.png" width="70px" height="60px" align="center" />ANOTACION PARA ENVIAR:</a>
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
                                                        <div id="div_accion_btn" ></div>                                                       
                                                    
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

                                <div class="modal-dialog " role="document">                                 
                                    <div class="modal-content">                                    
                                        <div class="modal-header"  style="background-color:rgb(254, 0, 0)"> <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Devolver Documento</b></span> 
                                            <a href="javascript:f_cerrar_moDevolver();">  <p style="color:rgb(240, 235, 235);" align="center"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                                        </div>
                                        <div  id="modalEnvio">  
                                            <table>
                                                                                   
                                             <tr>                                                                                        
                                                <td>
                                                    
                                                    <table>
                                                        <tr>
                                                            <td rowspan="2">    <a href="javascript:f_devolverdocumento();"   ><img src="<%=request.getContextPath()%>/imagenes/icono/devolver.png" width="70px" height="60px" align="center" title="Se devolvera el documento a quien lo formulo, añada observación .." /></a>                                                            
                                                            </td>                                                           
                                                        </tr>
                                                        <tr>                                                           
                                                            <td>
                                                     <div class="form-group">
                                                      
                                                         <textarea class="form-control rounded-0" id="txA_Obs" rows="8" cols="35"  ></textarea>
                                                    </div></td>
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
                        
                      
                        
                        <!-- Modal (04)::Modal ALERTA Envio exitoso-->                        
                            <div class="modal fade" id="miModalAlerta"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

                                <div class="modal-dialog " role="document">                                 
                                    <div class="modal-content">                                    
                                        <div class="modal-header"  style="background-color:rgb(39, 204, 51)"> <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Envio Exitoso!!!!</b></span> 
                                            <a href="javascript:f_cerrar_moAlerta();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>Cerrar  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                                        </div>
                                        <div  id="modalEnvio">  
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
                        
                        
                           <!-- Modal (04)::Modal ALERTA-->                        
                            <div class="modal fade" id="miModalAlertaDevolver"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

                                <div class="modal-dialog " role="document">                                 
                                    <div class="modal-content">                                    
                                        <div class="modal-header"  style="background-color:rgb(254, 0, 0)"> <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Envio Exitoso!!!!</b></span> 
                                            <a href="javascript:f_cerrar_moAlertaDelvolver();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>Cerrar  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                                        </div>
                                        <div  id="modalEnvio">  
                                            <table>
                                                                                   
                                             <tr>                                                                                        
                                                <td>                                                    
                                                    El documento fue devuelto!!!
                                                </td>                                                
                                         
                                           
                                           
                                        </table>

                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--FIN MODAL Modal ALERTA-->
                        
                        
                          <!-- Modal (04)::Modal oBSERVACION-->                        
                            <div class="modal fade" id="miModalObs"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

                                <div class="modal-dialog " role="document">                                 
                                    <div class="modal-content">                                    
                                        <div class="modal-header"  style="background-color:rgb(87, 35, 100)"> 
                                            <img src="<%=request.getContextPath()%>/imagenes/icono/chat.png" width="90px" height="50px" align="left" />
                                            <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Anotaciones</b></span> 
                                            <a href="javascript:f_cerrar_moObs();">  <p style="color:rgb(240, 235, 235);" align="left"><b><i>Cerrar  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                                        </div>
                                        <div  id="modalAnotacion">  
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
                        <!--FIN MODAL Modal oBSERVACION-->

                      <%-- VENTANA DE VISTA PREVIA --%>
            <div class="modal fade" id="miModalVP" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                            <h4 class="modal-title" id="myModalLabel">VISTA PREVIA</h4>
                        </div>
                       
                        <div class="modal-body" id="salida" style="height: 500px">
                                            <div align="right">
                                                
                                            </div>
                         </div>
                    </div>
                </div>
            </div>



                        <!--Fin Modal-->
                        </form>

                                                
                           <!-- CUADROS DE DIALOGO -->
                        
                        <!-- Modal (03)::Modal Anexo -->                        
                        <div class="modal fade" id="miModalAnexo"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog " role="document">                                 
                                <div class="modal-content">                                    
                                    <div class="modal-header"  style="background-color:rgb(0, 159, 246)"> <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Anexos</b></span> 
                                        <a href="javascript:f_cerrar_moAnexos();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                                    </div>
                                    <div  id="modalAnexos">  
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!--FIN MODAL Modal Anexo-->    
                        
                        
                          <!-- Modal (02)::Modal Distribucion -->                        
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
                            <!--FIN MODAL Ventana Distribucion-->
                                                
                            
                        <!-- Modal (03)::Modal Anexo -->                        
                        <div class="modal fade" id="miModalReferencia"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog " role="document">                                 
                                <div class="modal-content">                                    
                                    <div class="modal-header"  style="background-color:rgb(51, 122, 183)"> <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Referencia</b></span> 
                                        <a href="javascript:f_cerrar_moReferencia();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                                    </div>
                                    <table width="100%">
                                        <tr>
                                            <td width="50%">
                                                <div id="moopio" align="center"><a href="javascript:f_Ref_Opcion_Busqueda();">  Busqueda</a></div>
                                            </td>
                                            <td width="50%">
                                                <div id="moopio1" align="center"><a href="javascript:f_Ref_Opcion_Agregar();"> Agregar Referencia</a></div>
                                            </td>
                                        </tr> 
                                        
                                    </table>
                                   
                                    <table>
                                        <TR>
                                            <TD><div id='lista_ref'>
                                      
                                                
                                                </div>
                                            </TD>
                                        </TR>
                                    </table>
                                </div>
                            </div>
                        </div>
                        <!--FIN MODAL Modal Anexo--> 
                            
                          <!-- Modal (02)::Modal MOSTRAR Referencia -->                        
                            <div class="modal fade" id="miModalVerReferencia"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

                                <div class="modal-dialog " role="document">                                 
                                    <div class="modal-content">                                    
                                        <div class="modal-header"  style="background-color:rgb(222,97,94)">  
                                            <a href="javascript:f_cerrar_verReferencia();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                                        </div>
                                        <div  id="modalMostarReferencia">                                        

                                        </div>


                                    </div>
                                </div>
                            </div>
                            <!--FIN MODAL Ventana Distribucion-->
                        
                        
                        
                          <!-- Modal (03)::Modal Busqueda -->                        
                        <div class="modal fade" id="miModalBusquedaRef"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog " role="document">                                 
                                <div class="modal-content">                                    
                                    <div class="modal-header"  style="background-color:rgb(79,191,168)"> 
                                        <a href="javascript:f_cerrar_moBusquedaRef();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                                    </div>
                                    <div align="center"><span style="color:rgb(130, 130, 130);font-size: 18px" align="center" ><b>Busqueda de Referencia</b></span> </div> 
                                    <table >
                                        <tr>
                                            <td>
                                                <table>
                                                    <tr>
                                                       <td><div align="left" class="EstiloOF">Año</div></td>
                                                       <td><div align="left" class="EstiloOF">Clase Documento</div></td>
                                                       <td><div align="left" class="EstiloOF">Tipo Organizacion</div></td>
                                                       <td><div align="left" class="EstiloOF">Organización</div></td>
                                                       
                                                    </tr>
                                                    <tr>
                                                       <td>
                                                           <select name="cbo_Periodo" class="form-control" id="cbo_Periodo" >
                                                            <option >2018</option>
                                                             <option >2017</option>
                                                             <option >2016</option>
                                                           </select>   
                                                       </td>
                                                       <td><select name='cbx_Clase_Doc' id='cbx_Clase_Doc'  class='selectpicker' data-live-search='true'   >
                                                            <%
                                                              Iterator iteratorClaseDoc = objCombobox.obtenerClaseDocumento().iterator();          
                                                                while (iteratorClaseDoc.hasNext()) {
                                                                    BeanClase beanclase = (BeanClase) iteratorClaseDoc.next();
                                                                    out.println("<option value=" + beanclase.getCCLASE_CODIGO() + ">" + beanclase.getVCLASE_NOM_LARGO() + "</option>");         
                                                                 }

                                                           %>  
                                                          </select>
                                                       </td>
                                                          <td><select name="cbo_Tipo_Organizacion" class="form-control" id="cbo_Tipo_Organizacion"  onchange="javascript:f_org_referencia(this.value);">
                                                            <option value="I">Interna</option>
                                                             <option value="E">Externa</option> 
                                                           </select>
                                                       </td>  
                                                        <td>
                                                            <div id="dis_org_ref">
                                                            <select name='org_ref' id='org_ref'  class='selectpicker' data-live-search='true'   >
                                                              <%
                                                                Iterator iteratorOrgI = objCombobox.obtenerOrganizacionEjercito_MP().iterator();          
                                                                  while (iteratorOrgI.hasNext()) {
                                                                      BeanOrganizacionInterna beanorgi = (BeanOrganizacionInterna) iteratorOrgI.next();
                                                                      out.println("<option value=" + beanorgi.getCOINTERNA_CODIGO() + ">" + beanorgi.getVOINTERNA_NOM_CORTO() + "</option>");         
                                                                   }

                                                             %>  
                                                            </select>
                                                            </div>
                                                        </td>
                                                        
                                                    </tr>
                                                    <tr>
                                                        <td ><div align="left" class="EstiloOF">Nro Documento</div></td>
                                                        <td ><div align="left" class="EstiloOF">Desde</div></td>   
                                                        <td ><div align="left" class="EstiloOF">Hasta</div></td>  
                                                         <td ><div align="left" class="EstiloOF">Asunto</div></td>  
                                                    </tr>
                                                      <tr>
                                                        <td><div align="left" class="EstiloOF">
                                                               <input name="txt_nro_doc" id="txt_nro_doc"   type="text" class="form-control"  />
                                                           </div>
                                                        </td>
                                                       <td><div align="left" class="EstiloOF">
                                                                <input type="text" class="form-control datepicker" name="txtFecDesde" id="txtFecDesde" size="10" maxlength="10" value="01/01/2018"/>
                                                            </div>
                                                        </td>
                                                       <td><div align="left" class="EstiloOF"><div align="left" class="EstiloOF">
                                                            <input type="text" class="form-control datepicker" name="txtFecHasta" id="txtFecHasta" size="10" maxlength="10" value="31/12/2018"/>
                                                            </div>
                                                           </div>
                                                       </td>
                                                       <td colspan="4"><div align="left" ><input name="txt_Asunto_Ref" id="txt_Asunto_MP"   type="text" class="form-control"  /></div>
                                                       </td> 
                                                    </tr>
                                                    
                                                    
                                                     
                                                    <tr>
                                                        <td colspan="4">
                                                            <button class="btn btn-info btn-info" style="width: 580px" type="button" onclick="javascript:f_Buscar_Referencia();"><b>BUSQUEDA</b></button> 
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            
                                        </tr>
                                        <!-- Para la tabla de Referencia -->   
                                         <tr>
                                              <td>
                                                  <div id="modalListaBusRef">
                                                 
                                                 </div>
                                                 
                                             </td>
                                         </tr>
                                    </table>
                                    
                                </div>
                            </div>
                        </div>
                         
                          <!-- Modal (03)::Modal Anexo -->                        
                        <div class="modal fade" id="miModalAgregarRef"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                            <div class="modal-dialog " role="document">                                 
                                <div class="modal-content">                                    
                                    <div class="modal-header"  style="background-color:rgb(79,191,168)">   <img src="<%=request.getContextPath()%>/imagenes/icono/mp.png" width="110px" height="70px" align="left" />
                                        <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Agregar Referencia</b></span> 
                                        <a href="javascript:f_cerrar_moAgregarRef();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                                    </div>
                                    <div>
                                       <div align="left">

                                            <table>
                                                <tr>                        
                                                    <td colspan="6"  style="background: #D4FD89">
                                                        <div align="left"><span style="color:rgb(111, 111, 111); font-family: tahoma"><u>I. Datos del la Organización que Remite : </u></span></div>
                                                    </td>    
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td>&nbsp;&nbsp;</td>
                                                                <td><div align="left" class="EstiloOF">Año</div></td>
                                                                <td>&nbsp;&nbsp;</td>
                                                                <td><div align="left" class="EstiloOF">Tipo Organización</div> </td>
                                                                <td>&nbsp;&nbsp;</td>
                                                                <td><div align="left" class="EstiloOF">Organización</div> </td>
                                                            </tr>
                                                            <tr>
                                                                <td>&nbsp;&nbsp;</td>
                                                                <td><select name="cbo_Periodo_Agr_ref" class="form-control" id="cbo_Periodo_Agr_ref" >
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
                                                                <td><select name="cbo_Tipo_Organizacion_Agr_Ref" class="form-control" id="cbo_Tipo_Organizacion_Agr_Ref" onchange="f_DIS_AGR_REF(this.value)">
                                                                        <option value="I">Interna</option>
                                                                        <option value="E">Externa</option> 
                                                                    </select>
                                                                    <td>&nbsp;&nbsp;</td>
                                                                </td>
                                                                <td><div id="dis_org_Agr_Ref">
                                                                        <select name='org_Agr_Ref' id='org_Agr_Ref'  class='selectpicker' data-live-search='true'   >
                                                                            <%                                                       
                                                                                Iterator iteratorOrgI1 = objCombobox.obtenerOrganizacionEjercito_MP().iterator();
                                                                                while (iteratorOrgI1.hasNext()) {
                                                                                    BeanOrganizacionInterna beanorgi = (BeanOrganizacionInterna) iteratorOrgI1.next();
                                                                                    out.println("<option value=" + beanorgi.getCOINTERNA_CODIGO() + ">" + beanorgi.getVOINTERNA_NOM_CORTO() + "</option>");
                                                                                }

                                                                            %>  
                                                                        </select>
                                                                    </div>

                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>

                                            </table>    
                                            <table>
                                                <tr>                        
                                                    <td colspan="6"  style="background: #D4FD89">
                                                        <div align="left"><span style="color:rgb(111, 111, 111); font-family: tahoma"><u>II. Datos del documento : </u></span></div>
                                                    </td>       
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table>
                                                            <tr>
                                                                <td>&nbsp;&nbsp;</td>
                                                                <td><div align="left" class="EstiloOF">Clase Documento</div></td>
                                                                <td>&nbsp;&nbsp;</td>
                                                                <td><div align="left" class="EstiloOF">Nro Docuemento</div> </td>
                                                                <td>&nbsp;&nbsp;</td>
                                                                <td><div align="left" class="EstiloOF">Indicativo</div> </td>
                                                                <td>&nbsp;&nbsp;</td>
                                                                <td><div align="left" class="EstiloOF">Fecha Documento</div> </td>
                                                            </tr>
                                                            <tr>
                                                                <td>&nbsp;&nbsp;</td>
                                                                <td><div align="left" class="EstiloOF">
                                                                        <select name='cbx_Clase_Doc_Agr_Ref' id='cbx_Clase_Doc_Agr_Ref'  class='selectpicker' data-live-search='true'   >
                                                                            <%                                                       
                                                                                Iterator iteratorClaseDoc1 = objCombobox.obtenerClaseDocumento().iterator();
                                                                                while (iteratorClaseDoc1.hasNext()) {
                                                                                    BeanClase beanclase = (BeanClase) iteratorClaseDoc1.next();
                                                                                    out.println("<option value=" + beanclase.getCCLASE_CODIGO() + ">" + beanclase.getVCLASE_NOM_LARGO() + "</option>");
                                                                                }

                                                                            %>  
                                                                        </select>
                                                                    </div>
                                                                </td>
                                                                <td>&nbsp;&nbsp;</td>
                                                                <td><div align="left" class="EstiloOF"><input name="txt_Nro_Orden_Agr_Ref" id="txt_Nro_Orden_Agr_Ref" type="text" class="form-control" size="3"  /></div> </td>
                                                                <td>&nbsp;&nbsp;</td>
                                                                <td><div align="left" class="EstiloOF"><input name="txt_Clave_Indic_Agr_Ref" id="txt_Clave_Indic_Agr_Ref"   type="text" class="form-control" size="3"  /></div> </td>
                                                                <td>&nbsp;&nbsp;</td>
                                                                <td><div align="left" class="EstiloOF"><input name="txt_fecha_Agr_Ref" id="txt_fecha_Agr_Ref"   type="text" class="form-control" size="3" /></div> </td>
                                                            </tr>
                                                            <tr>
                                                                <td>&nbsp;&nbsp;</td>
                                                                <td colspan="7"><div align="left" class="EstiloOF">Asunto</div></td>                                              
                                                            </tr>
                                                            <tr>
                                                                <td>&nbsp;&nbsp;</td>
                                                                <td colspan="7"><div align="left" class="EstiloOF"><input name="txt_Asunto_Agr_Ref" id="txt_Asunto_Agr_Ref"   type="text" class="form-control" size="3" /></div></td>                                              
                                                            </tr>
                                                            <tr>
                                                                <td>&nbsp;&nbsp;</td>
                                                                <td colspan="3"><div align="left" class="EstiloOF">Clasificación</div></td>

                                                                <td>&nbsp;&nbsp;</td>
                                                                <td colspan="3"><div align="left" class="EstiloOF">Prioridad</div> </td>

                                                            </tr>
                                                            <tr>
                                                                <td>&nbsp;&nbsp;</td>
                                                                <td colspan="3"><div align="left" class="EstiloOF">

                                                                        <select name='cbx_Clasificacion_Agr_Ref' id='cbx_Clasificacion_Agr_Ref'  class='selectpicker' data-live-search='true'   >
                                                                            <%                                                        Iterator iteratorClasificacion = objCombobox.obtenerClasificacion().iterator();
                                                                                while (iteratorClasificacion.hasNext()) {
                                                                                    BeanClase beanclase = (BeanClase) iteratorClasificacion.next();
                                                                                    out.println("<option value=" + beanclase.getCCLASE_CODIGO() + ">" + beanclase.getVCLASE_NOM_LARGO() + "</option>");
                                                                                }

                                                                            %>  
                                                                        </select>
                                                                    </div>
                                                                </td>

                                                                <td>&nbsp;&nbsp;</td>
                                                                <td colspan="3"><div align="left" class="EstiloOF"> 
                                                                        <select name='cbx_Prioridad_Agr_Ref' id='cbx_Prioridad_Agr_Ref'  class='selectpicker' data-live-search='true'   >
                                                                            <%                                                        Iterator iteratorPrioridad = objCombobox.obtenerPrioridades().iterator();
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
                                                </tr>


                                            </table>
                                            <table>
                                                <tr>                        
                                                    <td colspan="6"  style="background: #D4FD89">
                                                        <div align="left"><span style="color:rgb(111, 111, 111); font-family: tahoma"><u>III. Adjuntar Documentos : </u></span></div>
                                                    </td>       
                                                </tr>
                                                <tr>
                                                    <td colspan="7">
                                                        <div id="capa_add_referencia" style="width:100%; align-content: center">                                   
                                                            <form method="POST" action="#" enctype="multipart/form-data" id="frm_referencia" target="frame_refe">
                                                                <!-- COMPONENT START -->
                                                                <div class="form-group">
                                                                    <div class="input-group input-file" name="Fichier1">

                                                                        <label for="url_Referencia"></label>
                                                                        <input type="file" class="form-control" id="url_Referencia" name="fileAnexo" style="width: 550px" />
                                                                       

                                                                    </div>
                                                                </div>
                                                                <div align="center">
                                                                 <span class="input-group-btn">
                                                                            <button class="btn btn-warning btn-reset" type="button" onclick="javascript:f_Grabar_Referencia();"><b>GRABAR</b></button>
                                                                            <button class="btn btn-info btn-info"  type="button" onclick="javascript:f_cancelar();"><b>CANCELAR</b></button>
                                                                        </span>
                                                                </div>
                                                            </form>

                                                            <!-- agregar despues el css: display:none -->
                                                            <iframe name="frame_refe" style="background: rgba(0,0,0,0.3); width: 100%; height: 80px;visibility: hidden">
                                                                IFrame de soporte
                                                            </iframe>


                                                        </div> 
                                                    </td>
                                                </tr>

                                            </table>


                                        </div> 
                                        
                                    </div>
                                    
                                                                      
                                </div>
                            </div>
                        </div>
                          
                        
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
                        </body>
                        </html>