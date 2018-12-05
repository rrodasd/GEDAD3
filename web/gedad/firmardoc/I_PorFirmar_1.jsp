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
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/bootstrap.min.css" />       
        <link rel="stylesheet" media="screen,projection" type="text/css" href="<%= request.getContextPath()%>/css/bootstrap-select.min.css" />
        
        <!-- SCRIPTS -->
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.min.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery-3.1.1.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/jquery.dataTables.min.js"></script>
        <script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js" ></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/bootstrap-select.min.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/pe.mil.ejercito.commons.js"></script>
        <script type="text/javascript" src="<%= request.getContextPath()%>/js/pe.mil.ejercito.constants.js"></script>
        
        <!-- API CERTIFICADO FIGITAL -->
       <!-- <script type="text/javascript" src="https://dsp.reniec.gob.pe/refirma_invoker/resources/js/client.js"></script> -->
          <script type="text/javascript" src="<%= request.getContextPath()%>/js/client.js"></script>
        
       <script type="text/javascript">
  
    window.addEventListener('getArguments', function (e) {
         alert("111");
				// Para nuestro caso siempre vamos a llamar desde la web
                                ObtieneArgumentosParaFirmaDesdeLaWeb(); 
    });
    
    window.addEventListener('invokerOk', function (e) { 
				MiFuncionOkWeb();	
			});
                        
    window.addEventListener('invokerCancel', function (e) {    
				MiFuncionCancel();	
			});
                        
    function getArguments(){	
        arg = document.getElementById("argumentos").value;				
        dispatchEventClient('sendArguments', arg);																
    }
    
    /**
     * Metodo que permite pasar argumentos para que pueda firmarse desde la web
     * @returns 
     */
    function ObtieneArgumentosParaFirmaDesdeLaWeb(){
        // Se debe generar un nuevo Servlet
        alert("invoca al llamar al servlet GEDAD ..");
        $.post("/GEDAD/argumentos", {
                documentName : "2018006173.pdf",
|        }, function(data, status) {				
                document.getElementById("argumentos").value = data;
                getArguments();
        });			
    }
    
    /**
     * Si puede firmar el documento mostrará un mensaje de confirmación
     * @returns {undefined}
     */
    function MiFuncionOkWeb(){
            alert("Documento firmado desde una URL correctamente.");
            document.getElementById("signedDocument").href="getFileServlet?documentName=" + documentName_; // A validar
    }
    
    /**
     * Solo si decide cancelar la firma
     * @returns {undefined}
     */
    function MiFuncionCancel(){
            alert("El proceso de firma digital fue cancelado.");
    }	
    
</script>    
        
        <!--     FIN LIBRERIAS ESTANDAR   -->       
        <style type="text/css">
            
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
                left: 55%;
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
            
            


        </style>
        
        <%
             BeanUsuarioAD objBeanU = (BeanUsuarioAD) session.getAttribute("usuario");
            String msg_oficio = request.getParameter("msg");
            session.setAttribute("anexos", null);
            String guarn = (String) session.getAttribute("ses_guarnicion");
            String alafirma = (String) session.getAttribute("alafirma");
            String codusu = (String) session.getAttribute("admusuario");
            //System.out.println("Sesion Grado: "+session.getAttribute("grado"));
        %>
        
        <script type="text/javascript">
            
         
            var ctx_path = "<%= request.getContextPath()%>";
            
            // Mostrar y Ocultar Capas
            function mostrar(nombreCapa) {
                document.getElementById(nombreCapa).style.visibility = "visible";
            }

            function ocultar(nombreCapa) {
                document.getElementById(nombreCapa).style.visibility = "hidden";
            }

