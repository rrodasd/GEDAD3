<%@page import="java.util.Base64.Decoder"%>
<%@page import="java.util.Base64"%>
<%@page import="sagde.bean.BeanRevisarDocumento"%>
<%@page import="comun.RevisaDocumentoDAO"%>
<%@page import="sagde.bean.BeanFirmarDocumento"%>
<%@page import="comun.FirmarDocumentoDAO"%>
<%@page import="comun.ComboboxDAO"%>
<%@page import="sagde.bean.BeanDistribucion"%>
<%@page import="sagde.bean.BeanArchivo"%>
<%@page import="java.util.Iterator"%>
<%@page import="comun.FormularDocumentoDAO"%>
<%@ taglib uri="/WEB-INF/tlds/libreria.tld" prefix="lb" %>
<%@ taglib uri="/WEB-INF/tlds/c.tld" prefix="c" %>

<%@page import="java.util.ArrayList"%>
<%@page import="sagde.bean.BeanUsuarioAD"%>

<%@page import="java.sql.SQLException"%>
<%@page import="comun.DAOFactory"%>
<%@page import="java.util.Collection"%>
<%@page import="sagde.bean.BeanAnexo"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.io.File"%>
<%@page import="javax.servlet.http.HttpServletRequest"%>
<%@page import="javax.servlet.http.*"%> 
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<script type="text/javascript" src="<%=request.getContextPath()%>/ckeditor/ckeditor.js" ></script>
<%

    String hora = (String) request.getParameter("pasacache");
    String reporte = (String) request.getParameter("reporte");
    String dependencia = (String) request.getParameter("dependencia");
    String clase = (String) request.getParameter("clase");

    String tipoOrganizacion = (String) request.getParameter("tipoOrganizacion");

    DAOFactory objDF = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
    FirmarDocumentoDAO objFD = objDF.getFirmarDocumentoDAO();
    ComboboxDAO objCombobox = objDF.getComboboxDAO();

    session = request.getSession(true);

    //Session dentro de la aplicacion 
    ServletContext sec2 = session.getServletContext();

    BeanUsuarioAD objbean = (BeanUsuarioAD) session.getAttribute("usuario");

    ArrayList ListarDistribucion = null;
    ArrayList ListarDestinatario = null;
    ArrayList ListarAnexos = null;

    /*
    REV_01. RETORNA LISTA, SEGUN VALOR DE COMBO ORGANIZACION
    REV_02. RETORNA UN DOCUMENTO DE LA LISTA POR REVISAR
       
     */
    //System.out.println("reporte FIRMAR-->" + reporte + "<--");
    /*
    *Formulario Ajax (01). Listara los documentos de acuerdo al Combox-------------------------------------------------------------------------------->
     */
    if (reporte.equals("REV_01")) {

        ArrayList listaPorFirmar = (ArrayList) objFD.ObtenerListaDocumentosXFirmar("A", objbean.getVUSUARIO_CODIGO(), dependencia);

%>
<table class="display" width="90%" border="1"  id="example">
    <thead>
        <tr>

            <th><div align="center">FECHA</div></th>
            <th><div align="center">ORGANIZACIÓN</div></th>
            <th><div align="center">CLASE</div></th>
            <th><div align="center">N°</div></th>
            <th><div align="center">ASUNTO</div></th>
            <th><div align="center">DESTINO</div></th>
            <th><div align="center">OBSERVACION</div></th>
            <th>&nbsp;</th>
            <th>&nbsp;</th>
        </tr>
    </thead>
    <tbody>
        <%                    
            for (int i = 0; i < listaPorFirmar.size(); i++) {
                BeanFirmarDocumento objBeanD = (BeanFirmarDocumento) listaPorFirmar.get(i);
        %>
        <tr>

            <td><%=objBeanD.getDHDOCUMENTO_FECH_ESTADO()%></td>
            <td><%=objBeanD.getVHDOCUMENTO_COD_USU_ENV()%></td>
            <td><%=objBeanD.getVCLASE_NOM_CORTO()%></td>
            <td><%=objBeanD.getCDOCUMENTO_COD_DOC_INT()%></td>
            <td><%=objBeanD.getVDOCUMENTO_ASUNTO()%></td>
            <td><%=objBeanD.getDESTINATARIO()%></td>
            <td><%=objBeanD.getVHDOCUMENTO_OBSERVACION()%></td>
            <td><div align="center"><a href="javascript:f_verdoc('<%=objBeanD.getCDOCUMENTO_COD_DOC_INT()%>','<%=objBeanD.getCDOCUMENTO_CLASE()%>','<%=objBeanD.getCDOCUMENTO_PERIODO()%>','<%=objBeanD.getCHDOCUMENTO_SECUENCIA()%>','<%=objBeanD.getVHDOCUMENTO_OBSERVACION()%>');" ><img src="<%= request.getContextPath()%>/imagenes/icono/verdoc.png" height="25px" width="25px" /></a></div></td>
            <td><div align="center"><a href=javascript:f_listaanexo('<%=objBeanD.getCDOCUMENTO_COD_DOC_INT()%>','<%=objBeanD.getCDOCUMENTO_PERIODO()%>','<%=objBeanD.getCDOCUMENTO_CLASE()%>','<%=objBeanD.getCHDOCUMENTO_SECUENCIA()%>') ><img src="<%= request.getContextPath()%>/imagenes/icono/anexo.png" height="25px" width="25px" /></a></div></td>
        </tr>
        <%}%>
    </tbody>
</table>
<%} /*
    *Formulario Ajax (02). Mostrará el Oficio por revisar cargado con los campos------------------------------------------------------------------------>
 */ else if (reporte.equals("REV_02")) {

    if (clase.equals("0001")) {

        String codint = (String) request.getParameter("codint");
        String periodo = (String) request.getParameter("periodo");
        String secuencia = (String) request.getParameter("secuencia");

        //-->1.Procedimiento para llamar a la lista de documentos por Revisar         
        BeanFirmarDocumento objBeanRD = objFD.obtenerDocXFirmar(periodo, codint, objbean.getVUSUARIO_CODIGO());
        //System.out.println("objBeanRD--" + objBeanRD);
        //-->2. Traer el Codigo de la Organizacion de la cabecera para devolver al JSP para carbar el lb
        String cod_org_cabecera = objBeanRD.getCDOCUMENTO_COD_ORG_DEP();
        if (cod_org_cabecera != null) {
            session.setAttribute("cod_org_cabecera", cod_org_cabecera);
        }

        //System.out.println("cod_org_cabecera--" + cod_org_cabecera);
        //-->3. Traer la distribucion o DESTINATARIOS guardado por el formular para ser REVISADO
        ListarDestinatario = (ArrayList) objFD.FD_ObtenerDistribucion(periodo, codint);
        if (ListarDestinatario != null) {
            session.setAttribute("ListarDestinatario", ListarDestinatario);
        }

        //System.out.println("ListarDestinatario--" + ListarDestinatario);
        periodo = objBeanRD.getCDOCUMENTO_PERIODO();
        String cod_int = objBeanRD.getCDOCUMENTO_COD_DOC_INT();

        // -->4. Enviar a session todo el Bean
        session.setAttribute("beanRevisarDoc", objBeanRD);
        //System.out.println("entroooo");


%>
<table width="100%" border="0">
    <input name="txh_periodo_rev" type="text" value="<%=periodo%>"/>
    <input name="txh_cod_int_rev" type="text" value="<%=codint%>"/>
    <tr><a name="ancla_revisa_arriba"></a>
    <td width="100%" bgcolor="#FFFFFF">
        <table width="100%" cellspacing="0" cellpadding="0" border="0">
            <tr>
                <td width="10%"><div align="center"><img src="<%= request.getContextPath()%>/imagenes/escudos/escudo.png" width="70px" height="60px" /></div></td>
                <td width="10%" bgcolor="#E80000"><div class="EstiloOF">&nbsp;PERÚ</div></td>
                <td width="26%" bgcolor="#939393"><div class="EstiloOF">&nbsp;Ministerio</div><div class="EstiloOF">&nbsp;de Defensa</div></td>
                <td width="26%" bgcolor="#A0A0A0"><div class="EstiloOF">&nbsp;Ejército</div><div class="EstiloOF">&nbsp;del Perú</div></td>

                <td width="28%" bgcolor="#ADADAD">&nbsp;
                    <select name="cbo_OrgDependencia"  id="cbo_OrgDependencia"   class="form-controlOF" style="background-color: #ADADAD"  >
                        <lb:TagComboOrganizacionCabecera></lb:TagComboOrganizacionCabecera></select>&nbsp;</td>                             
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
                        <td><img src="<%=request.getContextPath()%>/imagenes/icono/firma_digital.jpg" width="100px" height="60px" align="center" />
                    </td>
                    <td style="background: #808965"> <input name="txt_firma_dig" class="form-controlOF" type="text" readonly="true" size="45" /></td>

                </tr>
            </table>
        </div>                      

    </td>
</tr>


<tr> 

    <td colspan="5"><div align="right" class="EstiloOF"><input name="txt_Guarnicion" id="txt_Guarnicion" type="text" style="border:0px; text-align: right;" value="<lb:TagDescripcionGuarnicion></lb:TagDescripcionGuarnicion>" readonly="true" />,&nbsp;
            <%
                java.util.Calendar fecha = java.util.Calendar.getInstance();
                String Meses[] = {"Enero", "Febrero", "Marzo", "Abril", "Mayo", "Junio", "Julio", "Agosto", "Septiembre", "Octubre", "Noviembre", "Diciembre"};
                               String fecha_st = fecha.get(java.util.Calendar.DATE) + " de " + Meses[fecha.get(java.util.Calendar.MONTH)] + " del " + fecha.get(java.util.Calendar.YEAR);%>
            <input name="txt_Fecha" id="txt_Fecha" type="text" size="25" style="border:0px; text-align: right;" value="<%=fecha_st%>" readonly="true" />
        </div></td>
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
    <td width="17"><input type="hidden" name="txt_saltodistribucion" class="Estilo10" /></td>
    <td colspan="2">
        <div align="left" class="EstiloOF"  >Oficio N° </div>  </td>
    <td colspan="3">
        <table width="100%">
            <tr>
                <td width="10%" ><div id="div_Nro_Unico_OF"><input name="txt_nro_unico_OF"   type="text" class="form-control" size="3" readonly="false" value="00000"/></div></td>
                <td width="20%"><input name="txt_Clave" type="text" class="form-controlOF" readonly="true" value="<%=objBeanRD.getVDOCUMENTO_CLAVE_INDIC()%>" size="10"/></td>
                <td width="70%"><select name="cboArchivoIndicativo" id="cboArchivoIndicativo" class="form-controlOF">
                        <%
                            Iterator iteAI = objCombobox.obtenerArchivoIndicativo().iterator();
                            while (iteAI.hasNext()) {
                                BeanArchivo objBeanA = (BeanArchivo) iteAI.next();
                                String seleccion = (objBeanA.getCARCHIVO_CODIGO().trim().equals(objBeanRD.getCDOCUMENTO_ARCHIVO_INDIC().trim())) ? "selected" : "";
                                out.println("<option value=" + objBeanA.getCARCHIVO_CODIGO() + " " + seleccion + ">" + objBeanA.getCARCHIVO_CODIGO() + " " + objBeanA.getVARCHIVO_NOMBRE() + "</option>");
                            }

                        %>
                    </select></td>
            </tr>
        </table>		                                  
    </td>
</tr>
<tr>
    <td>&nbsp;</td>
    <td width="49"><div align="left" class="EstiloOF">Se&ntilde;or</div></td>
    <td width="8"><div align="left" class="EstiloOF">:</div></td>
    <td colspan="3"><div align="left" class="Estilo10"><label>
                <input name="txt_Grado" class="form-controlOF" type="text" readonly="true" value="<%=objBeanRD.getVDISTRIBUCION_GRADO()%>"/>
            </label><input name="txt_Cargo" class="form-controlOF" type="text" readonly="true" value="<%=objBeanRD.getVDISTRIBUCION_CARGO()%>"/></div></td>
</tr>
<tr>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td>&nbsp;</td>
    <td colspan="3">
        <table>
            <tr>
                <td><button type="button" class="btn btn-primary btn-sm" style="width: 100%" onclick="javascript:f_openDistribucion('<%=objBeanRD.getCDOCUMENTO_COD_ORG_DEP()%>', '<%=objBeanRD.getCDOCUMENTO_PERIODO()%>', '<%=objBeanRD.getCDOCUMENTO_COD_DOC_INT()%>');" >Distribucion</button></td>
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
            <table>
                <tr>
                    <td><button type="button" class="btn btn-primary btn-sm" style="width: 100%" onclick="javascript:f_openRef('ventana', 'scrollbars=yes,width=1000,height=800');" >Agregar</button></td>
                    <td><input type="hidden" name="txt_saltoReferencia" /></td>
                </tr>
            </table></label>
        <c:forEach items="${sessionScope.resultado}" var="fila"><span class="EstiloOF">
                <a href="javascript:f_mostrarPDFReferencia('<c:out value="${fila.periodo}"/>','<c:out value="${fila.codigoDocumentoInterno}"/>');">	
                    <c:out value="${fila.letras}"/>&nbsp;
                    <c:out value="${fila.clase_nombreCorto}"/>&nbsp;Nº
                    <c:out value="${fila.numero}"/>&nbsp;
                    <c:out value="${fila.clave}"/>
                    <c:out value="${fila.archivo}"/>&nbsp;del 
                    <c:out value="${fila.fecha}"/>
                    <c:out value="${fila.estado_ref}"/>
                </a>		
                <br></span>
        </c:forEach></td>
</tr>
<!-- anexos -->				
<tr>
    <td>&nbsp;</td>
    <td colspan="2"><button type="button" class="btn btn-primary btn-sm" style="width: 100%" onclick="javascript:f_openAnexoVentana('<%=periodo%>', '<%=codint%>');" >Agregar Anexos</button></td>
    <td colspan="3">&nbsp;</td>
</tr>
<!-- terminooooooo anexos -->	
<tr>
    <td>&nbsp;</td>
    <td height="216" colspan="5">
        <table width="100%" height="212" border="0">
            <tr>                        
                <td width="100%">
                    <div align="justify">
                        <textarea name="cuerpo" rows="20" id="cuerpo" class="form-controlOF"><%=objBeanRD.getLCDOCUMENTO_CUERPO_DOC()%></textarea>
                        <script>CKEDITOR.replace('cuerpo');</script>
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
<tr>
    <td>&nbsp;</td>
    <td colspan="5"><table border="0" width="100%">              
            <!-- AQUI VA LA LISTA DE ANEXOS -->
            <%
                           if (session.getAttribute("anexos") != null) {%>
            <tr class="EstiloOF">
                <td>Anexos:<br>
                    <c:forEach items="${sessionScope.anexos}" var="anex">
                        <a href="javascript:f_mostrarPDF('<c:out value="${anex.CANEXO_PERIODO}"/>',
                           '<c:out value="${anex.CANEXO_COD_DOC_INT}"/>','<c:out value="${anex.CANEXO_SECUENCIA}"/>','<c:out value="${anex.VANEXO_NOMBRE}"/>');" >
                            <c:out value="${anex.CANEXO_SECUENCIA}"/> <c:out value="${anex.VANEXO_NOMBRE}"/></a><br>
                    </c:forEach>				  </td>
            </tr>
            <% }%> 	
            <!--  FIN LISTA DE ANEXOS -->	

        </table></td>
</tr>

<tr>
    <td colspan="6">    
        <table>
            <tr>
                <td style="width: 70%">
                    <button type="button" class="btn btn-primary btn-lg"  style="width: 100%" onclick="javascript:f_terminar('<%=objBeanRD.getVFIRMA_COD_USUARIO()%>', '<%=objbean.getVUSUARIO_CODIGO()%>');">&nbsp;&nbsp;&nbsp;-----------------------Enviar Documento&nbsp;&nbsp;&nbsp;---------------------</button> 
                </td>
                <td>
                    <button type="button" class="btn btn-warning btn-lg"  style="width: 100%" onclick="javascript:f_Borrador();">Guardad en Borrador</button> 
                </td>
                <td>
                    <button type="button" class="btn btn-danger btn-lg"  style="width: 100%" onclick="javascript:f_Abredevolver();">Devolver Documento</button> 
                </td>
            </tr>
        </table>

    </td>
</tr>
<tr>
    <td colspan="6" hidden="50px">        
        dfdsfd
    </td>
</tr>
<tr>
    <td colspan="6">           
        sdfsdf  
    </td>
</tr>
<tr>
    <td colspan="6">           
        sdfsdf  
    </td>
</tr>


<br>
</table>    

<%
    }

} else if (reporte.equals("REV_03")) {

    String accion_enviar = request.getParameter("accion_enviar");
    //System.out.println("Ingreso al Ajax para Enviar a revisar al parte............" + accion_enviar);

    DAOFactory objDaoFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
    RevisaDocumentoDAO objRevisaDocumento = objDaoFactory.getRevisaDocumentoDAO();

    //-->1. Obtener Informacion del BeanRevisar
    BeanFirmarDocumento beanrevisar = (BeanFirmarDocumento) session.getAttribute("beanRevisarDoc");

    String periodo = beanrevisar.getCDOCUMENTO_PERIODO();
    //System.out.println("Ingreso al Ajax para Enviar a rperiodo............"+periodo);
    String codigoDocumentoInterno = beanrevisar.getCDOCUMENTO_COD_DOC_INT();
    String claseDocumento = beanrevisar.getCDOCUMENTO_CLASE();
    String clasificacion = beanrevisar.getCDOCUMENTO_CLASIFICACION();
    String codigoUsuario = (String) ((BeanUsuarioAD) (session.getAttribute("usuario"))).getVUSUARIO_CODIGO();
    String secuencia = beanrevisar.getCHDOCUMENTO_SECUENCIA();
    String guarnicion = beanrevisar.getVDOCUMENTO_GUARNICION();

    //System.out.println("----------------------- Datos obtenido del BeanRevisar-------------------------------------------");
    //System.out.println("-1.Periodo--" + periodo +"\n"+"-2.codigoDocumentoInterno-"+codigoDocumentoInterno+"\n"+"-3.claseDocumento-"+claseDocumento+"\n"+
    //"-4.clasificacion-"+clasificacion+"\n"+"-5.codigoUsuario-"+codigoUsuario+"\n"+"-6.secuencia-"+secuencia+"\n"+"-7.guarnicion-"+guarnicion);
    //System.out.println("----------------------- FIN DE Datos obtenido del BeanRevisar--------------------------------------");
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

    //System.out.println("----------------------- Datos Capturados del formulario al Revisar ajax-------------------------------------------");
    //System.out.println("1.-orgDependencia--" + orgDependencia +"\n"+"2.-claveIndicativo-"+claveIndicativo+"\n"+"3.-archivoIndicativo-"+archivoIndicativo+"\n"+
    //"4.-asunto-"+asunto+"\n"+"5.-cuerpoDocumento-"+cuerpoDocumento+"\n"+"6.-prioridad-"+prioridad+"\n"+"7.-revisadopor-"+revisadopor+
    //"\n"+"8.-firmadopor-"+firmadopor+"\n"+"9.-observacion-"+observacion+"\n"+"10.-accion_enviar-"+accion_enviar);
    //System.out.println("----------------------- FIN Capturados al Revisar--------------------------------------");  
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
    //System.out.println("----------------------- Distribucion666------------------------------------------");
    //System.out.println("distribuciones"+distribuciones.size());

    try {
        if (accion_enviar.equals("FIRMADIGITAL")) {

            String token = null;
            token = (String) sec2.getAttribute("tokenID_Of");
            //System.out.println("----------------------- vamos tokennnn------------------------------------------"+token);
            beanrevisarDocumento.setTokenOFicio(token);
            //Nro unico de OFICIo
            String NroUnicoOF = request.getParameter("NroUnicoOF");
            beanrevisarDocumento.setNroUnicoOF(NroUnicoOF);

            String NumeroDoc = objRevisaDocumento.FirmaDigitalDocumento(beanrevisarDocumento, referencias, distribuciones);
            //System.out.println(" NumeroDoc-------" + NumeroDoc);

        } else {

            objRevisaDocumento.EnviarRevisarDocumento(beanrevisarDocumento, referencias, distribuciones);
        }

    } catch (SQLException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }

} else if (reporte.equals("REV_06")) {

    String firmado_por = request.getParameter("firma");
    String revisado_por = request.getParameter("recibe");
    String formulario = request.getParameter("formulario");
%>

<table>
    <tr>
        <td> <a href="javascript:f_clasificacion();"><img src="<%=request.getContextPath()%>/imagenes/icono/firmado_por.png" width="70px" height="60px" align="center" title="Eliga por quien sera firmado el documento.."/>SERÁ FIRMADO POR:</a></td>
    </tr>
    <tr>
        <td>                                                     
            <select name="cbo_firmadoPor" class="form-control" id="cbo_firmadoPor" onchange="f_habilitar('firmado_por')">
                <%

                    Iterator iterator = objCombobox.obtenerfirmadoPor(objbean.getCUSUARIO_COD_ORG(),formulario).iterator();
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
                    Iterator iterator1 = objCombobox.obtenerRevisadorPor_mismo(objbean.getCUSUARIO_COD_ORG()).iterator();
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
<button type="button" class="btn btn-success "  onclick="javascript:f_vistaprevia1();">Vista Previa</button>                                  
<button class="btn btn-info btn-info" style="width: 250px" type="button" onclick="javascript:f_FirmaDigital();"><b>FIRMA DIGITAL</b></button>              

<%
} else if (accion_Botones.equals("Btn_Al_Parte")) {

%>
<button type="button" class="btn btn-success "  onclick="javascript:f_vistaprevia1();">Vista Previa</button>                                  
<button class="btn btn-info btn-info" style="width: 250px" type="button" onclick="javascript:f_tranferencia('ALPARTE');"><b>ENVIAR AL PARTE</b></button>              

<%       } else if (accion_Botones.equals("Btn_Revisar")) {
%>
<button type="button" class="btn btn-success "  onclick="javascript:f_vistaprevia1();">Vista Previa</button>                                  
<button class="btn btn-info btn-info" style="width: 250px" type="button" onclick="javascript:f_tranferencia('REVISAR');"><b>ENVIAR PARA REVISAR</b></button>              

<%
    }

} else if (reporte.equals("REV_08")) {
    //1. Obtener el año actual para guaradar en la BD
    Calendar fecha1 = java.util.Calendar.getInstance();
    String periodo = fecha1.get(java.util.Calendar.YEAR) + "";
    periodo = periodo;
    String nroUnicoDoc = null;

    String claseDoc = "0001";

    try {
        nroUnicoDoc = objFD.obtenerNroUnicoDoc(periodo, claseDoc);
        session.setAttribute("nroUnicoDoc", nroUnicoDoc);

    } catch (Exception ex) {

    }

    System.out.println("nroUnicoDoc------------------------------->" + nroUnicoDoc);
%>  

<input name="txt_nro_unico_OF" id="txt_nro_unico_OF" type="text" class="form-control" size="3" readonly="false" value="<%=nroUnicoDoc%>" />
<%
    }
%>
