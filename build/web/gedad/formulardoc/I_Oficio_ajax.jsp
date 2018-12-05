<%@include file="cerrarSesion.jsp" %>
<%@taglib uri="/WEB-INF/tlds/libreria.tld" prefix="lb"%>
<%@page import="java.util.*"%>
<%@page import="java.util.Base64.Decoder"%>
<%@page import="comun.DAOFactory"%>
<%@page import="comun.FormularDocumentoDAO"%>
<%@page import="sagde.bean.*" %>

<%    String hora = (String) request.getParameter("pasacache");
    String reporte = (String) request.getParameter("reporte");
    String periodo = (String) request.getParameter("periodo");
    String tipo = (String) request.getParameter("tipo");
    String interna = (String) request.getParameter("interna");
    String secuencia = (String) request.getParameter("secuencia");
    String orden = (String) request.getParameter("orden");
    String clase = (String) request.getParameter("clase");
    String nrodoc = (String) request.getParameter("nrodoc");
    String desde = (String) request.getParameter("desde");
    String hasta = (String) request.getParameter("hasta");
    String archivo = (String) request.getParameter("archivo");
    String token = (String) request.getParameter("token");
    String asunto = (String) request.getParameter("asunto");
    String guarnicion = (String) request.getParameter("guarnicion");
    String orgint_origen = (String) request.getParameter("orgint_origen");
    String nombreanio = (String) request.getParameter("nombreanio");
    String fecha = (String) request.getParameter("fecha");
    String orgint_redacta = (String) request.getParameter("orgint_redacta");
    String grado_distribucion = (String) request.getParameter("grado_distribucion");
    String cargo_distribucion = (String) request.getParameter("cargo_distribucion");
    String cargo_firmante = (String) request.getParameter("cargo_firmante");

    BeanUsuarioAD objBeanU = (BeanUsuarioAD) session.getAttribute("usuario");
    DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
    FormularDocumentoDAO objFD = objDAOFactory.getFormularDocumentoDAO();
    ArrayList distribucion = new ArrayList();
    ArrayList referencia = new ArrayList();
    ArrayList anexo = new ArrayList();
    session = request.getSession(true);
    /*
    01. DEVUELVE LA ORGANIZACION SEGUN EL TIPO (PARA MODAL DISTRIBUCION)
    02. BUSCA UNA DISTRIBUCCION SELECCIONADA, LA AGREGA A LA COLLECTION EN MEMORIA Y MUESTRA TABLA 
    03. RETORNA LA DISTRIBUCION AL PIE DE PAGINA DEL OFICIO, PARA CLICK EN RADIO BUTTON
    04. RETORNA LA DISTRIBUCION AL PIE DE PAGINA PARA CERRAR O RETORNO
    05. ELIMINA UNA DISTRIBUCION
    06. REPORTE DE VISTA PREVIA
    //*********************************
    //TRATADO EXCLUSIVO DE REFERENCIAS
    //*********************************
    07. MUESTRA EL FORMULARIO DE BUSQUEDA DE REFERENCIAS
    08. LISTA LAS REFERENCIAS SEGUN COINDICENCIAS DE BUSQUEDA
    09. AGREGA UNA REFERENCIA DEL CUADRO DE BUSQUEDA DE REFERENCIAS Y LISTA
    10. MUESTRA EL FORMULARIO PARA AGREGAR REFERENCIA
    11. RETORNO DE LAS REFERENCIAS AL OFICIO
    12. FILTRA COMBO INTERNA SEGUN TIPO DE ORGANIZACION (BUSQUEDA DE REFERENCIA)
    13. LISTA LAS REFERENCIAS TEMPORALES
    14. ELIMINA UNA REFERENCIA Y LUEGO LISTA
    15. ACTUALIZA ORDEN DE UNA REFERENCIA
    16. VISTA PREVIA DE LA REFERENCIA A PARTIR DEL TOKEN
    21. FILTRA COMBO INTERNA SEGUN TIPO DE ORGANIZACION (AGREGAR REFERENCIA)
    //*********************************
    //TRATADO EXCLUSIVO DE ANEXOS
    //*********************************
    17. LISTA LOS ANEXOS TEMPORALES
    18. MUESTRA FORMULARIO PARA AGREGAR ANEXO
    19. ELIMINA UN ANEXO Y LUEGO LISTA
    20. RETORNO DE LOS ANEXOS AL OFICIO
     */
    //System.out.println("reporte x"+reporte+"x");
    if (reporte.equals("01")) {

        if (tipo.equals("I")) {
            int cantidad = objFD.obtenerOrganizacionInternas(objBeanU.getCUSUARIO_COD_ORG()).size();
            if (cantidad > 0) {
                out.println("<select name='cboOrganizacion' id='cboOrganizacion' class='form-control selectpicker' data-live-search='true'>");
                out.println("<option>--Elija Opcion--</option>");
                Iterator iteratorOrgI = objFD.obtenerOrganizacionInternas(objBeanU.getCUSUARIO_COD_ORG()).iterator();
                while (iteratorOrgI.hasNext()) {
                    BeanOrganizacionInterna beanorgi = (BeanOrganizacionInterna) iteratorOrgI.next();
                    out.println("<option value=" + beanorgi.getCOINTERNA_CODIGO() + ">" + beanorgi.getVOINTERNA_NOM_CORTO() + "</option>");
                }
            } else {
                out.println("No hay organizaciones subordinadas");
            }

        } else if (tipo.equals("E")) {
            out.println("<select name='cboOrganizacion' id='cboOrganizacion' class='form-control selectpicker' data-live-search='true'>");
            out.println("<option>--Elija Opcion--</option>");
            Iterator iteratorOrgE = objFD.obtenerOrganizacionExterna().iterator();
            while (iteratorOrgE.hasNext()) {
                BeanOrganizacionExterna beanorge = (BeanOrganizacionExterna) iteratorOrgE.next();
                out.println("<option  value=" + beanorge.getCodigo() + ">" + beanorge.getNombre() + "</option>");
            }
        } else if (tipo.equals("G")) {
            String dato = interna.substring(0, 2);
            out.println("<select name='cboOrganizacion' id='cboOrganizacion' class='form-control selectpicker' data-live-search='true'>");
            out.println("<option>--Elija Opcion--</option>");
            Iterator iteratorOrgI = objFD.obtenerOrganizacionEjercito(interna, dato).iterator();
            while (iteratorOrgI.hasNext()) {
                BeanOrganizacionInterna beanorgi = (BeanOrganizacionInterna) iteratorOrgI.next();
                out.println("<option value=" + beanorgi.getCOINTERNA_CODIGO() + ">" + beanorgi.getVOINTERNA_NOM_CORTO() + "</option>");
            }
        }
        out.println("</select>");

    } else if (reporte.equals("02")) {

        String mensaje = "";
        if (tipo.contains("G")) {
            tipo = "I";
        }

        BeanDistribucion objBeanDI = objFD.obtenerDistribucion(tipo, interna);
        objBeanDI.setTipo("C");
        distribucion = (ArrayList) session.getAttribute("distribucion");

        if (distribucion == null) {
            distribucion = new ArrayList();
        }
        if (objBeanDI.getCodigoOrganizacion() == null) {
            mensaje = "No existe persona a cargo en esta organización en GEDAD";
        } else {
            boolean existe = objFD.existeElemento(distribucion, objBeanDI);
            if (existe == false) {
                distribucion.add(objBeanDI);
            }
        }

%>
<div align=center"><%=mensaje%></div>
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
            for (int i = 0; i < distribucion.size(); i++) {
                BeanDistribucion objBeanD = (BeanDistribucion) distribucion.get(i);
        %>
        <tr>
            <td><div align="center"><%=objBeanD.getDescOrganizacion()%></div></td>
            <td>
                <div><%=objBeanD.getGrado()%></div>
                <div><%=objBeanD.getNombre()%></div>
                <div><i><%=objBeanD.getCargo()%></i></div>
            </td>
            <td><div align="center"><input name="trabajo" type="radio" onClick="javascript:f_enviaDistribucion('<%=objBeanD.getNombre()%>', '<%=objBeanD.getGrado()%>', '<%=objBeanD.getCargo()%>', '<%=objBeanD.getCodigoOrganizacion()%>', '<%=objBeanD.getTipoOrganizacion()%>')" <%if (objBeanD.getTipo() != null) {
                    if (objBeanD.getTipo().equals("T")) {%> checked="true" <%}
                        }%> /></div></td>
            <td><div align="center"><a href="javascript:f_elimina('<%=objBeanD.getTipoOrganizacion()%>','<%=objBeanD.getCodigoOrganizacion()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/delete.png" width="35px" height="35px" /></a></div></td>
        </tr>
        <%}%>
    </tbody>
</table>
<%
    session.setAttribute("distribucion", distribucion);
} else if (reporte.equals("03")) {
    distribucion = (ArrayList) session.getAttribute("distribucion");

    //session.setAttribute("distribucion", distribucion);
%>
<table border="0" class="EstiloOF">
    <%        for (int i = 0; i < distribucion.size(); i++) {
            BeanDistribucion objBeanD = (BeanDistribucion) distribucion.get(i);
            String org_sin_espacio = objBeanD.getCodigoOrganizacion().replaceAll("\\s", "");
            if (org_sin_espacio.equals(interna.trim())) {
                objBeanD.setTipo("T");
                distribucion.remove(i);
                distribucion.add(i, objBeanD);
    %>
    <tr>
        <td>-&nbsp;<%=objBeanD.getDescOrganizacion()%>&nbsp;..........&nbsp;</td>
        <td>01</td>
    </tr>
    <%}
        }
    %>
    <%
        for (int i = 0; i < distribucion.size(); i++) {
            BeanDistribucion objBeanD = (BeanDistribucion) distribucion.get(i);
            String org_sin_espacio = objBeanD.getCodigoOrganizacion().replaceAll("\\s", "");
            if (!org_sin_espacio.equals(interna.trim())) {
                objBeanD.setTipo("C");
                distribucion.remove(i);
                distribucion.add(i, objBeanD);%>
    <tr>
        <td>-&nbsp;<%=objBeanD.getDescOrganizacion()%>&nbsp;..........&nbsp;</td>
        <td>01 (C'Inf)</td>
    </tr>
    <%}
        }
    %>
</table>
<%
    session.setAttribute("distribucion", distribucion);
} else if (reporte.equals("04")) {
    distribucion = (ArrayList) session.getAttribute("distribucion");

    //session.setAttribute("distribucion", distribucion);
%>
<table border="0" class="EstiloOF">
    <%        for (int i = 0; i < distribucion.size(); i++) {
            BeanDistribucion objBeanD = (BeanDistribucion) distribucion.get(i);
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
        for (int i = 0; i < distribucion.size(); i++) {
            BeanDistribucion objBeanD = (BeanDistribucion) distribucion.get(i);
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
    session.setAttribute("distribucion", distribucion);
} else if (reporte.equals("05")) {
    //Llenando Lista de Distribucion con la Sesion
    distribucion = (ArrayList) session.getAttribute("distribucion");
    for (int i = 0; i < distribucion.size(); i++) {
        BeanDistribucion objBeanD = (BeanDistribucion) distribucion.get(i);
        String org_sin_espacio = objBeanD.getCodigoOrganizacion().replaceAll("\\s", "");
        if (objBeanD.getTipoOrganizacion().equals(tipo) && org_sin_espacio.equals(interna)) {
            distribucion.remove(i);
            break;
        }
    }
    session.setAttribute("distribucion", distribucion);
%>
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
            for (int i = 0; i < distribucion.size(); i++) {
                BeanDistribucion objBeanD = (BeanDistribucion) distribucion.get(i);
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
<%
} else if (reporte.equals("06")) {

%>
<div class="embed-responsive embed-responsive-16by9">
    <iframe class="embed-responsive-item" src="<%= request.getContextPath()%>/r_oficiovp?&orgint_origen=<%=orgint_origen%>&nombreanio=<%=nombreanio%>&guarnicion=<%=guarnicion%>&fecha=<%=fecha%>&orgint_redacta=<%=orgint_redacta%>&archivo=<%=archivo%>&grado_distribucion=<%=grado_distribucion%>&cargo_distribucion=<%=cargo_distribucion%>&asunto=<%=asunto%>&cargo_firmante=<%=cargo_firmante%>"></iframe>
</div>
<%
    //session.removeAttribute(cuerpo);
} else if (reporte.equals("07")) {
%>
<form id="form2" name="form2" method="post" action="">
    <table width="100%">
        <tr>
            <td>
                <table width="100%">
                    <tr>
                        <td width="32%"><div align="left" class="EstiloOF">Año</div></td>
                        <td width="2%">&nbsp;</td>
                        <td width="32%"><div align="left" class="EstiloOF">Tipo Organizacion</div></td>
                        <td width="2%">&nbsp;</td>
                        <td width="32%"><div align="left" class="EstiloOF">Organización</div></td>
                    </tr>
                    <tr>
                        <td>
                            <select name="cbo_PeriodoBR" class="form-control" id="cbo_PeriodoBR" >
                                <%
                                    Iterator iterator = objFD.obtenerPeriodo().iterator();
                                    while (iterator.hasNext()) {
                                        BeanPeriodo bean = (BeanPeriodo) iterator.next();
                                        out.println("<option value= " + bean.getCPERIODO_CODIGO() + ">" + bean.getCPERIODO_CODIGO() + "</option>");
                                    }
                                %> 
                            </select>   
                        </td>
                        <td>&nbsp;</td>
                        <td>
                            <select name="cbo_TipoBR" class="form-control" id="cbo_TipoBR" onchange="javascript:f_org_referencia(this.value);">
                                <option value="I">Interna</option>
                                <option value="E">Externa</option> 
                            </select>
                        </td>
                        <td>&nbsp;</td>
                        <td>
                            <div id="org_BR">
                                <select name='cbo_InternaBR' id='cbo_InternaBR' class='form-control selectpicker' data-live-search='true'>
                                    <%
                                        out.println("<option value='N'>--Elija ORG EJERCITO--</option>");
                                        Iterator iteratorOrgI = objFD.obtenerOrganizacionEjercito_MP().iterator();
                                        while (iteratorOrgI.hasNext()) {
                                            BeanOrganizacionInterna beanorgi = (BeanOrganizacionInterna) iteratorOrgI.next();
                                            out.println("<option value=" + beanorgi.getCOINTERNA_CODIGO() + ">" + beanorgi.getVOINTERNA_NOM_CORTO() + "</option>");
                                        }

                                    %>  
                                </select>
                            </div>
                        </td>
                    </tr>
                </table>
                <table width="100%">
                    <tr>
                        <td width="22%"><div align="left" class="EstiloOF">Clase Documento</div></td>
                        <td width="4%">&nbsp;</td>
                        <td width="22%"><div align="left" class="EstiloOF">Nro Documento</div></td>
                        <td width="4%">&nbsp;</td>
                        <td width="22%"><div align="left" class="EstiloOF">Desde</div></td>
                        <td width="4%">&nbsp;</td>
                        <td width="22%"><div align="left" class="EstiloOF">Hasta</div></td>    
                    </tr>
                    <tr>
                        <td>
                            <select name='cbo_ClaseBR' id='cbo_ClaseBR' class='form-control selectpicker' data-live-search='true'>
                                <%                                    Iterator iteratorClaseDoc = objFD.obtenerClaseDocumento().iterator();
                                    while (iteratorClaseDoc.hasNext()) {
                                        BeanClase beanclase = (BeanClase) iteratorClaseDoc.next();
                                        out.println("<option value=" + beanclase.getCCLASE_CODIGO() + ">" + beanclase.getVCLASE_NOM_LARGO() + "</option>");
                                    }
                                %>  
                            </select>
                        </td>
                        <td>&nbsp;</td>
                        <td><div align="left" class="EstiloOF">
                                <input name="txt_nro_docBR" id="txt_nro_docBR" type="text" class="form-control"  />
                            </div>
                        </td>
                        <td>&nbsp;</td>
                        <td><div align="left" class="EstiloOF">
                                <input type="text" class="form-control datepicker" name="txtFecDesdeBR" id="txtFecDesdeBR" size="10" maxlength="10" />
                            </div>
                        </td>
                        <td>&nbsp;</td>
                        <td>
                            <div align="left" class="EstiloOF">
                                <input type="text" class="form-control datepicker" name="txtFecHastaBR" id="txtFecHastaBR" size="10" maxlength="10" />
                            </div>
                        </td>
                    </tr>                
                    <tr>
                        <td colspan="7"><div align="left" class="EstiloOF">Asunto</div></td>
                        <td>&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="5"><div align="left" ><input name="txt_Asunto_BR" id="txt_Asunto_BR" type="text" class="form-control"  /></div></td>
                        <td>&nbsp;</td>
                        <td><button class="btn btn-info form-control" type="button" onclick="javascript:f_Buscar_Referencia();"><b>BUSQUEDA</b></button></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr height="5px"></tr>
        <!-- Para la tabla de Referencia -->   
        <tr>
            <td>
                <div id="modalListaBusRef">&nbsp;</div>
            </td>
        </tr>
    </table>
</form>
<%} else if (reporte.equals("08")) {

    referencia = (ArrayList) objFD.obtenerBusqReferencia(tipo, interna, desde, hasta, clase, nrodoc, asunto, periodo, objBeanU.getJEFE_UNIDAD());

%>
<table class="display" id="dt_busref" width="100%" border="1">
    <thead>
        <tr bgcolor="#B0B199">              
            <th style="width:10%"><div align="center">AÑO</div></th>
            <th style="width:10%"><div align="center">CLASE</div></th>
            <th style="width:10%"><div align="center">NRO</div></th>
            <th style="width:10%"><div align="center">FECHA</div></th>
            <th style="width:50%"><div align="center">ASUNTO</div></th>
            <th style="width:10%">&nbsp;</th>
        </tr>
    </thead>
    <tbody>
        <%  for (int i = 0; i < referencia.size(); i++) {
                BeanReferencia objBeanD = (BeanReferencia) referencia.get(i);
        %>
        <tr>
            <td><%=objBeanD.getCDOCUMENTO_PERIODO()%></td>
            <td><%=objBeanD.getVCLASE_NOM_CORTO()%></td>
            <td><%=objBeanD.getCDOCUMENTO_NRO_ORDEN()%></td>
            <td><%=objBeanD.getFECHA_DOC_ORIGEN()%></td>
            <td><%=objBeanD.getVDOCUMENTO_ASUNTO()%></td>
            <th><div align="center"><a href="javascript:f_agrega_refe('<%=objBeanD.getCDOCUMENTO_PERIODO()%>','<%=objBeanD.getCDOCUMENTO_COD_DOC_INT()%>','<%=objBeanD.getVDISTRIBUCION_TOKEN()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/adjuntar.png" width="20px" height="20px" /></a></div></th>
        </tr>
        <%}%>
    </tbody>

</table>
<%
} else if (reporte.equals("09")) {

    BeanTemporal objBeanT = new BeanTemporal();
    objBeanT.setVTEMP_USUARIO(objBeanU.getVUSUARIO_CODIGO());
    objBeanT.setCTEMP_CODORG(objBeanU.getCUSUARIO_COD_ORG());
    objBeanT.setCTEMP_PERIODO(periodo);
    objBeanT.setCTEMP_COD_DOC(nrodoc);
    objBeanT.setVTEMP_TOKEN(token);
    objFD.insertarReferenciaTemporal(objBeanT);

    referencia = (ArrayList) objFD.listarReferenciaTemporal(objBeanU.getVUSUARIO_CODIGO(), objBeanU.getCUSUARIO_COD_ORG());
    session.setAttribute("referencia", referencia);
%>
<table class="display" id="dt_reftemp" width="100%" border="1">
    <thead>
        <tr bgcolor="#B0B199">              
            <th style="width:10%"><div align="center">ORDEN</div></th>
            <th style="width:20%"><div align="center">CLASE</div></th>
            <th style="width:15%"><div align="center">NRO</div></th>
            <th style="width:20%"><div align="center">INDICATIVO</div></th>
            <th style="width:15%"><div align="center">FECHA</div></th>
            <th style="width:10%"><div align="center">VER</div></th>
            <th style="width:10%"><div align="center">ELIMINAR</div></th>
        </tr>
    </thead>
    <tbody>
        <%
            for (int i = 0; i < referencia.size(); i++) {
                objBeanT = (BeanTemporal) referencia.get(i);
        %>
        <tr>
            <td><div align="center">
                    <select name='cbo_RefOrdenLR' id='cbo_RefOrdenLR' class='form-control selectpicker' data-live-search='true' onchange="f_cambiaOrden('<%=objBeanT.getCTEMP_SECUENCIA()%>', this.value)">
                        <%
                            Iterator iteratorRefOrden = objFD.obtenerReferenciaOrden().iterator();
                            while (iteratorRefOrden.hasNext()) {
                                BeanReferenciaOrden objBeanRO = (BeanReferenciaOrden) iteratorRefOrden.next();
                                if (objBeanT.getVTEMP_REFORD_COD().equals(objBeanRO.getVREFORD_COD())) {
                                    out.println("<option value=" + objBeanRO.getVREFORD_COD() + " selected >" + objBeanRO.getVREFORD_DESC() + "</option>");
                                } else {
                                    out.println("<option value=" + objBeanRO.getVREFORD_COD() + ">" + objBeanRO.getVREFORD_DESC() + "</option>");
                                }
                            }
                        %>  
                    </select>
                </div></td>
            <td><%=objBeanT.getVCLASE_NOM_CORTO()%></td>
            <td><%=objBeanT.getCDOCUMENTO_NRO_ORDEN()%></td>
            <td><%=objBeanT.getVDOCUMENTO_CLAVE_INDIC()%></td>
            <td><div align="center"><%=objBeanT.getDDOCUMENTO_FECHA()%></div></td>
            <td><div align="center"><a href="javascript:f_verReferencia('<%=objBeanT.getVTEMP_TOKEN()%>','<%=objBeanT.getVTEMP_NOMBRE()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/ver_anexos.png" width="20px" height="20px" /></a></div></td>
            <td><div align="center"><a href="javascript:f_eliminarReferencia('<%=objBeanT.getCTEMP_SECUENCIA()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/delete.png" width="20px" height="20px" /></a></div></td>
        </tr>
        <%}%>
    </tbody>
</table>
<%
} else if (reporte.equals("10")) {
%>
<form id="form2" name="form2" method="post" action="">
    <table width="100%">
        <tr>                        
            <td colspan="6" style="background: #D4FD89">
                <div align="left"><span style="color:rgb(111, 111, 111); font-family: tahoma"><u>I. Datos del la Organización que Remite</u>:</span></div>
            </td>    
        </tr>
        <tr>
            <td>
                <table width="100%">
                    <tr>
                        <td>&nbsp;&nbsp;</td>
                        <td><div align="left" class="EstiloOF">Año</div></td>
                        <td>&nbsp;&nbsp;</td>
                        <td><div align="left" class="EstiloOF">Tipo Organización</div></td>
                        <td>&nbsp;&nbsp;</td>
                        <td><div align="left" class="EstiloOF">Organización</div></td>
                    </tr>
                    <tr>
                        <td>&nbsp;&nbsp;</td>
                        <td><select name="cbo_Periodo_AR" class="form-controlOF" id="cbo_Periodo_AR" >
                                <%
                                    Iterator iterator = objFD.obtenerPeriodo().iterator();
                                    while (iterator.hasNext()) {
                                        BeanPeriodo bean = (BeanPeriodo) iterator.next();
                                        out.println("<option value= " + bean.getCPERIODO_CODIGO() + ">" + bean.getCPERIODO_CODIGO() + "</option>");
                                    }
                                %>  
                            </select>
                        </td>
                        <td>&nbsp;&nbsp;</td>
                        <td><select name="cbo_Tipo_Organizacion_AR" class="form-controlOF" id="cbo_Tipo_Organizacion_AR" onchange="f_DIS_AR(this.value)">
                                <option value="I">Interna</option>
                                <option value="E">Externa</option> 
                            </select>
                        <td>&nbsp;&nbsp;</td>
                        </td>
                        <td><div id="org_AR">
                                <select name='cbo_InternaAR' id='cbo_InternaAR' class='form-control selectpicker' data-live-search='true'>
                                    <%
                                        Iterator iteratorOrgI1 = objFD.obtenerOrganizacionEjercito_MP().iterator();
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
    <table width="100%">
        <tr>                        
            <td colspan="6" style="background: #D4FD89">
                <div align="left"><span style="color:rgb(111, 111, 111); font-family: tahoma"><u>II. Datos del documento</u>:</span></div>
            </td>       
        </tr>
        <tr>
            <td>
                <table width="100%">
                    <tr>
                        <td>&nbsp;&nbsp;</td>
                        <td><div align="left" class="EstiloOF">Clase Documento</div></td>
                        <td>&nbsp;&nbsp;</td>
                        <td><div align="left" class="EstiloOF">Nro Documento</div> </td>
                        <td>&nbsp;&nbsp;</td>
                        <td><div align="left" class="EstiloOF">Indicativo</div> </td>
                        <td>&nbsp;&nbsp;</td>
                        <td><div align="left" class="EstiloOF">Fecha Documento</div> </td>
                    </tr>
                    <tr>
                        <td>&nbsp;&nbsp;</td>
                        <td><div align="left" class="EstiloOF">
                                <select name='cbo_Clase_AR' id='cbo_Clase_AR' class='form-control selectpicker' data-live-search='true'>
                                    <%
                                        Iterator iteratorClaseDoc1 = objFD.obtenerClaseDocumento().iterator();
                                        while (iteratorClaseDoc1.hasNext()) {
                                            BeanClase beanclase = (BeanClase) iteratorClaseDoc1.next();
                                            out.println("<option value=" + beanclase.getCCLASE_CODIGO() + ">" + beanclase.getVCLASE_NOM_LARGO() + "</option>");
                                        }
                                    %>  
                                </select>
                            </div>
                        </td>
                        <td>&nbsp;&nbsp;</td>
                        <td><div align="left" class="EstiloOF"><input name="txt_Nro_Orden_AR" id="txt_Nro_Orden_AR" type="text" class="form-controlOF" size="3"  /></div> </td>
                        <td>&nbsp;&nbsp;</td>
                        <td><div align="left" class="EstiloOF"><input name="txt_Clave_Indic_AR" id="txt_Clave_Indic_AR" type="text" class="form-controlOF" size="3"  /></div> </td>
                        <td>&nbsp;&nbsp;</td>
                        <td><div align="left" class="EstiloOF"><input name="txt_fecha_AR" id="txt_fecha_AR" type="text" class="form-controlOF datepicker" size="3" /></div> </td>
                    </tr>
                    <tr>
                        <td>&nbsp;&nbsp;</td>
                        <td colspan="7"><div align="left" class="EstiloOF">Asunto</div></td>                                              
                    </tr>
                    <tr>
                        <td>&nbsp;&nbsp;</td>
                        <td colspan="7"><div align="left" class="EstiloOF"><input name="txt_Asunto_AR" id="txt_Asunto_AR" type="text" class="form-controlOF" size="3" /></div></td>                                              
                    </tr>
                    <tr>
                        <td>&nbsp;&nbsp;</td>
                        <td colspan="3"><div align="left" class="EstiloOF">Clasificación</div></td>
                        <td>&nbsp;&nbsp;</td>
                        <td colspan="3"><div align="left" class="EstiloOF">Prioridad</div> </td>
                    </tr>
                    <tr>
                        <td>&nbsp;&nbsp;</td>
                        <td colspan="3">
                            <div align="left" class="EstiloOF">
                                <select name='cbo_Clasificacion_AR' id='cbo_Clasificacion_AR' class='form-control selectpicker' data-live-search='true'   >
                                    <%
                                        Iterator iteratorClasificacion = objFD.obtenerClasificacion().iterator();
                                        while (iteratorClasificacion.hasNext()) {
                                            BeanClasificacionDocumento beanclase = (BeanClasificacionDocumento) iteratorClasificacion.next();
                                            out.println("<option value=" + beanclase.getCodigo() + ">" + beanclase.getNombre() + "</option>");
                                        }
                                    %>  
                                </select>
                            </div>
                        </td>

                        <td>&nbsp;&nbsp;</td>
                        <td colspan="3"><div align="left" class="EstiloOF"> 
                                <select name='cbo_Prioridad_AR' id='cbo_Prioridad_AR' class='form-control selectpicker' data-live-search='true'   >
                                    <%
                                        Iterator iteratorPrioridad = objFD.obtenerPrioridades().iterator();
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
</form>
<table width="100%">
    <tr>                        
        <td colspan="6" style="background: #D4FD89">
            <div align="left"><span style="color:rgb(111, 111, 111); font-family: tahoma"><u>III. Adjuntar Documentos</u>:</span></div>
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
                            <input type="file" class="form-controlOF" id="url_Referencia" name="fileAnexo" style="width: 550px" />
                        </div>
                    </div>
                    <div align="center">
                        <span class="input-group-btn">
                            <table width="30%">
                                <tr>
                                    <td width="45%"><button class="btn btn-success btn-reset form-control" type="button" onclick="javascript:f_Grabar_Referencia();"><b>GRABAR</b></button></td>
                                    <td width="10%">&nbsp;</td>
                                    <td width="45%"><button class="btn btn-danger btn-info form-control" type="button" onclick="javascript:f_cerrar_moReferencia();"><b>CANCELAR</b></button></td>
                                </tr>
                            </table>
                        </span>
                    </div>
                </form>
                <!-- agregar despues el css: display:none -->
                <iframe name="frame_refe" style="background: rgba(0,0,0,0.3); width: 100%; height: 10px;visibility: hidden">
                    IFrame de soporte
                </iframe>
            </div> 
        </td>
    </tr>
</table>
<%} else if (reporte.equals("11")) {
    referencia = (ArrayList) objFD.listarReferenciaTemporal(objBeanU.getVUSUARIO_CODIGO(), objBeanU.getCUSUARIO_COD_ORG());
    for (int i = 0; i < referencia.size(); i++) {
        BeanTemporal objBeanT = (BeanTemporal) referencia.get(i);
%>
<a href="javascript:f_verReferencia('<%=objBeanT.getVTEMP_TOKEN()%>','<%=objBeanT.getVTEMP_NOMBRE()%>');">	
    <%=objBeanT.getVREFORD_DESC()%>&nbsp;
    <%=objBeanT.getVCLASE_NOM_CORTO()%>&nbsp;Nº&nbsp;
    <%=objBeanT.getCDOCUMENTO_NRO_ORDEN()%>&nbsp;
    <%=objBeanT.getVDOCUMENTO_CLAVE_INDIC()%>&nbsp;del&nbsp; 
    <%=objBeanT.getDDOCUMENTO_FECHA()%>
</a><br>
<%}
} else if (reporte.equals("12")) {
    out.println("<select name='cbo_InternaBR' id='cbo_InternaBR' class='form-control selectpicker' data-live-search='true' >");

    if (tipo.equals("I")) {
        out.println("<option value='N'>--Elija ORG EJERCITO--</option>");
        Iterator iteratorOrgI = objFD.obtenerOrganizacionEjercito_MP().iterator();
        while (iteratorOrgI.hasNext()) {
            BeanOrganizacionInterna beanorgi = (BeanOrganizacionInterna) iteratorOrgI.next();
            out.println("<option value='" + beanorgi.getCOINTERNA_CODIGO() + "'>" + beanorgi.getVOINTERNA_NOM_CORTO() + "</option>");
        }

    } else if (tipo.equals("E")) {
        out.println("<option value='N'>--Elija ORG EXTERNA--</option>");
        Iterator iteratorOrgE = objFD.obtenerOrganizacionExterna().iterator();
        while (iteratorOrgE.hasNext()) {
            BeanOrganizacionExterna beanorge = (BeanOrganizacionExterna) iteratorOrgE.next();
            out.println("<option  value='" + beanorge.getCodigo() + "'>" + beanorge.getNombre() + "</option>");
        }
    }
    out.println("</select>");
} else if (reporte.equals("13")) {
    referencia = (ArrayList) objFD.listarReferenciaTemporal(objBeanU.getVUSUARIO_CODIGO(), objBeanU.getCUSUARIO_COD_ORG());
    session.setAttribute("referencia", referencia);
%>
<table class="display" id="dt_reftemp" width="100%" border="1">
    <thead>
        <tr bgcolor="#B0B199">              
            <th style="width:10%"><div align="center">ORDEN</div></th>
            <th style="width:20%"><div align="center">CLASE</div></th>
            <th style="width:15%"><div align="center">NRO</div></th>
            <th style="width:20%"><div align="center">INDICATIVO</div></th>
            <th style="width:15%"><div align="center">FECHA</div></th>
            <th style="width:10%"><div align="center">VER</div></th>
            <th style="width:10%"><div align="center">ELIMINAR</div></th>
        </tr>
    </thead>
    <tbody>
        <%
            for (int i = 0; i < referencia.size(); i++) {
                BeanTemporal objBeanT = (BeanTemporal) referencia.get(i);
        %>
        <tr>
            <td><div align="center">
                    <select name='cbo_RefOrdenLR' id='cbo_RefOrdenLR' class='form-control selectpicker' data-live-search='true' onchange="f_cambiaOrden('<%=objBeanT.getCTEMP_SECUENCIA()%>', this.value)">
                        <%
                            Iterator iteratorRefOrden = objFD.obtenerReferenciaOrden().iterator();
                            while (iteratorRefOrden.hasNext()) {
                                BeanReferenciaOrden objBeanRO = (BeanReferenciaOrden) iteratorRefOrden.next();
                                if (objBeanT.getVTEMP_REFORD_COD().equals(objBeanRO.getVREFORD_COD())) {
                                    out.println("<option value=" + objBeanRO.getVREFORD_COD() + " selected >" + objBeanRO.getVREFORD_DESC() + "</option>");
                                } else {
                                    out.println("<option value=" + objBeanRO.getVREFORD_COD() + ">" + objBeanRO.getVREFORD_DESC() + "</option>");
                                }
                            }
                        %>  
                    </select>
                </div></td>
            <td><%=objBeanT.getVCLASE_NOM_CORTO()%></td>
            <td><%=objBeanT.getCDOCUMENTO_NRO_ORDEN()%></td>
            <td><%=objBeanT.getVDOCUMENTO_CLAVE_INDIC()%></td>
            <td><div align="center"><%=objBeanT.getDDOCUMENTO_FECHA()%></div></td>
            <td><div align="center"><a href="javascript:f_verReferencia('<%=objBeanT.getVTEMP_TOKEN()%>','<%=objBeanT.getVTEMP_NOMBRE()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/ver_anexos.png" width="20px" height="20px" /></a></div></td>
            <td><div align="center"><a href="javascript:f_eliminarReferencia('<%=objBeanT.getCTEMP_SECUENCIA()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/delete.png" width="20px" height="20px" /></a></div></td>
        </tr>
        <%}%>
    </tbody>
</table>
<%} else if (reporte.equals("14")) {
    BeanTemporal objBeanT = new BeanTemporal();
    objBeanT.setVTEMP_USUARIO(objBeanU.getVUSUARIO_CODIGO());
    objBeanT.setCTEMP_CODORG(objBeanU.getCUSUARIO_COD_ORG());
    objBeanT.setCTEMP_SECUENCIA(secuencia);
    objFD.eliminarReferenciaTemporal(objBeanT);
    referencia = (ArrayList) objFD.listarReferenciaTemporal(objBeanU.getVUSUARIO_CODIGO(), objBeanU.getCUSUARIO_COD_ORG());
    session.setAttribute("referencia", referencia);
%>
<table class="display" id="dt_reftemp" width="100%" border="1">
    <thead>
        <tr bgcolor="#B0B199">              
            <th style="width:10%"><div align="center">ORDEN</div></th>
            <th style="width:20%"><div align="center">CLASE</div></th>
            <th style="width:15%"><div align="center">NRO</div></th>
            <th style="width:20%"><div align="center">INDICATIVO</div></th>
            <th style="width:15%"><div align="center">FECHA</div></th>
            <th style="width:10%"><div align="center">VER</div></th>
            <th style="width:10%"><div align="center">ELIMINAR</div></th>
        </tr>
    </thead>
    <tbody>
        <%
            for (int i = 0; i < referencia.size(); i++) {
                objBeanT = (BeanTemporal) referencia.get(i);
        %>
        <tr>
            <td><div align="center">
                    <select name='cbo_RefOrdenLR' id='cbo_RefOrdenLR' class='form-control selectpicker' data-live-search='true' onchange="f_cambiaOrden('<%=objBeanT.getCTEMP_SECUENCIA()%>', this.value)">
                        <%
                            Iterator iteratorRefOrden = objFD.obtenerReferenciaOrden().iterator();
                            while (iteratorRefOrden.hasNext()) {
                                BeanReferenciaOrden objBeanRO = (BeanReferenciaOrden) iteratorRefOrden.next();
                                if (objBeanT.getVTEMP_REFORD_COD().equals(objBeanRO.getVREFORD_COD())) {
                                    out.println("<option value=" + objBeanRO.getVREFORD_COD() + " selected >" + objBeanRO.getVREFORD_DESC() + "</option>");
                                } else {
                                    out.println("<option value=" + objBeanRO.getVREFORD_COD() + ">" + objBeanRO.getVREFORD_DESC() + "</option>");
                                }
                            }
                        %>  
                    </select>
                </div></td>
            <td><%=objBeanT.getVCLASE_NOM_CORTO()%></td>
            <td><%=objBeanT.getCDOCUMENTO_NRO_ORDEN()%></td>
            <td><%=objBeanT.getVDOCUMENTO_CLAVE_INDIC()%></td>
            <td><div align="center"><%=objBeanT.getDDOCUMENTO_FECHA()%></div></td>
            <td><div align="center"><a href="javascript:f_verReferencia('<%=objBeanT.getVTEMP_TOKEN()%>','<%=objBeanT.getVTEMP_NOMBRE()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/ver_anexos.png" width="20px" height="20px" /></a></div></td>
            <td><div align="center"><a href="javascript:f_eliminarReferencia('<%=objBeanT.getCTEMP_SECUENCIA()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/delete.png" width="20px" height="20px" /></a></div></td>
        </tr>
        <%}%>
    </tbody>
</table>
<%} else if (reporte.equals("15")) {
    BeanTemporal objBeanT = new BeanTemporal();
    objBeanT.setVTEMP_USUARIO(objBeanU.getVUSUARIO_CODIGO());
    objBeanT.setCTEMP_CODORG(objBeanU.getCUSUARIO_COD_ORG());
    objBeanT.setCTEMP_TIPO("R");
    objBeanT.setCTEMP_SECUENCIA(secuencia);
    objBeanT.setVTEMP_REFORD_COD(orden);
    objFD.actualizarOrdenReferenciaTemporal(objBeanT);
    referencia = (ArrayList) objFD.listarReferenciaTemporal(objBeanU.getVUSUARIO_CODIGO(), objBeanU.getCUSUARIO_COD_ORG());
    session.setAttribute("referencia", referencia);
} else if (reporte.equals("16")) {
    Decoder decoder = Base64.getDecoder();
    archivo = new String(decoder.decode(archivo));
    System.out.println("archivo x"+archivo+"x");
%>
<div class="embed-responsive embed-responsive-16by9">
    <iframe class="embed-responsive-item" src="<%= request.getContextPath()%>/alfrescovp?token=<%=token%>&archivo=<%=archivo%>"></iframe>
</div>
<%
} else if (reporte.equals("17")) {
    anexo = (ArrayList) objFD.listarAnexoTemporal(objBeanU.getVUSUARIO_CODIGO(), objBeanU.getCUSUARIO_COD_ORG());
    session.setAttribute("anexo", anexo);
%>
<table class="display" id="dt_anetemp" width="100%" border="1">
    <thead>
        <tr bgcolor="#B0B199">
            <th><div align="center">N°</div></th>
            <th><div align="center">NOMBRE</div></th>
            <th><div align="center">VER</div></th>
            <th><div align="center">ELIMINAR</div></th>
        </tr>
    </thead>
    <tbody>
        <%
            for (int i = 0; i < anexo.size(); i++) {
                BeanTemporal objBeanT = (BeanTemporal) anexo.get(i);
        %>
        <tr>
            <td><div align="center"><%=objBeanT.getCTEMP_SECUENCIA()%></div></td>
            <td><%=objBeanT.getVTEMP_NOMBRE()%></td>
            <td><div align="center"><a href="javascript:f_verAnexo('<%=objBeanT.getVTEMP_TOKEN()%>','<%=objBeanT.getVTEMP_NOMBRE()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/ver_anexos.png" width="20px" height="20px" /></a></div></td>
            <td><div align="center"><a href="javascript:f_eliminarAnexo('<%=objBeanT.getCTEMP_SECUENCIA()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/delete.png" width="20px" height="20px" /></a></div></td>
        </tr>
        <%}%>
    </tbody>
</table>
<%
} else if (reporte.equals("18")) {
%>
<form method="POST" action="#" enctype="multipart/form-data" id="frm_anexos" target="frame_support">
    <!-- COMPONENT START -->
    <div class="form-group">
        <div class="input-group input-file" name="Fichier1">
            <label for="url_anexo"></label>
            <input type="file" class="form-controlOF" id="url_anexo" name="fileAnexo" style="width: 550px" />
        </div>
    </div>
    <div align="center">
        <span class="input-group-btn">
            <table width="30%">
                <tr>
                    <td width="45%"><button class="btn btn-success btn-reset form-control" type="button" onclick="javascript:f_grabar_anexo();"><b>GRABAR</b></button></td>
                    <td width="10%">&nbsp;</td>
                    <td width="45%"><button class="btn btn-danger btn-info form-control" type="button" onclick="javascript:f_cerrar_moAnexos();"><b>CANCELAR</b></button></td>
                </tr>
            </table>
        </span>
    </div>
</form>
<!-- agregar despues el css: display:none -->
<iframe name="frame_support" style="background: rgba(0,0,0,0.3); width: 100%; height: 0px;visibility: hidden">
    IFrame de soporte
</iframe>
<%
} else if (reporte.equals("19")) {
    BeanTemporal objBeanT = new BeanTemporal();
    objBeanT.setVTEMP_USUARIO(objBeanU.getVUSUARIO_CODIGO());
    objBeanT.setCTEMP_CODORG(objBeanU.getCUSUARIO_COD_ORG());
    objBeanT.setCTEMP_SECUENCIA(secuencia);
    objFD.eliminarAnexoTemporal(objBeanT);

    anexo = (ArrayList) objFD.listarAnexoTemporal(objBeanU.getVUSUARIO_CODIGO(), objBeanU.getCUSUARIO_COD_ORG());
    session.setAttribute("anexo", anexo);
%>
<table class="display" id="dt_anetemp" width="100%" border="1">
    <thead>
        <tr bgcolor="#B0B199">              
            <th><div align="center">N°</div></th>
            <th><div align="center">NOMBRE</div></th>
            <th><div align="center">VER</div></th>
            <th><div align="center">ELIMINAR</div></th>
        </tr>
    </thead>
    <tbody>
        <%
            for (int i = 0; i < anexo.size(); i++) {
                objBeanT = (BeanTemporal) anexo.get(i);
        %>
        <tr>
            <td><div align="center"><%=objBeanT.getCTEMP_SECUENCIA()%></div></td>
            <td><%=objBeanT.getVTEMP_NOMBRE()%></td>
            <td><div align="center"><a href="javascript:f_verAnexo('<%=objBeanT.getVTEMP_TOKEN()%>','<%=objBeanT.getVTEMP_NOMBRE()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/ver_anexos.png" width="20px" height="20px" /></a></div></td>
            <td><div align="center"><a href="javascript:f_eliminarAnexo('<%=objBeanT.getCTEMP_SECUENCIA()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/delete.png" width="20px" height="20px" /></a></div></td>
        </tr>
        <%}%>
    </tbody>
</table>
<%
} else if (reporte.equals("20")) {
    anexo = (ArrayList) objFD.listarAnexoTemporal(objBeanU.getVUSUARIO_CODIGO(), objBeanU.getCUSUARIO_COD_ORG());
    session.setAttribute("anexo", anexo);
%>
<table border="0" width="100%">
    <tr class="EstiloOF">
        <td><u>ANEXOS:</u><br>
            <table  width="100%" >
                <tbody>
                    <%
                        for (int i = 0; i < anexo.size(); i++) {
                            BeanTemporal objBeanT = (BeanTemporal) anexo.get(i);
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
                    <%}%>
                </tbody>
            </table>
        </td>
    </tr>
</table>
<%
    } else if (reporte.equals("21")) {
        out.println("<select name='cbo_InternaAR' id='cbo_InternaAR' class='form-control selectpicker' data-live-search='true' >");

        if (tipo.equals("I")) {
            out.println("<option value='N'>--Elija ORG EJERCITO--</option>");
            Iterator iteratorOrgI = objFD.obtenerOrganizacionEjercito_MP().iterator();
            while (iteratorOrgI.hasNext()) {
                BeanOrganizacionInterna beanorgi = (BeanOrganizacionInterna) iteratorOrgI.next();
                out.println("<option value='" + beanorgi.getCOINTERNA_CODIGO() + "'>" + beanorgi.getVOINTERNA_NOM_CORTO() + "</option>");
            }

        } else if (tipo.equals("E")) {
            out.println("<option value='N'>--Elija ORG EXTERNA--</option>");
            Iterator iteratorOrgE = objFD.obtenerOrganizacionExterna().iterator();
            while (iteratorOrgE.hasNext()) {
                BeanOrganizacionExterna beanorge = (BeanOrganizacionExterna) iteratorOrgE.next();
                out.println("<option  value='" + beanorge.getCodigo() + "'>" + beanorge.getNombre() + "</option>");
            }
        }
        out.println("</select>");
    } else if (reporte.equals("22")) {
        objFD.limpiaTemporales(objBeanU.getVUSUARIO_CODIGO(), objBeanU.getCUSUARIO_COD_ORG());
        session.removeAttribute("distribucion");
    }
%>