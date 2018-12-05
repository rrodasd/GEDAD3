<%@include file="cerrarSesion.jsp" %>
<%@page import="comun.ComboboxDAO"%>
<%@page import="comun.RevisaDocumentoDAO"%>
<%@page import="comun.DAOFactory"%>
<%@page import="sagde.bean.BeanArchivo"%>
<%@page import="sagde.bean.BeanUsuarioAD"%>
<%@page import="sagde.bean.BeanRevisarDocumento"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@taglib uri="/WEB-INF/tlds/libreria.tld" prefix="lb" %>
<%@page language="java" contentType="text/html;charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <title>Documentos en Borrador</title>

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

        <!--     FIN LIBRERIAS ESTANDAR   -->

        <%
            BeanUsuarioAD objBeanU = (BeanUsuarioAD) session.getAttribute("usuario");
            session.setAttribute("anexos", null);
            DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
            RevisaDocumentoDAO objRD = objDAOFactory.getRevisaDocumentoDAO();
        %>

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

        </style>

        <script type="text/javascript">
            $(document).ready(function () {
                $('#example').DataTable();
            });

            var ctx_path = "<%= request.getContextPath()%>";

            // Mostrar y Ocultar Capas
            function mostrar(nombreCapa) {
                document.getElementById(nombreCapa).style.visibility = "visible";
            }

            function ocultar(nombreCapa) {
                document.getElementById(nombreCapa).style.visibility = "hidden";
            }
            
            function f_visualizardoc(codint, clase, periodo, secuencia, r_observa) {
                document.all.area_obs.value = r_observa;
                $('#miModalObs').modal('show');
                $('#miModalREVISAR').modal({backdrop: 'static', keyboard: false});
                var ruta = ctx_path.concat("/gedad/borradordoc/I_Borrador_ajax.jsp?pasacache=", new Date().getTime(),
                        "&codint=", codint,
                        "&clase=", clase,
                        "&periodo=", periodo,
                        "&secuencia=", secuencia,
                        "&reporte=", OPC_MUESTRA_BORRADOR);
                $("#regmodal").load(ruta, function () {
                });
            }
            
            function f_cerrar_moObs() {
                $('#miModalObs').modal('hide');
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
            <!--Fin Variables para Cargar el "modalREVISAR" -->

            <%-- INICIOOOOOO  CABECERA --%>   
            <table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" style="background-color:#D4FD89">
                <tr>
                    <td height="90" align="center" valign="middle" bgcolor="#B7BCBF"  background="<%= request.getContextPath()%>/imagenes/fondos/fondo_cabecera.fw.png"  >
                        <table  width="100%" border="0" cellspacing="0" cellpadding="0">
                            <tr >                               
                                <td align="center" valign="middle">                                  
                                    <h2>
                                        <p style="color:rgb(206, 239, 100);"><b>GESTIÓN DE ELECTRÓNICA DE DOCUMENTOS Y ARCHIVO DIGITAL</b></p>
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
                                                <a class="navbar-brand" href="#"> **DOCUMENTOS EN BORRADOR **</a>
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
                        <table width="100%" height="200px">
                            <tr>
                                <td rowspan="2" VALIGN="TOP" height="600px" style="background-color: #cdcec8" >
                                    <div align="left" >
                                        <table width="50%" align="left" >
                                            <tr >                                             
                                                <td width="100%"  >
                                                    <select name="cboDependencia" id="cboDependencia" onchange="f_listar(this.value)" class="selectpicker" data-style="btn-info"  data-live-search="true">
                                                        <option value="0000">--- Elija Opcion ---</option>
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
                                    <td VALIGN="TOP"><div id="listado">
                                        <%
                                            ArrayList listaPorRevisar = (ArrayList) objRD.ObtenerListaDocumentosXRevisar("E", objBeanU.getVUSUARIO_CODIGO(), objBeanU.getCUSUARIO_COD_ORG());
                                        %>  
                                        <table class="display" width="90%" border="1" id="example">
                                            <thead>
                                                <tr style="background-color:#B0B199">
                                                    <th><div align="center">AÑO</div></th>
                                                    <th><div align="center">FECHA_REG</div></th>
                                                    <th><div align="center">CODIGO GEDAD</div></th>
                                                    <th><div align="center">REMITENTE</div></th>
                                                    <th><div align="center">CLASE</div></th>
                                                    <th><div align="center">NRO. DOC</div></th>
                                                    <th><div align="center">FECHA DOC</div></th>
                                                    <th><div align="center">ASUNTO_DEL_DOCUMENTO</div></th>
                                                    <th><div align="center">DESTINO</div></th>
                                                    <th><div align="center">PRIORIDAD</div></th>
                                                    <th><div align="center">VER DOC</div></th>
                                                    <th><div align="center">VER ANEXOS</div></th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <%
                                                    for (int i = 0; i < listaPorRevisar.size(); i++) {
                                                        BeanRevisarDocumento objBeanD = (BeanRevisarDocumento) listaPorRevisar.get(i);
                                                        if (objBeanD.getVDOCUMENTO_ASUNTO() == null) {
                                                            objBeanD.setVDOCUMENTO_ASUNTO("");
                                                        }
                                                        if (objBeanD.getDESTINATARIO() == null) {
                                                            objBeanD.setDESTINATARIO("");
                                                        }
                                                        if (objBeanD.getVHDOCUMENTO_OBSERVACION() == null) {
                                                            objBeanD.setVHDOCUMENTO_OBSERVACION("");
                                                        }
                                                %>
                                                <tr>
                                                    <td><div align="center"><%=objBeanD.getCDOCUMENTO_PERIODO()%></div></td>
                                                    <td><div align="center"><%=objBeanD.getDHDOCUMENTO_FECH_ESTADO()%></div></td>
                                                    <td bgcolor="#CCD272" ><div align="center"><%=objBeanD.getCDOCUMENTO_COD_DOC_INT()%></div></td>
                                                    <td><div align="center"><%=objBeanD.getVHDOCUMENTO_COD_USU_ENV()%></div></td>
                                                    <td><div align="center"><%=objBeanD.getVCLASE_NOM_CORTO()%></div></td>
                                                    <td><div align="center"><%=objBeanD.getCDOCUMENTO_COD_DOC_INT()%></div></td>
                                                    <td><div align="center"><%=objBeanD.getDHDOCUMENTO_FECH_ESTADO()%></div></td>
                                                    <td><%=objBeanD.getVDOCUMENTO_ASUNTO()%></td>
                                                    <td><div align="center"><%=objBeanD.getDESTINATARIO()%></div></td>
                                                    <td><div align="center"><%=objBeanD.getVHDOCUMENTO_OBSERVACION()%></div></td>
                                                    <td><div align="center"><a href="javascript:f_visualizardoc('<%=objBeanD.getCDOCUMENTO_COD_DOC_INT()%>','<%=objBeanD.getCDOCUMENTO_CLASE()%>','<%=objBeanD.getCDOCUMENTO_PERIODO()%>','<%=objBeanD.getCHDOCUMENTO_SECUENCIA()%>','<%=objBeanD.getVHDOCUMENTO_OBSERVACION()%>');" ><img src="<%= request.getContextPath()%>/imagenes/icono/verdoc.png" height="25px" width="25px" /></a></div></td>
                                                    <td><div align="center"><a href="javascript:f_verAnexos('<%=objBeanD.getCDOCUMENTO_PERIODO()%>','<%=objBeanD.getCDOCUMENTO_COD_DOC_INT()%>');"><img src="<%= request.getContextPath()%>/imagenes/icono/anexos.fw.png" height="25px" width="25px" alt="VerAnexos" /></a></div></td>
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
                                    <div class="modal-header"  style="background-color:rgb(222,97,94)">  
                                        <a href="javascript:f_cerrar_moDistribucion();">  <p style="color:rgb(240, 235, 235);" align="right"><b><i>RETORNAR  </i> </b><span class="glyphicon glyphicon-arrow-left"></span></p>  </a>                                      
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
                                                        <div id="div_revisado_por" >
                                                            <table>
                                                                <tr>
                                                                    <td>                                                                   
                                                                        <a href="javascript:f_clasificacion();"   ><img src="<%=request.getContextPath()%>/imagenes/icono/enviar.png" width="70px" height="60px" align="center" title="Eliga a quien sera enviado el docuemento para ser revisado.." />ENVIAR PARA SU REVISIÓN AL:</a>
                                                                </td>                                                       
                                                            </tr>
                                                            <tr>
                                                                <td>                                                       
                                                                    <select name="cbo_revisadoPor" class="form-control" id="cbo_revisadoPor" onchange="f_habilitar('revisado_por')">
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
                                                    <td>
                                                        <div id="div_observacion_enviar" style="visibility: hidden">
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
                                                    <button class="btn btn-info btn-info" style="width: 350px" type="button" onclick="javascript:f_tranferencia();"><b>ENVIAR</b></button>              
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