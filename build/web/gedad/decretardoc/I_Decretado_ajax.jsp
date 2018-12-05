<%@include file="cerrarSesion.jsp" %>
<%@taglib uri="/WEB-INF/tlds/libreria.tld" prefix="lb"%>
<%@page import="comun.DAOFactory"%>
<%@page import="comun.OrganizacionInternaDAO"%>
<%@page import="comun.DecretarDocumentoDAO"%>
<%@page import="comun.FormularDocumentoDAO"%>
<%@page import="sagde.bean.*" %>
<%@page import="java.util.*"%>
<%@page import="java.util.Base64.Decoder"%>
<%    String hora = (String) request.getParameter("pasacache");
    String reporte = (String) request.getParameter("reporte");
    String periodo = (String) request.getParameter("periodo");
    String interna = (String) request.getParameter("interna");
    String tipodecreto = (String) request.getParameter("tipodecreto");
    String internaFiltro = (String) request.getParameter("internaFiltro");
    String internasubordinada = (String) request.getParameter("internasubordinada");
    String internaencargada = (String) request.getParameter("internaencargada");
    String documento = (String) request.getParameter("documento");
    String token = (String) request.getParameter("token");
    String archivo = (String) request.getParameter("archivo");
    String nrodecreto = (String) request.getParameter("nrodecreto");
    String prioridad = (String) request.getParameter("prioridad");
    String accion = (String) request.getParameter("accion");
    String observacion = (String) request.getParameter("observacion");
    String fecharpta = (String) request.getParameter("fecharpta");
    String internaorigen = (String) request.getParameter("internaorigen");
    String tipoorigen = (String) request.getParameter("tipoorigen");

    BeanUsuarioAD objBeanU = (BeanUsuarioAD) session.getAttribute("usuario");
    DAOFactory objDF = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
    DecretarDocumentoDAO objDD = objDF.getDecretarDocumentoDAO();
    FormularDocumentoDAO objFD = objDF.getFormularDocumentoDAO();
    Decoder decoder = Base64.getDecoder();
    /*
    01.VISTA PREVIA DESDE ALFRESCO A PARTIR DEL TOKEN
    02.LISTA DE DOCUMENTOS DECRETADOS SIN FILTRO
    03.LISTA DE DOCUMENTOS DECRETADOS APLICANDO FILTRO
    04.DEVUELVE CUERPO DEL DECRETO
    05.GUARDA EL DECRETO
    06.ELEVA EL DOCUMENTO
    07.ARCHIVA UN DOCUMENTO
    08.DEVUELVE LISTA DE ANEXOS
    09.PREPARA PARA LA VISTA PREVIA DEL ANEXO
    10.AGREGA UN DOCUMENTO COMO REFERENCIA TEMPORAL
     */

    if (reporte.equals("01")) {
        observacion = new String(decoder.decode(observacion));
        //Se verifica si hay acciones decretadas
        BeanDecreto objBeanD = new BeanDecreto();
        objBeanD.setCDOCUMENTO_PERIODO(periodo);
        objBeanD.setCDOCUMENTO_COD_DOC_INT(documento);
        objBeanD.setCDECRETO_COD_ORG(interna);
        objBeanD.setCDECRETO_COD_ORG_ENC(internaencargada);

        ArrayList listaAccion = (ArrayList) objDD.obtenerAccionesDecretadas(objBeanD);
        String acciones = "";
        if (listaAccion.size() >= 1) {
            for (int i = 0; i < listaAccion.size(); i++) {
                BeanAccion objBeanA = (BeanAccion) listaAccion.get(i);
                acciones += objBeanA.getVACCION_NOMBRE() + ", ";
            }
            acciones = acciones.substring(0, acciones.length() - 2);
        }
        
        BeanDistribucion objBeanDI = new BeanDistribucion();
        objBeanDI.setPeriodo(periodo);
        objBeanDI.setCodigoDocumento(documento);
        objBeanDI.setCodigoOrganizacion(interna);
        objBeanDI.setTipoOrganizacion("I");
        objDD.acuseReciboDistribucion(objBeanDI);
%>
<input type="hidden" id="txh_periodo" name="txh_periodo" value="<%=periodo%>" />
<input type="hidden" id="txh_documento" name="txh_documento" value="<%=documento%>" />
<input type="hidden" id="txh_nrodecreto" name="txh_nrodecreto" value="<%=periodo%><%=documento%>" />
<input type="hidden" id="txh_interna" name="txh_interna" value="<%=interna%>" />
<input type="hidden" id="txh_tipodecreto" name="txh_tipodecreto" value="<%=tipodecreto%>" />
<input type="hidden" id="txh_prioridad" name="txh_prioridad" value="<%=prioridad%>" />
<input type="hidden" id="txh_internaencargada" name="txh_internaencargada" value="<%=internaencargada%>" />
<input type="hidden" id="txh_token" name="txh_token" value="<%=token%>" />
<input type="hidden" id="txh_internaorigen" name="txh_internaorigen" value="<%=internaorigen%>" />
<input type="hidden" id="txh_tipoorigen" name="txh_tipoorigen" value="<%=tipoorigen%>" />
<iframe name="central" src="<%= request.getContextPath()%>/alfrescovp?token=<%=token%>&archivo=<%=archivo%>" frameborder="1" scrolling="yes"  width="100%" height="350"></iframe>
<table width="100%">
    <%if (!observacion.equals("null")) {
            out.println("<tr>");
            out.println("<td>Observaciones:&nbsp;</td><td>" + observacion + "</td>");
            out.println("</tr>");
        }
        if (!acciones.equals("")) {
            out.println("<tr>");
            out.println("<td>Para:&nbsp;</td><td>" + acciones + "</td>");
            out.println("</tr>");
        }
        if (!prioridad.equals("001")) {
            if (prioridad.equals("002")) {
                prioridad = "URGENTE";
            }
            if (prioridad.equals("003")) {
                prioridad = "MUY URGENTE";
            }
            out.println("<tr>");
            out.println("<td>Prioridad:&nbsp;</td><td>" + prioridad + "</td>");
            out.println("</tr>");
        }
        if (!fecharpta.equals("null")) {
            out.println("<tr>");
            out.println("<td>Fecha Rpta:&nbsp;</td><td>" + fecharpta + "</td>");
            out.println("</tr>");
        }

    %>
</table>
<%    } else if (reporte.equals("02")) {
    ArrayList listaDocumentoDecreto = (ArrayList) objDD.obtenerDocumentos_X_Decretar(objBeanU.getCUSUARIO_COD_ORG().trim(), objBeanU.getVUSUARIO_CODIGO());
%>
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
            for (int i = 0; i < listaDocumentoDecreto.size(); i++) {
                BeanDecreto objBeanD = (BeanDecreto) listaDocumentoDecreto.get(i);
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
<%
} else if (reporte.equals("03")) {
    ArrayList listaDocumentoDecreto = (ArrayList) objDD.obtenerDocumentos_X_DecretarconFiltro(objBeanU.getCUSUARIO_COD_ORG().trim(), internaFiltro);
%>
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
            for (int i = 0; i < listaDocumentoDecreto.size(); i++) {
                BeanDecreto objBeanD = (BeanDecreto) listaDocumentoDecreto.get(i);
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
<%
} else if (reporte.equals("04")) {

    Iterator iteratorE = objDD.obtenerOrganizacionEncargatura(objBeanU.getCUSUARIO_COD_ORG(), objBeanU.getVUSUARIO_CODIGO()).iterator();
    Iterator iteratorA = objDD.obtenerAccion().iterator();
    Iterator iteratorP = objDD.obtenerPrioridades().iterator();
%>
<div id="decretoEncargatura">
    <div>Decretar a:</div>
    <div>
        <select name="cboEncargaturaInterna" id="cboEncargaturaInterna" class="selectpicker form-control cboEncargaturaInterna" data-live-search="true" multiple="multiple" title="Seleccione" data-selected-text-format="count">
            <%
                while (iteratorE.hasNext()) {
                    BeanOrganizacionInterna objBeanOI = (BeanOrganizacionInterna) iteratorE.next();
                    out.println("<optgroup label=" + objBeanOI.getVOINTERNA_NOM_CORTO() + " >");
                    Iterator iteratorI = objDD.obtenerOrganizacionSubordinada(objBeanOI.getCOINTERNA_CODIGO(), objBeanU.getCUSUARIO_COD_ORG()).iterator();
                    while (iteratorI.hasNext()) {
                        BeanOrganizacionInterna objBeanOI2 = (BeanOrganizacionInterna) iteratorI.next();
                        //String seleccion = (objBeanOI2.getCOINTERNA_CODIGO().equals(internasubordinada)) ? "selected" : "";
                        out.println("<option value=" + objBeanOI2.getCOINTERNA_CODIGO() + " >" + objBeanOI2.getVOINTERNA_NOM_CORTO() + "</option>");
                    }
                    out.println("</optgroup>");
                }

            %>
        </select>
    </div>
</div>
<div id="decretoPara">
    <div>Para:</div>
    <div><select name="cboAccion" id="cboAccion" class="selectpicker form-control cboAccion" data-live-search="true" multiple="multiple" title="Seleccione las acciones" data-selected-text-format="count">
            <%                while (iteratorA.hasNext()) {
                    BeanAccion objBeanA = (BeanAccion) iteratorA.next();
                    String seleccion = (objBeanA.getCACCION_CODIGO().equals(accion)) ? "selected" : "";
                    out.println("<option value=" + objBeanA.getCACCION_CODIGO() + " " + seleccion + ">" + objBeanA.getVACCION_NOMBRE() + "</option>");
                }
            %>
        </select></div>
    <div>Prioridad:</div>
    <div>
        <select name="cboPrioridad" id="cboPrioridad" class="form-control">
            <%
                while (iteratorP.hasNext()) {
                    BeanPrioridadDocumento objBeanP = (BeanPrioridadDocumento) iteratorP.next();
                    String seleccion = (objBeanP.getCodigo().equals(prioridad)) ? "selected" : "";
                    out.println("<option value=" + objBeanP.getCodigo() + " " + seleccion + ">" + objBeanP.getNombre() + "</option>");
                }
            %>
        </select>
    </div>
    <div>Ampliacion del Decreto:</div>
    <div><textarea class="form-control inputstl" rows="7" name="txtObservacion" id="txtObservacion"></textarea></div>
    <div>Fecha de Respuesta:</div>
    <div><input type="text" class="form-control datepicker" name="txtFecRpta" id="txtFecRpta" /></div>
</div>
<%
} else if (reporte.equals("05")) {

    BeanDecreto objBeanD = new BeanDecreto();
    objBeanD.setCDOCUMENTO_PERIODO(periodo);
    objBeanD.setCDOCUMENTO_COD_DOC_INT(documento);
    objBeanD.setCDECRETO_NRO_DECRETO(nrodecreto);
    objBeanD.setCDECRETO_PRIORIDAD(prioridad);
    objBeanD.setVDECRETO_OBSERVACION(observacion);
    objBeanD.setVDECRETO_COD_USUARIO(objBeanU.getVUSUARIO_CODIGO());
    objBeanD.setDDECRETO_FECH_EJEC(fecharpta);

    ArrayList listaAccion = new ArrayList(Arrays.asList(accion.split(",")));
    objBeanD.setLISTA_ACCION(listaAccion);

    ArrayList listaInterna = new ArrayList(Arrays.asList(internasubordinada.split(",")));
    objBeanD.setLISTA_INTERNA(listaInterna);
    objDD.insertarDecreto(objBeanD, interna, internaencargada);

    ArrayList listaDocumentoDecreto = new ArrayList();
    if (internaFiltro.equals("SIN_FILTRO")) {
        listaDocumentoDecreto = (ArrayList) objDD.obtenerDocumentos_X_Decretar(objBeanU.getCUSUARIO_COD_ORG().trim(), objBeanU.getVUSUARIO_CODIGO());
    } else {
        listaDocumentoDecreto = (ArrayList) objDD.obtenerDocumentos_X_DecretarconFiltro(objBeanU.getCUSUARIO_COD_ORG().trim(), interna);
    }
%>
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
            for (int i = 0; i < listaDocumentoDecreto.size(); i++) {
                objBeanD = (BeanDecreto) listaDocumentoDecreto.get(i);
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
<%
} else if (reporte.equals("06")) {

    BeanDecreto objBeanD = new BeanDecreto();
    objBeanD.setCDOCUMENTO_PERIODO(periodo);
    objBeanD.setCDOCUMENTO_COD_DOC_INT(documento);
    objBeanD.setCDECRETO_COD_ORG(interna);
    objBeanD.setCDECRETO_COD_ORG_ENC(internaencargada);
    objBeanD.setCDECRETO_NRO_DECRETO(nrodecreto);
    objBeanD.setCDECRETO_PRIORIDAD(prioridad);
    objBeanD.setVDECRETO_OBSERVACION(observacion);
    objBeanD.setVDECRETO_COD_USUARIO(objBeanU.getVUSUARIO_CODIGO());

    objDD.elevarDecreto(objBeanD);
    ArrayList listaDocumentoDecreto = new ArrayList();
    if (internaFiltro.equals("SIN_FILTRO")) {
        listaDocumentoDecreto = (ArrayList) objDD.obtenerDocumentos_X_Decretar(objBeanU.getCUSUARIO_COD_ORG().trim(), objBeanU.getVUSUARIO_CODIGO());
    } else {
        listaDocumentoDecreto = (ArrayList) objDD.obtenerDocumentos_X_DecretarconFiltro(objBeanU.getCUSUARIO_COD_ORG().trim(), interna);
    }
%>
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
            for (int i = 0; i < listaDocumentoDecreto.size(); i++) {
                objBeanD = (BeanDecreto) listaDocumentoDecreto.get(i);
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
<%
} else if (reporte.equals("07")) {

    BeanDecreto objBeanD = new BeanDecreto();
    objBeanD.setCDOCUMENTO_PERIODO(periodo);
    objBeanD.setCDOCUMENTO_COD_DOC_INT(documento);
    objBeanD.setCDECRETO_COD_ORG(interna);
    objBeanD.setCDECRETO_COD_ORG_ENC(internaencargada);

    objDD.archivarDecreto(objBeanD);
    ArrayList listaDocumentoDecreto = new ArrayList();
    if (internaFiltro.equals("SIN_FILTRO")) {
        listaDocumentoDecreto = (ArrayList) objDD.obtenerDocumentos_X_Decretar(objBeanU.getCUSUARIO_COD_ORG().trim(), objBeanU.getVUSUARIO_CODIGO());
    } else {
        listaDocumentoDecreto = (ArrayList) objDD.obtenerDocumentos_X_DecretarconFiltro(objBeanU.getCUSUARIO_COD_ORG().trim(), interna);
    }
%>
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
            for (int i = 0; i < listaDocumentoDecreto.size(); i++) {
                objBeanD = (BeanDecreto) listaDocumentoDecreto.get(i);
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
<%
} else if (reporte.equals("08")) {
    ArrayList listaAnexo = (ArrayList) objDD.listaAnexo(periodo, interna);
%>
<table class="display" id="dt_aneDecr" width="100%" border="1">
    <thead>
        <tr bgcolor="#B0B199">              
            <th><div align="center">N°</div></th>
            <th><div align="center">NOMBRE</div></th>
            <th><div align="center">VER</div></th>
        </tr>
    </thead>
    <tbody>
        <%
            for (int i = 0; i < listaAnexo.size(); i++) {
                BeanAnexo objBeanA = (BeanAnexo) listaAnexo.get(i);
        %>
        <tr>
            <td><div align="center"><%=objBeanA.getCANEXO_SECUENCIA()%></div></td>
            <td><%=objBeanA.getVANEXO_NOMBRE()%></td>
            <td><div align="center"><a href="javascript:f_verAnexo('<%=objBeanA.getVANEXO_TOKEN()%>','<%=objBeanA.getVANEXO_NOMBRE()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/ver_anexos.png" width="20px" height="20px" /></a></div></td>
        </tr>
        <%}%>
    </tbody>
</table>
<%
} else if (reporte.equals("09")) {
%>
<div class="embed-responsive embed-responsive-16by9">
    <iframe class="embed-responsive-item" src="<%= request.getContextPath()%>/alfrescovp?token=<%=token%>&archivo=<%=archivo%>"></iframe>
</div>
<%
    } else if (reporte.equals("10")) {
        //Agregamos a la tabla de Refetencias Temporales
        BeanTemporal objBeanT = new BeanTemporal();
        objBeanT.setVTEMP_USUARIO(objBeanU.getVUSUARIO_CODIGO());
        objBeanT.setCTEMP_CODORG(objBeanU.getCUSUARIO_COD_ORG());
        objBeanT.setCTEMP_PERIODO(periodo);
        objBeanT.setCTEMP_COD_DOC(documento);
        objBeanT.setVTEMP_TOKEN(token);
        objFD.insertarReferenciaTemporal(objBeanT);
        //Agregamos a la coleccion de distribucion
        BeanDistribucion objBeanDI = objFD.obtenerDistribucion(tipoorigen, internaorigen);
        objBeanDI.setTipo("T");
        ArrayList distribucion = new ArrayList();
        distribucion.add(objBeanDI);
        session.setAttribute("distribucion", distribucion);
    }

%>