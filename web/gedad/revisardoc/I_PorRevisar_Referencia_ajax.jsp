<%@page import="sagde.bean.BeanPrioridadDocumento"%>
<%@page import="sagde.bean.BeanPeriodo"%>
<%@page import="sagde.bean.BeanClase"%>
<%@page import="comun.ComboboxDAO"%>
<%@page import="sagde.bean.BeanReferencia"%>
<%@page import="sagde.bean.BeanOrganizacionExterna"%>
<%@page import="sagde.bean.BeanOrganizacionInterna"%>
<%@page import="sagde.bean.BeanDistribucion"%>
<%@page import="sagde.bean.BeanArchivo"%>
<%@page import="java.util.Iterator"%>
<%@page import="comun.FormularDocumentoDAO"%>
<%@page import="sagde.bean.BeanRevisarDocumento"%>
<%@page import="java.util.ArrayList"%>
<%@page import="sagde.bean.BeanUsuarioAD"%>
<%@page import="comun.RevisaDocumentoDAO"%>
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



<%
    String hora = (String) request.getParameter("pasacache");
    String reporte = (String) request.getParameter("reporte");
    String tiempo = (String) request.getParameter("t");

    DAOFactory objDF = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
    RevisaDocumentoDAO objRD = objDF.getRevisaDocumentoDAO();
    FormularDocumentoDAO objFD = objDF.getFormularDocumentoDAO();
    ComboboxDAO objCombobox = objDF.getComboboxDAO();
    session = request.getSession(true);
    BeanUsuarioAD objbean = (BeanUsuarioAD) session.getAttribute("usuario");

    ArrayList ListaBusqReferencia = null;
    ArrayList ListaReferencia = null;

    /*
    REF_01. BUSQUEDA DE REFERENCIAS SEGUN CRITERIOS
    REF_02. DEVUELVE COMBO ORGANIZACION SEGUN PARAMETRO TIPO DE ORGANIZACION
    REF_03. GRABA UNA REFERENCIA Y DEVUELVE LA LISTA
    REF_04. DEVUELVE REFERENCIAS AL OFICIO
    REF_05. LISTA REFERENCIAS
    REF_06. INVOCA A SERVLET PARA HACER VISTA PREVIA DE REFERENCIA
    REF_07. DEVUELVE FORMULARIO PARA BUSQUEDA DE REFERENCIA
    REF_08. DEVUELVE FORMULARIO PARA REGISTRO DE REFERENCIA    
    REF_09. ELIMINA UNA REFERENCIA Y RETORNA LISTA
     */
 /*
  
    *Formulario Ajax (01). Mostrará la Distribucion --------------------------------------------------------------------------------------------------->
     */
    if (reporte.equals("REF_01")) {

        String cbo_Tipo_Organizacion = (String) request.getParameter("cbo_Tipo_Organizacion");
        String org_ref = (String) request.getParameter("org_ref");
        String txtFecDesde = (String) request.getParameter("txtFecDesde");
        String txtFecHasta = (String) request.getParameter("txtFecHasta");
        String cbx_Clase_Doc = (String) request.getParameter("cbx_Clase_Doc");
        String txt_nro_doc = (String) request.getParameter("txt_nro_doc");
        String txt_Asunto_Ref = (String) request.getParameter("txt_Asunto_Ref");
        String cbo_Periodo = (String) request.getParameter("cbo_Periodo");
        String cbo_Periodo_origen = (String) request.getParameter("cbo_Periodo_origen");
        String cbo_codint_origen = (String) request.getParameter("cbo_codint_origen");

        String cod_org_usu = objbean.getCUSUARIO_COD_ORG();
        String cod_org_jefe = objbean.getJEFE_UNIDAD();

        ListaBusqReferencia = (ArrayList) objRD.RD_ObtenerBusqReferencia(cbo_Tipo_Organizacion, org_ref, txtFecDesde, txtFecHasta, cbx_Clase_Doc, txt_nro_doc, txt_Asunto_Ref, cbo_Periodo, cod_org_usu, cod_org_jefe);

        //System.out.println("cuantos hay ListaBusqReferencia--" + ListaBusqReferencia.size());
        if (ListaBusqReferencia != null) {
%>
<table class="display" id="listaReferenciaBusqueda" width="100%"  border="1">
    <thead>
        <tr style="background-color:#B0B199">              
            <th><div align="center">AÑO</div></th>
            <th><div align="center">CLASE</div></th>
            <th><div align="center">NRO</div></th>
            <th><div align="center">FECHA</div></th>
            <th><div align="center">ASUNTO</div></th>
            <th><div align="center">AGREGAR</div></th>
        </tr>
    </thead>
    <tbody>
        <%
            for (int i = 0; i < ListaBusqReferencia.size(); i++) {
                BeanReferencia objBeanD = (BeanReferencia) ListaBusqReferencia.get(i);
        %>
        <tr>
            <td><%=objBeanD.getCDOCUMENTO_PERIODO()%></td>
            <td><%=objBeanD.getVCLASE_NOM_CORTO()%></td>
            <td><%=objBeanD.getCDOCUMENTO_NRO_ORDEN()%></td>
            <td><%=objBeanD.getFECHA_DOC_ORIGEN()%></td>
            <td><%=objBeanD.getVDOCUMENTO_ASUNTO()%></td>
            <td><div align="center"><a href="javascript:f_agrega_refe('<%=objBeanD.getCDOCUMENTO_PERIODO()%>','<%=objBeanD.getCDOCUMENTO_COD_DOC_INT()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/adjuntar.png" width="20px" height="20px" /></a></div></td>
        </tr>
        <%}%>
    </tbody>
</table>


<%}

} else if (reporte.equals("REF_02")) {

    String tipo = (String) request.getParameter("tipo");

    out.println("<select name='org_ref' id='org_ref'  class='selectpicker form-control' data-live-search='true'   >");

    if (tipo.equals("I")) {
        out.println("<option>--Elija ORG EJERCITO--</option>");
        Iterator iteratorOrgI = objCombobox.obtenerOrganizacionEjercito_MP().iterator();
        while (iteratorOrgI.hasNext()) {
            BeanOrganizacionInterna beanorgi = (BeanOrganizacionInterna) iteratorOrgI.next();
            out.println("<option value=" + beanorgi.getCOINTERNA_CODIGO() + ">" + beanorgi.getVOINTERNA_NOM_CORTO() + "</option>");
        }

    } else if (tipo.equals("E")) {
        out.println("<option>--Elija ORG EXTERNA--</option>");
        Iterator iteratorOrgE = objFD.obtenerOrganizacionExterna().iterator();
        while (iteratorOrgE.hasNext()) {
            BeanOrganizacionExterna beanorge = (BeanOrganizacionExterna) iteratorOrgE.next();
            out.println("<option  value=" + beanorge.getCodigo() + ">" + beanorge.getNombre() + "</option>");
        }
    }
    out.println("</select>");

} else if (reporte.equals("REF_03")) {

    String periodo_ref = (String) request.getParameter("periodo_ref");
    String codint_ref = (String) request.getParameter("codint_ref");
    String periodo_orig = (String) request.getParameter("periodo_orig");
    String codint_orig = (String) request.getParameter("codint_orig");

    //System.out.println("periodo_orig--" + periodo_orig + "codint_orig--" + codint_orig + "periodo_ref" + periodo_ref + "codint_orig" + codint_orig);
    ListaReferencia = (ArrayList) objRD.grabareferencia(periodo_ref, codint_ref, periodo_orig, codint_orig);
    //System.out.println("cuantos hay ListaReferencia--" + ListaReferencia.size());
    session.setAttribute("ListaReferencia", ListaReferencia);

    if (ListaReferencia != null) {
%>

<table class="display" id="listaReferencia" width="100%" border="1">
    <thead>
        <tr style="background-color:#B0B199 ">              
            <th><div align="center">ORDEN</div></th>
            <th><div align="center">CLASE</div></th>
            <th><div align="center">NRO</div></th>
            <th><div align="center">INDICATIVO</div></th>
            <th><div align="center">FECHA</div></th>
            <th><div align="center">VER</div></th>
            <th><div align="center">ELIMINAR</div></th>
        </tr>
    </thead>
    <tbody>
        <%
            for (int i = 0; i < ListaReferencia.size(); i++) {
                BeanReferencia objBeanD = (BeanReferencia) ListaReferencia.get(i);
        %>
        <tr>
            <td><%=objBeanD.getORDEN_REF()%></td>
            <td><%=objBeanD.getVCLASE_NOM_CORTO()%></td>
            <td><%=objBeanD.getCDOCUMENTO_NRO_ORDEN()%></td>
            <td><%=objBeanD.getVDOCUMENTO_CLAVE_INDIC()%></td>
            <td><%=objBeanD.getFECHA_DOC_ORIGEN()%></td>
            <td><div align="center"><a href="javascript:f_MostraReferencia('<%=objBeanD.getCREFERENCIA_PERIODO_ORIG()%>','<%=objBeanD.getCREFERENCIA_COD_DOC_ORIG()%>','<%=objBeanD.getCREFERENCIA_PERIODO_REF()%>','<%=objBeanD.getCREFERENCIA_COD_DOC_REF()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/ver_anexos.png" width="20px" height="20px" /></a></div></td>
            <td><div align="center"><a href="javascript:f_eliminarReferencia('<%=objBeanD.getCREFERENCIA_PERIODO_ORIG()%>','<%=objBeanD.getCREFERENCIA_COD_DOC_ORIG()%>','<%=objBeanD.getCREFERENCIA_PERIODO_REF()%>','<%=objBeanD.getCREFERENCIA_COD_DOC_REF()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/delete.png" width="20px" height="20px" /></a></div></td>
        </tr>
        <%}%>
    </tbody>
</table>


<%
    }
} else if (reporte.equals("REF_04")) {

    String periodo_orig = (String) request.getParameter("periodo_orig");
    String codint_orig = (String) request.getParameter("codint_orig");
    ListaReferencia = (ArrayList) objRD.Listareferencia(periodo_orig, codint_orig);
    session.setAttribute("ListaReferencia", ListaReferencia);

    if (ListaReferencia != null) {

        for (int i = 0; i < ListaReferencia.size(); i++) {
            BeanReferencia objBeanD = (BeanReferencia) ListaReferencia.get(i);
%>
<%=objBeanD.getORDEN_REF()%>&nbsp;<%=objBeanD.getVCLASE_NOM_CORTO()%>&nbsp;Nº<%=objBeanD.getCDOCUMENTO_NRO_ORDEN()%>&nbsp;<%=objBeanD.getVDOCUMENTO_CLAVE_INDIC()%>&nbsp;del&nbsp;<%=objBeanD.getFECHA_DOC_ORIGEN()%><br>
<%}
    }
} else if (reporte.equals("REF_05")) {
    String periodo_orig = (String) request.getParameter("periodo_orig");
    String codint_orig = (String) request.getParameter("codint_orig");
    ListaReferencia = (ArrayList) objRD.Listareferencia(periodo_orig, codint_orig);
    session.setAttribute("ListaReferencia", ListaReferencia);

    if (ListaReferencia != null) {
%>

<table class="display" id="listaReferencia" width="100%"  border="1">
    <thead>
        <tr style="background-color:#B0B199 ">              
            <th style="width: 17%"><div align="center">ORDEN</div></th>
            <th style="width: 17%"><div align="center">CLASE</div></th>
            <th style="width: 17%"><div align="center">NRO</div></th>
            <th style="width: 17%"><div align="center">INDICATIVO</div></th>
            <th style="width: 17%"><div align="center">FECHA</div></th>
            <th style="width: 7%"><div align="center">VER</div></th>
            <th style="width: 8%"><div align="center">ELIMINAR</div></th>
        </tr>
    </thead>

    <tbody>
        <%
            for (int i = 0; i < ListaReferencia.size(); i++) {
                BeanReferencia objBeanD = (BeanReferencia) ListaReferencia.get(i);

        %>
        <tr>
            <td><%=objBeanD.getORDEN_REF()%></td>
            <td><%=objBeanD.getVCLASE_NOM_CORTO()%></td>
            <td><%=objBeanD.getCDOCUMENTO_NRO_ORDEN()%></td>
            <td><%=objBeanD.getVDOCUMENTO_CLAVE_INDIC()%></td>
            <td><%=objBeanD.getFECHA_DOC_ORIGEN()%></td>
            <td><div align="center"><a href="javascript:f_MostraReferencia('<%=objBeanD.getCREFERENCIA_PERIODO_ORIG()%>','<%=objBeanD.getCREFERENCIA_COD_DOC_ORIG()%>','<%=objBeanD.getCREFERENCIA_PERIODO_REF()%>','<%=objBeanD.getCREFERENCIA_COD_DOC_REF()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/ver_anexos.png" width="20px" height="20px" /></a></div></td>
            <td><div align="center"><a href="javascript:f_eliminarReferencia('<%=objBeanD.getCREFERENCIA_PERIODO_ORIG()%>','<%=objBeanD.getCREFERENCIA_COD_DOC_ORIG()%>','<%=objBeanD.getCREFERENCIA_PERIODO_REF()%>','<%=objBeanD.getCREFERENCIA_COD_DOC_REF()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/delete.png" width="20px" height="20px" /></a></div></td>
        </tr>
        <%}%>
    </tbody>

</table>



<%
    }
} else if (reporte.equals("REF_06")) {
    String periodo_origen = (String) request.getParameter("periodo_origen");
    String cod_int_origen = (String) request.getParameter("cod_int_origen");
    String periodo_ref = (String) request.getParameter("periodo_ref");
    String cod_int_ref = (String) request.getParameter("cod_int_ref");
%>
<div class="embed-responsive embed-responsive-16by9">
    <iframe class="embed-responsive-item" src="<%= request.getContextPath()%>/mostrarReferencia?periodo_origen=<%=periodo_origen%>&cod_int_origen=<%=cod_int_origen%>&periodo_ref=<%=periodo_ref%>&cod_int_ref=<%=cod_int_ref%>"></iframe>
</div>
<%

} else if (reporte.equals("REF_07")) {

%>
<table width="100%" >
    <tr>
        <td>
            <table width="100%">
                <tr>
                    <td width="30%"><div align="left" class="EstiloOF">Año</div></td>
                    <td width="5%">&nbsp;</td>                    
                    <td width="30%"><div align="left" class="EstiloOF">Tipo Organizacion</div></td>
                    <td width="5%">&nbsp;</td>
                    <td width="30%"><div align="left" class="EstiloOF">Organización</div></td>
                </tr>
                <tr>
                    <td>
                        <select name="cbo_Periodo" id="cbo_Periodo" class='form-control selectpicker' data-live-search='true'>
                            <option >2018</option>
                            <option >2017</option>
                            <option >2016</option>
                        </select>   
                    </td>
                    <td>&nbsp;</td>
                    <td><select name="cbo_Tipo_Organizacion" class="form-control" id="cbo_Tipo_Organizacion" onchange="javascript:f_org_referencia(this.value);">
                            <option value="I">Interna</option>
                            <option value="E">Externa</option> 
                        </select>
                    </td>  
                    <td>&nbsp;</td>
                    <td>
                        <div id="dis_org_ref">
                            <select name='org_ref' id='org_ref'  class='form-control selectpicker' data-live-search='true'   >
                                <%                                                                  Iterator iteratorOrgI = objCombobox.obtenerOrganizacionEjercito_MP().iterator();
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
                    <td><div align="left" class="EstiloOF">Clase Documento</div></td>
                    <td>&nbsp;</td>
                    <td ><div align="left" class="EstiloOF">Nro Documento</div></td>
                    <td>&nbsp;</td>
                    <td ><div align="left" class="EstiloOF">Desde</div></td>   
                    <td>&nbsp;</td>
                    <td ><div align="left" class="EstiloOF">Hasta</div></td>  
                </tr>
                <tr>
                    <td><select name='cbx_Clase_Doc' id='cbx_Clase_Doc' class='form-control selectpicker' data-live-search='true'   >
                            <%                                                                    Iterator iteratorClaseDoc = objCombobox.obtenerClaseDocumento().iterator();
                                while (iteratorClaseDoc.hasNext()) {
                                    BeanClase beanclase = (BeanClase) iteratorClaseDoc.next();
                                    out.println("<option value=" + beanclase.getCCLASE_CODIGO() + ">" + beanclase.getVCLASE_NOM_LARGO() + "</option>");
                                }

                            %>  
                        </select>
                    </td>
                    <td>&nbsp;</td>
                    <td><div align="left" class="EstiloOF">
                            <input name="txt_nro_doc" id="txt_nro_doc" type="text" class="form-control"  />
                        </div>
                    </td>
                    <td>&nbsp;</td>
                    <td><div align="left" class="EstiloOF">
                            <input type="text" class="form-control datepicker" name="txtFecDesde" id="txtFecDesde" size="10" maxlength="10" value="01/01/2018"/>
                        </div>
                    </td>
                    <td>&nbsp;</td>
                    <td><div align="left" class="EstiloOF"><div align="left" class="EstiloOF">
                                <input type="text" class="form-control datepicker" name="txtFecHasta" id="txtFecHasta" size="10" maxlength="10" value="31/12/2018"/>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>                    
                    <td colspan="5"><div align="left" class="EstiloOF">Asunto</div></td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                </tr>
                <tr>                    
                    <td colspan="5"><div align="left" ><input name="txt_Asunto_Ref" id="txt_Asunto_MP"   type="text" class="form-control"  /></div></td> 
                    <td>&nbsp;</td>
                    <td>
                        <button class="btn btn-info btn-info" style="width: 100%" type="button" onclick="javascript:f_Buscar_Referencia();"><b>BUSQUEDA</b></button> 
                    </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr height="20px"></tr>
    <!-- Para la tabla de Referencia -->   
    <tr>
        <td>
            <div id="modalListaBusRef">

            </div>

        </td>
    </tr>
</table>

<% } else if (reporte.equals("REF_08")) {
%>
<table width="100%" >
    <tr>                        
        <td colspan="6"  style="background: #D4FD89">
            <div align="left"><span style="color:rgb(111, 111, 111); font-family: tahoma"><u>I. Datos del la Organización que Remite : </u></span></div>
        </td>    
    </tr>
    <tr>
        <td>
            <table width="100%" >
                <tr>
                    <td width="2%">&nbsp</td>
                    <td width="15%"><div align="left" class="EstiloOF">Año</div></td>
                    <td width="2%">&nbsp</td>
                    <td width="39%"><div align="left" class="EstiloOF">Tipo Organización</div> </td>
                    <td width="2%">&nbsp;</td>
                    <td width="40%"><div align="left" class="EstiloOF">Organización</div> </td>
                </tr>
                <tr>
                    <td>&nbsp;&nbsp;</td>
                    <td><select name="cbo_Periodo_Agr_ref" class="form-control selectpicker" id="cbo_Periodo_Agr_ref" data-live-search='true'>
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
                    <td><select name="cbo_Tipo_Organizacion_Agr_Ref" class="form-control selectpicker" data-live-search='true' id="cbo_Tipo_Organizacion_Agr_Ref" onchange="f_org_referencia(this.value)">
                            <option value="I">Interna</option>
                            <option value="E">Externa</option> 
                        </select>
                    <td>&nbsp;&nbsp;</td>
                    </td>
                    <td><div id="dis_org_ref">
                            <select name='org_Agr_Ref' id='org_Agr_Ref'  class='form-control selectpicker' data-live-search='true'   >
                                <%                                                                                Iterator iteratorOrgI1 = objCombobox.obtenerOrganizacionEjercito_MP().iterator();
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
<table width="100%" >
    <tr width="100%" >                        
        <td colspan="6"  style="background: #D4FD89">
            <div align="left"><span style="color:rgb(111, 111, 111); font-family: tahoma"><u>II. Datos del documento : </u></span></div>
        </td>       
    </tr>
    <tr width="100%" >
        <td>
            <table width="100%" >
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
                            <select name='cbx_Clase_Doc_Agr_Ref' id='cbx_Clase_Doc_Agr_Ref'  class='form-control selectpicker' data-live-search='true'   >
                                <%                                                                                Iterator iteratorClaseDoc1 = objCombobox.obtenerClaseDocumento().iterator();
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
                            <select name='cbx_Clasificacion_Agr_Ref' id='cbx_Clasificacion_Agr_Ref'  class='form-control selectpicker' data-live-search='true'   >
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
                            <select name='cbx_Prioridad_Agr_Ref' id='cbx_Prioridad_Agr_Ref'  class='form-control selectpicker' data-live-search='true'   >
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
<table width="100%" >
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
                            <table width="30%">
                                <tr>
                                    <td width="45%"><button class="btn btn-success btn-reset form-control" type="button" onclick="javascript:f_Grabar_Referencia();"><b>GRABAR</b></button></td>
                                    <td width="10%">&nbsp;</td>
                                    <td width="45%"><button class="btn btn-danger btn-info form-control" type="button" onclick="javascript:f_cancelar();"><b>CANCELAR</b></button></td>
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
<%} else if (reporte.equals("REF_11")) {
    String periodo_ref = (String) request.getParameter("periodo_ref");
    String codint_ref = (String) request.getParameter("codint_ref");
    String periodo_orig = (String) request.getParameter("periodo_orig");
    String codint_orig = (String) request.getParameter("codint_orig");

    ListaReferencia = (ArrayList) objRD.eliminaReferencia(periodo_orig, codint_orig, periodo_ref, codint_ref);
    session.setAttribute("ListaReferencia", ListaReferencia);

    if (ListaReferencia != null) {
%>

<table class="display" id="listaReferencia" width="100%" border="1">
    <thead>
        <tr style="background-color:#B0B199 ">              
            <th><div align="center">ORDEN</div></th>
            <th><div align="center">CLASE</div></th>
            <th><div align="center">NRO</div></th>
            <th><div align="center">INDICATIVO</div></th>
            <th><div align="center">FECHA</div></th>
            <th><div align="center">VER</div></th>
            <th><div align="center">ELIMINAR</div></th>
        </tr>
    </thead>
    <tbody>
        <%
            for (int i = 0; i < ListaReferencia.size(); i++) {
                BeanReferencia objBeanD = (BeanReferencia) ListaReferencia.get(i);
        %>
        <tr>
            <td><%=objBeanD.getORDEN_REF()%></td>
            <td><%=objBeanD.getVCLASE_NOM_CORTO()%></td>
            <td><%=objBeanD.getCDOCUMENTO_NRO_ORDEN()%></td>
            <td><%=objBeanD.getVDOCUMENTO_CLAVE_INDIC()%></td>
            <td><%=objBeanD.getFECHA_DOC_ORIGEN()%></td>
            <td><div align="center"><a href="javascript:f_MostraReferencia('<%=objBeanD.getCREFERENCIA_PERIODO_ORIG()%>','<%=objBeanD.getCREFERENCIA_COD_DOC_ORIG()%>','<%=objBeanD.getCREFERENCIA_PERIODO_REF()%>','<%=objBeanD.getCREFERENCIA_COD_DOC_REF()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/ver_anexos.png" width="20px" height="20px" /></a></div></td>
            <td><div align="center"><a href="javascript:f_eliminarReferencia('<%=objBeanD.getCREFERENCIA_PERIODO_ORIG()%>','<%=objBeanD.getCREFERENCIA_COD_DOC_ORIG()%>','<%=objBeanD.getCREFERENCIA_PERIODO_REF()%>','<%=objBeanD.getCREFERENCIA_COD_DOC_REF()%>');"><img src="<%=request.getContextPath()%>/imagenes/icono/delete.png" width="20px" height="20px" /></a></div></td>
        </tr>
        <%}%>
    </tbody>
</table>
<%
        }
    }%>