/*
 * 
 * ------------------------------------------------------------------01 REVISAR DOCUEMNTO --------------------------------------------------------------------
 */  
          function f_FirmaDigital(){
              
              
              // Se debe llamar a la firma digital
              alert("invocando la firma");
             // insertFrame();
              initInvoker('W');
              
              
              
              
              
              
              
//              
//              var cod="12345";
//               var cod1="12345";
//              formRevisar.action = ctx_path.concat( "/reporteFirmaDigital?cod_interno="+cod+"&accion="+cod1);
//              formRevisar.submit();  
              
          }
    
    
    
    
    
    
    /**
             * Retorna el listado de los documentos por Revisar
             * @param {type} dependencia
             * @returns {undefined}
             */
            function f_listar(dependencia) {
               
            alert("sss");
                if( isEq(dependencia, SEL_DEPENDENCIA_VACIO) ){
                    $("#listado").html("");
                    return; 
                }
                
                var ruta = ctx_path.concat("/gedad/firmardoc/I_PorFirmar_ajax.jsp?pasacache=", 
                                            new Date().getTime(), 
                                            "&dependencia=", 
                                            dependencia, 
                                            "&reporte=", 
                                            OPC_LISTAR_DOCUMENTOS);
                
                $("#listado").load(ruta, function(){
                    $('#example').DataTable();
                });
            }
            
            
            /**
             * Presenta el documento cargado para ser revisado
             * @param {type} codint
             * @param {type} clase
             * @param {type} periodo
             * @param {type} secuencia
             * @returns {undefined}
             */
            function f_verdoc(codint, clase, periodo, secuencia,observa) {
               alert(codint+observa);
               document.all.area_obs.value=observa;
               
                $('#miModalObs').modal('show');
                //ABRE MODAL DE REVISAR    
                $('#miModalREVISAR').modal({backdrop: 'static', keyboard: false});
                
                var ruta = ctx_path.concat("/gedad/firmardoc/I_PorFirmar_ajax.jsp?pasacache=", 
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

            function f_devolver() {               
                $('#miModalDevolver').modal({backdrop: 'static', keyboard: false});
                 $('#miModalEnvio').modal('hide');
            }


            function f_tranferencia(){
          
             var cboDependencia  = document.all.cboDependencia.value;
             var cbo_OrgDependencia  = document.all.cbo_OrgDependencia.value;
             var txt_Clave  = document.all.txt_Clave.value;
             var cboArchivoIndicativo  = document.all.cboArchivoIndicativo.value;
             var txt_Asunto  = document.all.txt_Asunto.value;
             var cuerpo  = document.all.cuerpo.value;
             var cbo_Prioridad  = document.all.cbo_Prioridad.value;
             var cbo_revisadoPor  = document.all.cbo_revisadoPor.value;
             var cbo_firmadoPor  = document.all.cbo_firmadoPor.value;
              var txA_Obs  = "Observacion Falta";
                        
            
            if(cbo_firmadoPor != cbo_revisadoPor){
                  alert("Ingreso a diferente");
                var reporte = "REV_03";         
                if (window.XMLHttpRequest) {
                    ajaxEnviaRevisar = new XMLHttpRequest();
                } else {
                    ajaxEnviaRevisar = new ActiveXObject("Microsoft.XMLHTTP");
                }
                ajaxEnviaRevisar.onreadystatechange = funcionCallbackEnviaRevisar;
                var ruta = "<%= request.getContextPath()%>/gedad/firmardoc/I_PorRevisar_ajax.jsp?pasacache=" + new Date().getTime() +"&reporte=" + reporte+
                        "&cbo_OrgDependencia=" + cbo_OrgDependencia+
                        "&txt_Clave=" + txt_Clave+
                        "&cboArchivoIndicativo=" + cboArchivoIndicativo+
                        "&txt_Asunto=" + txt_Asunto+
                        "&cuerpo=" + cuerpo+
                        "&cbo_Prioridad=" + cbo_Prioridad+
                        "&cbo_revisadoPor=" + cbo_revisadoPor+
                        "&cbo_firmadoPor=" + cbo_firmadoPor+
                        "&txA_Obs=" + txA_Obs;
                ajaxEnviaRevisar.open("GET", ruta, true);
                ajaxEnviaRevisar.send(""); 
                
                   $('#miModalEnvio').modal('hide');
                   $('#miModalREVISAR').modal('hide');
                   f_listar(cboDependencia);
                   
                   var posTO = document.all.cbo_revisadoPor.options.selectedIndex;                
                  var des_to = document.all.cbo_revisadoPor.options[posTO].text; 
                   document.all.txh_alerta_revisa.value=des_to;
                  $('#miModalAlerta').modal({backdrop: 'static', keyboard: false});
               }
             }
             
             
             var ajaxEnviaRevisar = null;
             function funcionCallbackEnviaRevisar() {
                if (ajaxEnviaRevisar.readyState === 4 && ajaxEnviaRevisar.status === 200) {
                    document.all.ajaxEnviaRevisar.innerHTML = ajaxEnviaRevisar.responseText;                     
                }
            }
          




/*
 * 
 * ------------------------------------------------------------------02 DISTRIBUCION --------------------------------------------------------------------
 */           
            
            /**
             * Funcion(03).  VIENE DEL AJAX I_PorRevisar.ajax reporte:02 - Abre el modal de Distribucion
             * @param {type} cod_org_cab
             * @param {type} periodo
             * @param {type} cod_interno
             * @returns {undefined}
             */
            
            function f_openDistribucion(cod_org_cab, periodo, cod_interno) {
                                
                var verifica=document.formRevisar.txh_verifica.value;       
                $('#miModalDistribucion').modal({backdrop: 'static', keyboard: false});

            var ruta = ctx_path.concat("/gedad/firmardoc/I_PorFirmar_Distribucion_ajax.jsp?pasacache=" , 
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
                                {
                                    "scrollY": "200px",
                                    "scrollCollapse": true,
                                    "paging": false
                                }
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
         
         
           function f_AgregarDestinatarios(valor){  
               alert("agregara una nueva DISTRIBUCIÓN!...")
                //Variable que s envi al AJAX para agregar a los destinatario     
                    var v_tipo_organizacion=document.formRevisar.tipoOrg.value;
                    var v_destinatario=document.formRevisar.org.value;   
                 
                    var reporte = "DIST_02";
                        
                           if (window.XMLHttpRequest) {
                               ajaxDestinatario = new XMLHttpRequest();
                           } else {
                               ajaxDestinatario = new ActiveXObject("Microsoft.XMLHTTP");
                           }
                           ajaxDestinatario.onreadystatechange = funcionCallbackDestinatario;     
                                 
                           var ruta = "<%= request.getContextPath()%>/gedad/firmardoc/I_PorFirmar_Distribucion_ajax.jsp?pasacache=" + new Date().getTime() +"&reporte=" + reporte+"&v_tipo_organizacion=" + v_tipo_organizacion+"&v_destinatario=" + v_destinatario;                       
                           ajaxDestinatario.open("GET", ruta, true);
                           ajaxDestinatario.send("");   
                }

                        var ajaxDestinatario = null;
                       function funcionCallbackDestinatario() {                          
                           if (ajaxDestinatario.readyState === 4 && ajaxDestinatario.status === 200) {                                
                               document.all.modalDestinatario.innerHTML = ajaxDestinatario.responseText; 
                            //Retorna tabla Bootstrap y le da formato requerido a la tabla Distribucion
                            $(document).ready(function() { $('#distri').DataTable(
                                         {
                            "scrollY":        "200px",
                            "scrollCollapse": true,
                            "paging":         false
                            }    
                            ); } );                      
                             
                               
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
            var ruta = "<%= request.getContextPath()%>/gedad/firmardoc/I_PorFirmar_Distribucion_ajax.jsp?pasacache=" + new Date().getTime() +"&reporte=" + reporte+"&v_tipo_organizacion=" + v_tipo_organizacion+"&v_destinatario=" + v_destinatario;                       
            ajaxDestinatario.open("GET", ruta, true);
            ajaxDestinatario.send("");   
             }

            var ajaxDestinatario = null;
            function funcionCallbackDestinatario() {                          
            if (ajaxDestinatario.readyState === 4 && ajaxDestinatario.status === 200) {                                
               document.all.modalDestinatario.innerHTML = ajaxDestinatario.responseText;  
               //Retorna tabla Bootstrap y le da formato requerido a la tabla Distribucion
                     $(document).ready(function() { $('#distri').DataTable(
                                 
                 {
                            "scrollY":        "200px",
                            "scrollCollapse": true,
                            "paging":         false
                            }    
                
                    ); } );
                     
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
        
        function f_CapturaDestinarario(Nombre_dest,Grado_dest,Cargo_dest,valor4,Cod_organizacion,Tipo_Organizacion){
          
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
                var ruta = "<%= request.getContextPath()%>/gedad/firmardoc/I_PorFirmar_Distribucion_ajax.jsp?pasacache=" + new Date().getTime() +"&reporte=" + reporte+"&periodo="+periodo+"&cod_interno="+cod_interno+"&cod_organizacion="+Cod_organizacion;
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
 * ------------------------------------------------------------------03 Anexos --------------------------------------------------------------------
 */         
            
            /**
             * Funcion(08). Abre el Modal de Anexos
             * @returns {undefined}
             */
            function f_openAnexoVentana() {
                
                alert("Insertó un nuevo  Anexo de manera EXITOSA!!!");
                
                $('#miModalAnexo').modal({backdrop: 'static', keyboard: false});

                var periodo = document.formRevisar.txh_periodo_rev.value;
                var cod_interno = document.formRevisar.txh_cod_int_rev.value;
                
                var ruta = ctx_path.concat("/gedad/firmardoc/I_PorFirmar_Anexos_ajax.jsp?pasacache=",
                                            new Date().getTime(),
                                            "&periodo=",
                                            periodo,
                                            "&cod_interno=",
                                            cod_interno,
                                            "&reporte=", 
                                            OPC_MUESTRA_ANEXOS)
                                            
                    $("#modalAnexos").load(ruta, function(){
                 
                            $('#table_anexos').DataTable(
                                {
                                    "scrollY": "200px",
                                    "scrollCollapse": true,
                                    "paging": false
                                }
                            );
                    });
            }


 /* 
             * Funcion(12). Graba los  anexos 
             */

            function f_Grabar_Anexos() {   
            
            var accion_anexos=document.all.txh_accion_anexos.value; 
            var periodo_anexo = document.all.txh_perido_anexos.value;         
            var cod_int_anexos = document.all.txh_codinter_anexos.value;          
            var sec_anexos = document.all.txh_secuencia_anexos.value;       
                    
            var frm_anexos = $("#frm_anexos")[0];               
            
                if(accion_anexos=="insertar_anexos"){

                   frm_anexos.action = ctx_path.concat( "/capturaAnexos_RD?cod_interno="+cod_int_anexos+"&accion="+accion_anexos );
                   frm_anexos.submit();         
                   //Importante:::Funcion para que retorne la lista
                   f_openAnexoVentana(); 

                }else if(accion_anexos=="actualizar_anexos"){
                            alert("ingresososososo actualizr");          
                   frm_anexos.action = ctx_path.concat( "/capturaAnexos_RD?cod_interno="+cod_int_anexos+"&accion="+accion_anexos+"&periodo_anexo="+periodo_anexo+"&sec_anexos="+sec_anexos );
                   frm_anexos.submit();         
                   //Importante:::Funcion para que retorne la lista
                   f_openAnexoVentana(); 
                }

           
            }
                
           
            /* 
             * Funcion(09). Cierra en moal Disribucion, verificando que se señale el Original
             */
            function f_cerrar_moAnexos() {

                $('#miModalAnexo').modal('hide');

            }


            function f_cerrar_moAlerta() {

                $('#miModalAlerta').modal('hide');

            }
            
             function f_cerrar_moObs() {

                $('#miModalObs').modal('hide');

            }
            
            
            
            /* 
             * Funcion(10). Captura los datos de anexo para eliminar 
             */
            function f_CapturaAnexos(periodo, docinterno, secuencia, nombre_archivo) {
                alert("periodo" + periodo + "docinterno" + docinterno + "secuencia-" + secuencia + "nombre_archivo" + nombre_archivo);
                document.all.txh_perido_anexos.value = periodo;
                document.all.txh_codinter_anexos.value = docinterno;
                document.all.txh_secuencia_anexos.value = secuencia;
                document.all.txh_archivo_anexos.value = nombre_archivo;


            }
            /* 
             * Funcion(11). Muestra la Capa para añadir anexos 
             */
            function f_InsertarAnexos() {                
                document.all.txh_accion_anexos.value="insertar_anexos";
                mostrar("capa_add_anexos");
            }
            
            /*
             * Mostrar Anexos
             * @returns {undefined}
             */
            function f_MostraAnexos() {  
            
                  document.all.txh_accion_anexos.value="mostar_anexos";
                    if(document.all.txh_secuencia_anexos.value!=""){
                          
                       var txh_perido_anexos=document.all.txh_perido_anexos.value;
                       var txh_codinter_anexos=document.all.txh_codinter_anexos.value;
                       var txh_secuencia_anexos=document.all.txh_secuencia_anexos.value;
                       var txh_archivo_anexos=document.all.txh_archivo_anexos.value;
               
 alert("0000");
                        var reporte = "ANEX_03";

                        if (window.XMLHttpRequest) {
                            ajaxverAnexos = new XMLHttpRequest();
                        } else {
                            ajaxverAnexos = new ActiveXObject("Microsoft.XMLHTTP");
                        }
                        ajaxverAnexos.onreadystatechange = funcionCallbackVerAnexos;
                        var ruta = "<%= request.getContextPath()%>/gedad/revisardoc/I_PorRevisar_Anexos_ajax.jsp?pasacache=" + new Date().getTime() +
                                "&reporte=" + reporte+
                                "&txh_perido_anexos="+txh_perido_anexos+
                                "&txh_codinter_anexos="+txh_codinter_anexos+
                                "&txh_secuencia_anexos="+txh_secuencia_anexos+
                                "&txh_archivo_anexos="+txh_archivo_anexos;
                        ajaxverAnexos.open("GET", ruta, true);
                        ajaxverAnexos.send("");

          alert("v111111");
                                      
                        var ajaxverAnexos = null;
                                function funcionCallbackVerAnexos() {
                                    if (ajaxverAnexos.readyState === 4 && ajaxverAnexos.status === 200) {
                                        alert("va a abriii");
                                        document.all.modalMostarAnexos.innerHTML = ajaxverAnexos.responseText; 

                                    }
                                }

          $('#miModalVerAnexos').modal('show');
                    }else{
                     alert("Debe Selecionar el Archivo Adjunto!::");
                     }
             }
            
             /*
             * Actualiza Anexos 
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
             * Eliminar Anexos 
             * @returns {undefined}
             */
            function f_EliminarAnexos() {
                 document.all.txh_accion_anexos.value="eliminar_anexos";                
                 if(document.all.txh_secuencia_anexos.value!=""){
                    
                    
                    }else{
                     alert("Debe Selecionar el Archivo Adjunto!::")

                     }
                
            }

  /*
 * 
 * ------------------------------------------------------------------05 ENVIO DOCUMENTO --------------------------------------------------------------------
 */         
                

            /* 
             * Funcion(14). Funcion Abrir lo detalles del Envio
             */

            function f_terminar() {               
                $('#miModalEnvio').modal({backdrop: 'static', keyboard: false});
                $('#miModalDevolver').modal('hide');
                
                 var cuerpo  = document.all.cuerpo.value;
                 alert(cuerpo);
            }

 /* 
             * Funcion(15). Habilitar y desactivar botones
             */
            function f_habilitar(f_accion) {
               
               if(f_accion=='firmado_por'){
                  
                  var posTO = document.all.cbo_firmadoPor.options.selectedIndex;                
                  var des_to = document.all.cbo_firmadoPor.options[posTO].text; 
                  document.all.txt_firma_dig.value= des_to;  
                  document.location.href = "#ancla_revisa_arriba";
                  mostrar("div_firma_digital");
                  mostrar("div_revisado_por");
                      
                     
               }
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

            function f_DIS(tipo) {
                document.formRevisar.tipoOrg.value = tipo;
            }


            function f_listaanexo(codint, periodo, clase, secuencia) {
                $('#miModal').modal('show');
            }




        </script>

    </head>

    <body>
        <form id="formRevisar" name="formRevisar" method="post" action="">
            <input name="tipoOrg" type="hidden" value='G' />
            <!--Variables para Verificar si antes de retornar  al revisar oficio a seleccionado el Original -->
            <input name="txh_verifica" type="text"  value='aaaaaa' />
            <input name="txh_url_anexo" type="text"  />
            <input name="txh_accion_anexos" type="text"  />




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
                                                <a class="navbar-brand" href="#">FIRMAR DOCUMENTO </a>
                                            </div>                          

                                            <ul class="nav navbar-nav navbar-right">
                                                <li><a href="<%= request.getContextPath()%>/menu"><span class="glyphicon glyphicon-user"></span> Menu</a></li>
                                                <li><a href="#"><span class="glyphicon glyphicon-user"></span> Cambiar Clave</a></li>
                                                <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
                                            </ul>          

                                        </div>                       
                                    </nav>

                                </td>
                            </tr>    
                        </table>
                        <%-- TERMINO  CABECERA --%> 
                        <table width="100%">
                            <tr>
                                <td colspan="4">
                                    <div align="center">
                                        <table width="50%">
                                            <tr>
                                                <td width="25%">Dependencia:</td>
                                                <td width="5%">&nbsp;</td>
                                                <td width="100%">
                                                    <select name="cboDependencia" id="cboDependencia" onchange="f_listar(this.value)" class="selectpicker" data-style="btn-info"  data-live-search="true">
                                                        <option value="0000">--- Elija Opcion ---</option>
                                                        <lb:TagComboUsuarioNivelInferior></lb:TagComboUsuarioNivelInferior>
                                                        </select> 
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr height="5">
                                    <td width="5%">&nbsp;</td>
                                    <td width="20%">&nbsp;</td>
                                    <td width="70%">&nbsp;</td>
                                    <td width="5%">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td colspan="2"><div id="listado">&nbsp;</div></td>
                                    <td>&nbsp;</td>
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



                            <!-- Modal (02)::Modal Distribucion -->                        
                            <div class="modal fade" id="miModalDistribucion"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

                                <div class="modal-dialog " role="document">                                 
                                    <div class="modal-content">                                    
                                        <div class="modal-header"  style="background-color:rgb(222,97,94)">  
                                            <a href="javascript:f_cerrar_moDistribucion();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                                        </div>
                                        <div  id="modalDistribucion">                                        

                                        </div>


                                    </div>
                                </div>
                            </div>
                            <!--FIN MODAL Ventana Distribucion-->
                            
                            
                             <!-- Modal (02)::Modal Distribucion -->                        
                            <div class="modal fade" id="miModalVerAnexos"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

                                <div class="modal-dialog " role="document">                                 
                                    <div class="modal-content">                                    
                                        <div class="modal-header"  style="background-color:rgb(222,97,94)">  
                                            <a href="javascript:f_cerrar_moDistribucion();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                                        </div>
                                        <div  id="modalMostarAnexos">                                        

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
                                            <a href="javascript:f_cerrar_moAnexos();">  <p style="color:rgb(240, 235, 235);" align="center"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
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
                                                    <div id="div_firmado_por" >                                                    
                                                    <table>
                                                        <tr>
                                                            <td> <a href="javascript:f_clasificacion();"><img src="<%=request.getContextPath()%>/imagenes/icono/firmado_por.png" width="70px" height="60px" align="center" title="Eliga por quien sera firmado el documento.."/>SERÁ FIRMADO POR:</a></td>
                                                        </tr>
                                                         <tr>
                                                             <td>                                                     
                                                                <select name="cbo_firmadoPor" class="form-control" id="cbo_firmadoPor" onchange="f_habilitar('firmado_por')">
                                                                    <option value="000">--Elija Opcion--</option>
                                                                    <lb:TagFirmadoPor></lb:TagFirmadoPor>
                                                                </select>
                                                            </td>
                                                          </tr>
                                                        </table>                                            
                                                    </div>
                                                </td>                                                
                                                </tr>
                                               
                                                <tr>                                                                                        
                                                <td>                                                    
                                                    <div id="div_revisado_por" style="visibility: hidden">
                                                    <table>
                                                        <tr>
                                                            <td>                                                                   
                                                            <a href="javascript:f_clasificacion();"   ><img src="<%=request.getContextPath()%>/imagenes/icono/enviar.png" width="70px" height="60px" align="center" title="Eliga a quien sera enviado el docuemento para ser revisado.." />ENVIAR PARA SU REVISIÓN AL:</a>
                                                           </td>                                                       
                                                        </tr>
                                                        <tr>
                                                            <td>                                                       
                                                            <select name="cbo_revisadoPor" class="form-control" id="cbo_revisadoPor" onchange="f_cambio()">
                                                                <option value="000">--Elija Opcion--</option>
                                                            <lb:TagRevisadoPor></lb:TagRevisadoPor>
                                                            </select> 
                                                            </td>
                                                        </tr>
                                                    </table>                                            
                                                    </div> 
                                                </td>                                                
                                                </tr>
                                               <tr>
                                               <td>&nbsp;</td>
                                              </tr>
                                                <tr>
                                                    <td>
                                                        <button class="btn btn-info btn-info" style="width: 350px" type="button" onclick="javascript:f_tranferencia();"><b>ENVIAR</b></button>              
                                                    </td>
                                                </tr>
                                                   <tr>
                                                    <td>
                                                        <button class="btn btn-info btn-info" style="width: 350px" type="button" onclick="javascript:f_FirmaDigital();"><b>FIRMA DIGITAL</b></button>              
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
                                            <a href="javascript:f_cerrar_moAnexos();">  <p style="color:rgb(240, 235, 235);" align="center"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
                                        </div>
                                        <div  id="modalEnvio">  
                                            <table>
                                                                                   
                                             <tr>                                                                                        
                                                <td>
                                                    
                                                    <table>
                                                        <tr>
                                                            <td rowspan="2">    <a href="javascript:f_clasificacion();"   ><img src="<%=request.getContextPath()%>/imagenes/icono/devolver.png" width="70px" height="60px" align="center" title="Se devolvera el documento a quien lo formulo, añada observación .." /></a>                                                            
                                                            </td>                                                           
                                                        </tr>
                                                        <tr>                                                           
                                                            <td>
                                                     <div class="form-group">
                                                      
                                                         <textarea class="form-control rounded-0" id="txA_Obs" rows="8" cols="35" onkeyup="estadorechazado()" ></textarea>
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
                        
                      
                        
                        <!-- Modal (04)::Modal ALERTA-->                        
                            <div class="modal fade" id="miModalAlerta"  tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">

                                <div class="modal-dialog " role="document">                                 
                                    <div class="modal-content">                                    
                                        <div class="modal-header"  style="background-color:rgb(254, 0, 0)"> <span style="color:rgb(240, 235, 235);font-size: 22px" align="center" ><b>Envio Exitoso!!!!</b></span> 
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

                      

<tr>
                                                    <td>
                                                        <button class="btn btn-info btn-info" style="width: 350px" type="button" onclick="javascript:f_FirmaDigital();"><b>FIRMA DIGITAL</b></button>              
                                                    </td>
                                                </tr>

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