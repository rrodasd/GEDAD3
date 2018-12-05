<%@taglib uri="/WEB-INF/tlds/libreria.tld" prefix="lb" %>
<%@page import="java.util.Base64.Decoder"%>
<%@page import="java.util.Base64"%>
<%@page import="java.util.Collection"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.io.File"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.*"%> 
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="comun.DAOFactory"%>
<%@page import="comun.ComboboxDAO"%>
<%@page import="comun.FormularDocumentoDAO"%>
<%@page import="comun.RevisaDocumentoDAO"%>
<%@page import="sagde.bean.BeanDistribucion"%>
<%@page import="sagde.bean.BeanReferencia"%>
<%@page import="sagde.bean.BeanArchivo"%>
<%@page import="sagde.bean.BeanRevisarDocumento"%>
<%@page import="sagde.bean.BeanUsuarioAD"%>
<%@page import="sagde.bean.BeanAnexo"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js" ></script>
<%

    String hora = (String) request.getParameter("pasacache");
    String reporte = (String) request.getParameter("reporte");
    String dependencia = (String) request.getParameter("dependencia");
    String clase = (String) request.getParameter("clase");
    
    DAOFactory objDF = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
    RevisaDocumentoDAO objRD = objDF.getRevisaDocumentoDAO();
    ComboboxDAO objCombobox = objDF.getComboboxDAO();

    session = request.getSession(true);
    BeanUsuarioAD objbean = (BeanUsuarioAD) session.getAttribute("usuario");

    ArrayList ListarDestinatario = null;
    ArrayList ListaReferencia = null;
    ArrayList ListaAnexo = null;


    /*
    BOR_01. RETORNA LISTA, SEGUN VALOR DE COMBO ORGANIZACION
    BOR_02. RETORNA UN DOCUMENTO DE LA LISTA BORRADOR
     */
    if (reporte.equals("BOR_01")) {
        ArrayList listaPorRevisar = (ArrayList) objRD.ObtenerListaDocumentosXRevisar("E", objbean.getVUSUARIO_CODIGO(), dependencia);
%>
<table class="display" width="90%" border="1"  id="example">
    <thead >
        <tr style="background-color:#ADADAD">

            <th><div align="center">FECHA</div></th>
            <th><div align="center">ORGANIZ</div></th>
            <th><div align="center">CLASE</div></th>
            <th><div align="center">N°</div></th>
            <th><div align="center">ASUNTO</div></th>
            <th><div align="center">DESTINO</div></th>
            <th><div align="center">OBSERVACION</div></th>
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
<%} /*
    *Formulario Ajax (02). Mostrará el Oficio por revisar cargado con los campos------------------------------------------------------------------------>
 */ else if (reporte.equals("BOR_02")) {

    if (clase.equals("0001")) {

        String codint = (String) request.getParameter("codint");
        String periodo = (String) request.getParameter("periodo");
System.out.println("codint x"+codint+"x");
System.out.println("periodo x"+periodo+"x");
        //String secuencia = (String) request.getParameter("secuencia");

        //-->1.Procedimiento para llamar a la lista de documentos por Revisar 
        BeanRevisarDocumento objBeanRD = objRD.obtenerDocXRevisar(periodo, codint, objbean.getVUSUARIO_CODIGO());

        //-->2. Traer el Codigo de la Organizacion de la cabecera para devolver al JSP para carbar el lb
        String cod_org_cabecera = objBeanRD.getCDOCUMENTO_COD_ORG_DEP();
        if (cod_org_cabecera != null) {
            session.setAttribute("cod_org_cabecera", cod_org_cabecera);
        }

        //-->3. Traer la distribucion o DESTINATARIOS guardado por el formular para ser REVISADO
        ListarDestinatario = (ArrayList) objRD.RD_ObtenerDistribucion(periodo, codint);
        if (ListarDestinatario != null) {
            session.setAttribute("ListarDestinatario", ListarDestinatario);
        }
        periodo = objBeanRD.getCDOCUMENTO_PERIODO();
        //String cod_int = objBeanRD.getCDOCUMENTO_COD_DOC_INT();

        // -->4. Enviar a session todo el Bean
        session.setAttribute("beanRevisarDoc", objBeanRD);

        ListaReferencia = (ArrayList) objRD.Listareferencia(periodo, codint);
        //System.out.println("cuantos  ListaReferencia-->" + ListaReferencia.size() + "<--");
        if (ListaReferencia != null) {
            session.setAttribute("ListaReferencia", ListaReferencia);
        }

        ListaAnexo = (ArrayList) objRD.obtenerFullAnexosXDocumento(periodo, codint);
        if (ListaAnexo != null) {
            session.setAttribute("anexos", ListaAnexo);
        }
%>
<input name="txh_periodo_rev" type="hidden" value="<%=periodo%>"/>
<input name="txh_cod_int_rev" type="hidden" value="<%=codint%>"/>
<a name="ancla_revisa_arriba"></a>
<table width="100%" border="0">
    <tr>
        <td width="100%" bgcolor="#FFFFFF">
            <table width="100%" cellspacing="0" cellpadding="0" border="0">
                <tr>
                    <td width="10%"><div align="center"><img src="<%= request.getContextPath()%>/imagenes/escudos/escudo.png" width="70px" height="60px" /></div></td>
                    <td width="10%" bgcolor="#E03032"><span style="color:rgb(255,255,255);"><div class="EstiloOF">&nbsp;PERÚ</div></span></td>
                    <td width="15%" bgcolor="#2F3130"><span style="color:rgb(255,255,255);"><div class="EstiloOF">&nbsp;Ministerio</div><div class="EstiloOF">&nbsp;de Defensa</div></span></td>
                    <td width="15%" bgcolor="#565656"><span style="color:rgb(255,255,255);"><div class="EstiloOF">&nbsp;Ejército</div><div class="EstiloOF">&nbsp;del Perú</div></span></td>
                    <td width="28%" bgcolor="#ADADAD" >&nbsp;                              
                        <select name="cbo_OrgDependencia" id="cbo_OrgDependencia" class="form-controlOF" style="background-color: #ADADAD"   >
                            <lb:TagComboOrganizacionCabecera></lb:TagComboOrganizacionCabecera></select>&nbsp;                                 
                        </td>                             
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table width="100%" border="0" cellspacing="0">
        <tr>
            <td colspan="6"><div align="center" class="EstiloOF"><input name="txt_NombreAnio" id="txt_NombreAnio" type="text" size="80" style="border:0px; text-align: right;" value="<lb:TagDescripcionPeriodoActual></lb:TagDescripcionPeriodoActual>" readonly="true" /></div></td>
        </tr>
        <tr>
            <td colspan="6" >
                <div align="right" id="div_firma_digital" style="visibility: hidden">    
                    <table>
                        <tr>
                            <td>
                                <img src="<%=request.getContextPath()%>/imagenes/icono/firma_digital.jpg" width="100px" height="60px" align="center" />
                        </td>
                        <td style="background: #808965">
                            <input name="txt_firma_dig" class="form-controlOF" type="text" readonly="true" size="45" />
                        </td>
                    </tr>
                </table>
            </div>
        </td>
    </tr>
    <tr>
        <td colspan="6">
            <div align="right" class="EstiloOF">
                <input name="txt_Guarnicion" id="txt_Guarnicion" type="text" style="border:0px; text-align: right;" value="<lb:TagDescripcionGuarnicion></lb:TagDescripcionGuarnicion>" readonly="true" />,&nbsp;
                <%    Calendar fecha = Calendar.getInstance();
                    String Meses[] = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
                    String fecha_st = fecha.get(Calendar.DATE) + " de " + Meses[fecha.get(Calendar.MONTH)] + " del " + fecha.get(Calendar.YEAR);%>
                <input name="txt_Fecha" id="txt_Fecha" type="text"  size="25" style="border:0px; text-align: left;" value="<%=fecha_st%>" readonly="true" />
            </div>
        </td>
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
        <td width="17"><input type="hidden" name="txt_saltodistribucion" class="Estilo10" /></td>
        <td colspan="2">
            <div align="left" class="EstiloOF">Oficio N°</div></td>
        <td colspan="3">
            <table width="100%">
                <tr>
                    <td width="10%"><input name="txt_Numero" type="text" class="form-control" size="3" readonly="false" /></td>
                    <td width="20%"><input name="txt_Clave" type="text" class="form-controlOF" readonly="true" value="<%=objBeanRD.getVDOCUMENTO_CLAVE_INDIC()%>" size="10"/></td>
                    <td width="70%"><select name="cboArchivoIndicativo" class="form-controlOF">
                            <%
                                Iterator iteAI = objCombobox.obtenerArchivoIndicativo().iterator();
                                while (iteAI.hasNext()) {
                                    BeanArchivo objBeanA = (BeanArchivo) iteAI.next();
                                    String seleccion = (objBeanA.getCARCHIVO_CODIGO().equals(objBeanRD.getCDOCUMENTO_ARCHIVO_INDIC())) ? "selected" : "";
                                    out.println("<option value=" + objBeanA.getCARCHIVO_CODIGO() + " " + seleccion + ">" + objBeanA.getCARCHIVO_CODIGO() + " " + objBeanA.getVARCHIVO_NOMBRE() + "</option>");
                                }
                            %>
                        </select>
                    </td>
                </tr>
            </table>		                                  
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td width="49"><div align="left" class="EstiloOF">Se&ntilde;or</div></td>
        <td width="8"><div align="left" class="EstiloOF">:</div></td>
        <td colspan="3">
            <div align="left" class="Estilo10">
                <label>
                    <input name="txt_Grado" class="form-controlOF" type="text" readonly="true" value="<%=objBeanRD.getVDISTRIBUCION_GRADO()%>"/>
                </label>
                <input name="txt_Cargo" class="form-controlOF" type="text" readonly="true" value="<%=objBeanRD.getVDISTRIBUCION_CARGO()%>"/>
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
                    <td><button type="button" class="btn btn-primary btn-sm" style="width: 100%" onclick="javascript:f_openDistribucion('<%=objBeanRD.getCDOCUMENTO_COD_ORG_DEP()%>', '<%=objBeanRD.getCDOCUMENTO_PERIODO()%>', '<%=objBeanRD.getCDOCUMENTO_COD_DOC_INT()%>');" >AGREGAR DISTRIBUCIÓN</button></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td valign="top"><div align="left" class="EstiloOF">Asunto</div></td>
        <td valign="top"><div align="left" class="EstiloOF">:</div></td>
        <td colspan="3"><textarea name="txt_Asunto" cols="100%" class="form-controlOF" type="text"><%=objBeanRD.getVDOCUMENTO_ASUNTO()%></textarea></td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td valign="top"><div align="left" class="EstiloOF">Ref.</div></td>
        <td valign="top"><div align="left" class="EstiloOF">:</div></td>
        <td colspan="3"><label>
                <div id="pinta_ref">
                    <%
                        if (ListaReferencia != null) {
                            for (int i = 0; i < ListaReferencia.size(); i++) {
                                BeanReferencia objBeanD = (BeanReferencia) ListaReferencia.get(i);

                    %>
                    <%=objBeanD.getORDEN_REF()%>&nbsp;<%=objBeanD.getVCLASE_NOM_CORTO()%>&nbsp;Nº<%=objBeanD.getCDOCUMENTO_NRO_ORDEN()%>&nbsp;<%=objBeanD.getVDOCUMENTO_CLAVE_INDIC()%>&nbsp;del&nbsp;<%=objBeanD.getFECHA_DOC_ORIGEN()%><br>
                    <%}
                        }
                    %>
                </div>
                <table>
                    <tr>
                        <td><button type="button" class="btn btn-primary btn-sm" style="width: 100%" onclick="javascript:f_openReferencia('<%=objBeanRD.getCDOCUMENTO_PERIODO()%>', '<%=objBeanRD.getCDOCUMENTO_COD_DOC_INT()%>');" >AGREGAR REFERENCIA</button></td>
                        <td><input type="hidden" name="txt_saltoReferencia" /></td>
                    </tr>
                </table>
            </label>
        </td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td height="216" colspan="5">
            <table width="100%" height="212" border="0">
                <tr>                        
                    <td width="100%">
                        <div align="justify">
                            <textarea name="cuerpo" rows="20" id="cuerpo" class="form-controlOF"><%=objBeanRD.getLCDOCUMENTO_CUERPO_DOC()%></textarea>
                            <script>CKEDITOR.replace('cuerpo');
                                $(document).ready(function () {

                                    $.fn.modal.Constructor.prototype.enforceFocus = function () {
                                        modal_this = this
                                        $(document).on('#regmodal', function (e) {
                                            if (modal_this.$element[0] !== e.target && !modal_this.$element.has(e.target).length
                                                    // add whatever conditions you need here:
                                                    &&
                                                    !$(e.target.parentNode).hasClass('cke_dialog_ui_input_select') && !$(e.target.parentNode).hasClass('cke_dialog_ui_input_text')) {
                                                modal_this.$element.focus()
                                            }
                                        })
                                    };

                                });

                            </script>
                        </div>
                    </td>
                </tr>
            </table></td>
    </tr>                
    <tr>
        <td width="49">&nbsp;</td>
        <td width="49">&nbsp;</td>
        <td width="100">&nbsp;</td>
        <td width="400">&nbsp;</td>
        <td ><div align="rigth" class="EstiloOF">Dios guarde a Ud.</div></td>
        <td>&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="3"><div align="left" class="EstiloOF">DISTRIBUCION:</div></td>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td>&nbsp;</td>
        <td colspan="5">
            <div id="AjaxPieDestinatario">
                <table border="0" class="EstiloOF">
                    <%
                        for (int i = 0; i < ListarDestinatario.size(); i++) {
                            BeanDistribucion objBeanD = (BeanDistribucion) ListarDestinatario.get(i);
                            String org_sin_espacio = objBeanD.getCodigoOrganizacion().replaceAll("\\s", "");
                            String bean_sin_espacio = objBeanRD.getCDISTRIBUCION_COD_ORG().replaceAll("\\s", "");

                            if (org_sin_espacio.equals(bean_sin_espacio)) {%>
                    <tr>
                        <td>-&nbsp;<%=objBeanD.getDescOrganizacion()%>&nbsp;..........&nbsp;</td>
                        <td>01</td>
                    </tr>  
                    <%}
                        }
                    %>
                    <%
                        for (int i = 0; i < ListarDestinatario.size(); i++) {
                            BeanDistribucion objBeanD = (BeanDistribucion) ListarDestinatario.get(i);
                            String org_sin_espacio = objBeanD.getCodigoOrganizacion().replaceAll("\\s", "");
                            String bean_sin_espacio = objBeanRD.getCDISTRIBUCION_COD_ORG().replaceAll("\\s", "");
                            if (!org_sin_espacio.equals(bean_sin_espacio)) {%>
                    <tr>
                        <td>-&nbsp;<%=objBeanD.getDescOrganizacion()%>&nbsp;..........&nbsp;</td>
                        <td>01 (C'Inf)</td>
                    </tr>
                    <%}
                        }
                    %>
                </table>  
            </div>
        </td>
    </tr>
    <!-- anexos -->				
    <tr>
        <td>&nbsp;</td>
        <td colspan="2"><button type="button" class="btn btn-info btn-sm" style="width: 100%" onclick="javascript:f_openAnexoVentana('<%=objBeanRD.getCDOCUMENTO_PERIODO()%>', '<%=objBeanRD.getCDOCUMENTO_COD_DOC_INT()%>');" >AGREGAR ANEXOS</button></td>
        <td colspan="3">&nbsp;</td>
    </tr>
    <!-- terminooooooo anexos -->
    <tr>
        <td>&nbsp;</td>
        <td colspan="5">
            <div id="listaAnexos">
                <!-- AQUI VA LA LISTA DE ANEXOS -->
                <%
                    if (session.getAttribute("anexos") != null) {%>
                <table border="0" width="100%">
                    <tr class="EstiloOF">
                        <td><u>ANEXOS:</u><br>
                            <table  width="100%" >
                                <tbody>
                                    <%
                                        for (int i = 0; i < ListaAnexo.size(); i++) {
                                            BeanAnexo objBeanA = (BeanAnexo) ListaAnexo.get(i);
                                    %>
                                    <tr>
                                        <td>-</td>
                                        <td><div align="left">
                                                <a href="javascript:f_verAnexo('<%=objBeanA.getVANEXO_TOKEN()%>','<%=objBeanA.getVANEXO_NOMBRE()%>');">	
                                                    <%=objBeanA.getVANEXO_NOMBRE()%>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
                        </td>
                    </tr>
                </table>
                <% }%> 	
                <!--  FIN LISTA DE ANEXOS -->	

            </div></td>
    </tr>

    <tr>
        <td colspan="6">    
            <table>
                <tr>
                    <td style="width: 70%">
                        <input type="button" class="btn btn-success form-control" onclick="javascript:f_terminar('<%=objBeanRD.getVFIRMA_COD_USUARIO()%>', '<%=objbean.getVUSUARIO_CODIGO()%>');" value="ENVIAR DOCUMENTO" />
                    </td>
                    <td>
                        <input type="button" class="btn btn-warning form-control" onclick="javascript:f_Borrador();" value="BORRADOR">
                    </td>
                    <td>
                        <input type="button" class="btn btn-danger form-control" onclick="javascript:f_Abredevolver();" value="DEVOLVER DOCUMENTO">
                    </td>
                </tr>
            </table>

        </td>
    </tr>
    <tr>
        <td colspan="6" height="50px">        
            &nbsp;
        </td>
    </tr>
</table>
<%
    }

} else if (reporte.equals("REV_03")) {
    //System.out.println("Ingreso al Ajax para Enviar a revisar............");

    String accion_enviar = request.getParameter("accion_enviar");

    DAOFactory objDaoFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
    RevisaDocumentoDAO objRevisaDocumento = objDaoFactory.getRevisaDocumentoDAO();

    //-->1. Obtener Informacion del BeanRevisar
    BeanRevisarDocumento beanrevisar = (BeanRevisarDocumento) session.getAttribute("beanRevisarDoc");

    String periodo = beanrevisar.getCDOCUMENTO_PERIODO();
    String codigoDocumentoInterno = beanrevisar.getCDOCUMENTO_COD_DOC_INT();
    String claseDocumento = beanrevisar.getCDOCUMENTO_CLASE();
    String clasificacion = beanrevisar.getCDOCUMENTO_CLASIFICACION();
    String codigoUsuario = (String) ((BeanUsuarioAD) (session.getAttribute("usuario"))).getVUSUARIO_CODIGO();
    String secuencia = beanrevisar.getCHDOCUMENTO_SECUENCIA();
    String guarnicion = beanrevisar.getVDOCUMENTO_GUARNICION();
    /*
    System.out.println("----------------------- Datos obtenido del BeanRevisar-------------------------------------------");
    System.out.println("-1.Periodo--" + periodo + "\n" + "-2.codigoDocumentoInterno-" + codigoDocumentoInterno + "\n" + "-3.claseDocumento-" + claseDocumento + "\n"
            + "-4.clasificacion-" + clasificacion + "\n" + "-5.codigoUsuario-" + codigoUsuario + "\n" + "-6.secuencia-" + secuencia + "\n" + "-7.guarnicion-" + guarnicion);
    System.out.println("----------------------- FIN DE Datos obtenido del BeanRevisar--------------------------------------");
     */
    //-->2. Obtener Parametros de documento enviados desde el Ajax   		
    String orgDependencia = request.getParameter("cbo_OrgDependencia");
    String claveIndicativo = request.getParameter("txt_Clave");
    String archivoIndicativo = request.getParameter("cboArchivoIndicativo");

    Decoder decoder = Base64.getDecoder();
    byte[] asuntoByte = decoder.decode(request.getParameter("txt_Asunto"));
    String asunto = new String(asuntoByte);

    String cuerpo = request.getParameter("txt_cuerpo");

    String cuerpoDocumento = new String(decoder.decode(new String(decoder.decode(cuerpo))));

    // String cuerpoDocumento = request.getParameter("cuerpo");
    String prioridad = request.getParameter("cbo_Prioridad");
    String revisadopor = request.getParameter("cbo_revisadoPor");
    String firmadopor = request.getParameter("cbo_firmadoPor");

    byte[] obsByte = decoder.decode(request.getParameter("txA_Obs_Enviar"));
    String observacion = new String(obsByte);
    //String observacion=request.getParameter("txA_Obs_Enviar"); 

    /*
    System.out.println("----------------------- Datos Capturados del formulario al Revisar ajax-------------------------------------------");
    System.out.println("1.-orgDependencia--" + orgDependencia + "\n" + "2.-claveIndicativo-" + claveIndicativo + "\n" + "3.-archivoIndicativo-" + archivoIndicativo + "\n"
            + "4.-asunto-" + asunto + "\n" + "5.-cuerpoDocumento-" + cuerpoDocumento + "\n" + "6.-prioridad-" + prioridad + "\n" + "7.-revisadopor-" + revisadopor
            + "\n" + "8.-firmadopor-" + firmadopor + "\n" + "9.-observacion-" + observacion + "\n" + "10.-accion_enviar-" + accion_enviar);
    System.out.println("----------------------- FIN Capturados al Revisar--------------------------------------");
     */
    //-->3 Pasar a un Bean para ser llevado al Oracle
    //Bean para actualizar la revision del documento
    BeanRevisarDocumento beanrevisarDocumento = new BeanRevisarDocumento();
    //Siete(07 )datos obtenidos de la session BeanRevisarDocuemnto
    beanrevisarDocumento.setCDOCUMENTO_PERIODO(periodo);
    beanrevisarDocumento.setCDOCUMENTO_COD_DOC_INT(codigoDocumentoInterno);
    beanrevisarDocumento.setCDOCUMENTO_CLASE(claseDocumento);
    beanrevisarDocumento.setCDOCUMENTO_CLASIFICACION(clasificacion);
    beanrevisarDocumento.setVDOCUMENTO_USUARIO_ENV(codigoUsuario);
    beanrevisarDocumento.setCHDOCUMENTO_SECUENCIA(secuencia);
    beanrevisarDocumento.setVDOCUMENTO_GUARNICION(guarnicion);

    //Noeve(09)+ UNO(01)tipo accion --datos obtenidos de la session BeanRevisarDocuemnto
    beanrevisarDocumento.setCDOCUMENTO_COD_ORG_DEP(orgDependencia);
    beanrevisarDocumento.setVDOCUMENTO_CLAVE_INDIC(claveIndicativo);
    beanrevisarDocumento.setCDOCUMENTO_ARCHIVO_INDIC(archivoIndicativo);
    beanrevisarDocumento.setVDOCUMENTO_ASUNTO(asunto);
    beanrevisarDocumento.setLCDOCUMENTO_CUERPO_DOC(cuerpoDocumento);
    beanrevisarDocumento.setCDOCUMENTO_PRIORIDAD(prioridad);
    beanrevisarDocumento.setVDOCUMENTO_USUARIO_REVISA(revisadopor);
    beanrevisarDocumento.setVDOCUMENTO_USUARIO_FIRMA(firmadopor);
    beanrevisarDocumento.setVHDOCUMENTO_OBSERVACION(observacion);
    beanrevisarDocumento.setTipoAccion(accion_enviar);

    Collection referencias = (Collection) session.getAttribute("ListaReferencia");
    Collection distribuciones = (Collection) session.getAttribute("ListarDestinatario");/*
    System.out.println("----------------------- Distribucion------------------------------------------");
    System.out.println("distribuciones" + distribuciones.size());
    System.out.println("----------------------- Referencia------------------------------------------");
    System.out.println("referencias" + referencias.size());*/

    try {
        objRevisaDocumento.EnviarRevisarDocumento(beanrevisarDocumento, referencias, distribuciones);

    } catch (SQLException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }

} else if (reporte.equals("REV_04")) {
    //System.out.println("Ingreso al Ajax para rechazarrrrr............");

    String accion_enviar = request.getParameter("accion_enviar");

    DAOFactory objDaoFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
    RevisaDocumentoDAO objRevisaDocumento = objDaoFactory.getRevisaDocumentoDAO();

    //-->1. Obtener Informacion del BeanRevisar
    BeanRevisarDocumento beanrevisar = (BeanRevisarDocumento) session.getAttribute("beanRevisarDoc");

    String periodo = beanrevisar.getCDOCUMENTO_PERIODO();
    String codigoDocumentoInterno = beanrevisar.getCDOCUMENTO_COD_DOC_INT();
    String claseDocumento = beanrevisar.getCDOCUMENTO_CLASE();
    String clasificacion = beanrevisar.getCDOCUMENTO_CLASIFICACION();
    String codigoUsuario = (String) ((BeanUsuarioAD) (session.getAttribute("usuario"))).getVUSUARIO_CODIGO();
    String secuencia = beanrevisar.getCHDOCUMENTO_SECUENCIA();
    String guarnicion = beanrevisar.getVDOCUMENTO_GUARNICION();
    String revisadopor = beanrevisar.getVDOCUMENTO_USUARIO_ENV();
    String firmadopor = beanrevisar.getVFIRMA_COD_USUARIO();

    /*
    System.out.println("----------------------- Datos obtenido del BeanRevisar-------------------------------------------");
    System.out.println("-1.Periodo--" + periodo + "\n" + "-2.codigoDocumentoInterno-" + codigoDocumentoInterno + "\n" + "-3.claseDocumento-" + claseDocumento + "\n"
            + "-4.clasificacion-" + clasificacion + "\n" + "-5.codigoUsuario-" + codigoUsuario + "\n" + "-6.secuencia-" + secuencia + "\n" + "-7.guarnicion-" + guarnicion);
    System.out.println("----------------------- FIN DE Datos obtenido del BeanRevisar--------------------------------------");
     */
    //-->2. Obtener Parametros de documento enviados desde el Ajax   		
    String orgDependencia = request.getParameter("cbo_OrgDependencia");
    String claveIndicativo = request.getParameter("txt_Clave");
    String archivoIndicativo = request.getParameter("cboArchivoIndicativo");

    Decoder decoder = Base64.getDecoder();
    byte[] asuntoByte = decoder.decode(request.getParameter("txt_Asunto"));
    String asunto = new String(asuntoByte);

    String cuerpo = request.getParameter("txt_cuerpo");

    String cuerpoDocumento = new String(decoder.decode(new String(decoder.decode(cuerpo))));

    // String cuerpoDocumento = request.getParameter("cuerpo");
    String prioridad = request.getParameter("cbo_Prioridad");
    // String revisadopor=request.getParameter("cbo_revisadoPor");
    //String firmadopor=request.getParameter("cbo_firmadoPor");

    byte[] obsByte = decoder.decode(request.getParameter("txA_Obs_Enviar"));
    String observacion = new String(obsByte);
    //String observacion=request.getParameter("txA_Obs_Enviar"); 

    /*System.out.println("----------------------- Datos Capturados del formulario al Revisar ajax-------------------------------------------");
    System.out.println("1.-orgDependencia--" + orgDependencia + "\n" + "2.-claveIndicativo-" + claveIndicativo + "\n" + "3.-archivoIndicativo-" + archivoIndicativo + "\n"
            + "4.-asunto-" + asunto + "\n" + "5.-cuerpoDocumento-" + cuerpoDocumento + "\n" + "6.-prioridad-" + prioridad + "\n" + "7.-revisadopor-" + revisadopor
            + "\n" + "8.-firmadopor-" + firmadopor + "\n" + "9.-observacion-" + observacion + "\n" + "10.-accion_enviar-" + accion_enviar);
    System.out.println("----------------------- FIN Capturados al Revisar--------------------------------------");*/
    //-->3 Pasar a un Bean para ser llevado al Oracle
    //Bean para actualizar la revision del documento
    BeanRevisarDocumento beanrevisarDocumento = new BeanRevisarDocumento();
    //Siete(07 )datos obtenidos de la session BeanRevisarDocuemnto
    beanrevisarDocumento.setCDOCUMENTO_PERIODO(periodo);
    beanrevisarDocumento.setCDOCUMENTO_COD_DOC_INT(codigoDocumentoInterno);
    beanrevisarDocumento.setCDOCUMENTO_CLASE(claseDocumento);
    beanrevisarDocumento.setCDOCUMENTO_CLASIFICACION(clasificacion);
    beanrevisarDocumento.setVDOCUMENTO_USUARIO_ENV(codigoUsuario);
    beanrevisarDocumento.setCHDOCUMENTO_SECUENCIA(secuencia);
    beanrevisarDocumento.setVDOCUMENTO_GUARNICION(guarnicion);

    //Noeve(09)+ UNO(01)tipo accion --datos obtenidos de la session BeanRevisarDocuemnto
    beanrevisarDocumento.setCDOCUMENTO_COD_ORG_DEP(orgDependencia);
    beanrevisarDocumento.setVDOCUMENTO_CLAVE_INDIC(claveIndicativo);
    beanrevisarDocumento.setCDOCUMENTO_ARCHIVO_INDIC(archivoIndicativo);
    beanrevisarDocumento.setVDOCUMENTO_ASUNTO(asunto);
    beanrevisarDocumento.setLCDOCUMENTO_CUERPO_DOC(cuerpoDocumento);
    beanrevisarDocumento.setCDOCUMENTO_PRIORIDAD(prioridad);
    beanrevisarDocumento.setVDOCUMENTO_USUARIO_REVISA(revisadopor);
    beanrevisarDocumento.setVDOCUMENTO_USUARIO_FIRMA(firmadopor);
    beanrevisarDocumento.setVHDOCUMENTO_OBSERVACION(observacion);
    beanrevisarDocumento.setTipoAccion(accion_enviar);

    Collection referencias = (Collection) session.getAttribute("resultado");
    Collection distribuciones = (Collection) session.getAttribute("ListarDestinatario");

    try {
        objRevisaDocumento.EnviarRevisarDocumento(beanrevisarDocumento, referencias, distribuciones);

    } catch (SQLException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }

} else if (reporte.equals("REV_05")) {

    String orgint_origen = request.getParameter("orgint_origen");
    String nombreanio = request.getParameter("nombreanio");
    String guarnicion = request.getParameter("guarnicion");
    String fecha = request.getParameter("fecha");
    String orgint_redacta = request.getParameter("orgint_redacta");
    String archivo = request.getParameter("archivo");
    String grado_distribucion = request.getParameter("grado_distribucion");
    String cargo_distribucion = request.getParameter("cargo_distribucion");
    String cargo_firmante = request.getParameter("cargo_firmante");
    String asunto = request.getParameter("asunto");
    String cuerpo = request.getParameter("cuerpo");


%>

<iframe name="central" src="<%= request.getContextPath()%>/r_oficioRevisarvp?orgint_origen=<%=orgint_origen%>&nombreanio=<%=nombreanio%>&guarnicion=<%=guarnicion%>&fecha=<%=fecha%>&orgint_redacta=<%=orgint_redacta%>&archivo=<%=archivo%>&grado_distribucion=<%=grado_distribucion%>&cargo_distribucion=<%=cargo_distribucion%>&asunto=<%=asunto%>&cuerpo=<%=cuerpo%>&cargo_firmante=<%=cargo_firmante%>" frameborder="1" scrolling="yes"  width="100%" height=500></iframe>


<%} else if (reporte.equals("REV_06")) {

    String firmado_por = request.getParameter("firma");
    String revisado_por = request.getParameter("recibe");


%>

<table>
    <tr>
        <td> <a href="javascript:f_clasificacion();"><img src="<%=request.getContextPath()%>/imagenes/icono/firmado_por.png" width="70px" height="60px" align="center" title="Eliga por quien sera firmado el documento.."/>SERÁ FIRMADO POR:</a></td>
    </tr>
    <tr>
        <td>                                                     
            <select name="cbo_firmadoPor" class="form-control" id="cbo_firmadoPor" onchange="f_habilitar('firmado_por')">
                <%

                    Iterator iterator = objCombobox.obtenerfirmadoPor(objbean.getCUSUARIO_COD_ORG()).iterator();
                    while (iterator.hasNext()) {
                        BeanUsuarioAD bean = (BeanUsuarioAD) iterator.next();
                        String seleccion = (bean.getVUSUARIO_CODIGO().equals(firmado_por)) ? "selected" : "";
                        out.println("<option value= " + bean.getVUSUARIO_CODIGO() + " " + seleccion + ">" + bean.getVUSUARIO_CARGO() + "</option>");
                    }

                %>                

            </select>
        </td>
    </tr>
    <tr>
        <td>                                                                   
            <a href="javascript:f_clasificacion();"   ><img src="<%=request.getContextPath()%>/imagenes/icono/enviar.png" width="70px" height="60px" align="center" title="Eliga a quien sera enviado el docuemento para ser revisado.." />ENVIAR PARA SU REVISIÓN AL:</a>
        </td>                                                       
    </tr>
    <tr>
        <td>                                                       
            <select name="cbo_revisadoPor" class="form-control" id="cbo_revisadoPor" onchange="f_habilitar('revisado_por')">
                <%
                    Iterator iterator1 = objCombobox.obtenerRevisadorPor(objbean.getCUSUARIO_COD_ORG()).iterator();
                    while (iterator1.hasNext()) {
                        BeanUsuarioAD bean = (BeanUsuarioAD) iterator1.next();
                        String seleccion = (bean.getVUSUARIO_CODIGO().equals(revisado_por)) ? "selected" : "";
                        out.println("<option " + seleccion + " value=" + bean.getVUSUARIO_CODIGO() + ">" + bean.getVUSUARIO_CARGO() + "</option>");

                    }

                %>
            </select> 
        </td>
    </tr>
</table>  


<%} else if (reporte.equals("REV_07")) {

    String accion_Botones = request.getParameter("accion_Botones");
    if (accion_Botones.equals("Btn_firma_digital")) {
%>
<button type="button" class="btn btn-success "  onclick="javascript:f_vistaprevia();">Vista Previa</button>                                  
<button class="btn btn-info btn-info" style="width: 250px" type="button" onclick="javascript:f_tranferencia();"><b>FIRMA DIGITAL</b></button>              

<%
} else if (accion_Botones.equals("Btn_Al_Parte")) {

%>
<button type="button" class="btn btn-success "  onclick="javascript:f_vistaprevia();">Vista Previa</button>                                  
<button class="btn btn-info btn-info" style="width: 250px" type="button" onclick="javascript:f_tranferencia('ALPARTE');"><b>ENVIAR AL PARTE</b></button>              

<%       } else if (accion_Botones.equals("Btn_Revisar")) {
%>
<button type="button" class="btn btn-success "  onclick="javascript:f_vistaprevia();">Vista Previa</button>                                  
<button class="btn btn-info btn-info" style="width: 250px" type="button" onclick="javascript:f_tranferencia('REVISAR');"><b>ENVIAR PARA REVISAR</b></button>              

<%
        }

    }
%>