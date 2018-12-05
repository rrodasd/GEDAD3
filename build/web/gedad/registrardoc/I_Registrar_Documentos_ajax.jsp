<%@page import="sagde.bean.BeanPrioridadDocumento"%>
<%@page import="sagde.bean.BeanClase"%>
<%@page import="sagde.bean.BeanAnexo"%>
<%@page import="comun.RevisaDocumentoDAO"%>
<%@page import="sagde.bean.BeanDocumento1"%>
<%@page import="comun.DocumentoDAO"%>
<%@page import="sagde.bean.BeanOrganizacionExterna"%>
<%@page import="comun.FormularDocumentoDAO"%>
<%@page import="sagde.bean.BeanOrganizacionInterna"%>
<%@page import="sagde.bean.BeanPeriodo"%>
<%@page import="sagde.bean.BeanUsuarioAD"%>
<%@page import="comun.ComboboxDAO"%>
<%@taglib uri="/WEB-INF/tlds/libreria.tld" prefix="lb"%>
<%@page import="comun.DAOFactory"%>
<%@page import="java.util.*"%>
<%@page import="org.apache.commons.fileupload.*"%>
<%@page import="java.io.File"%>

<%
    String pasacache = (String) request.getParameter("pasacache");
    String reporte = (String) request.getParameter("reporte");
    
    
    
    DAOFactory objDF = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
    DocumentoDAO objRegDOc = objDF.getDocumentoDAO();
    FormularDocumentoDAO objFD = objDF.getFormularDocumentoDAO();
    RevisaDocumentoDAO objRD = objDF.getRevisaDocumentoDAO();    
    ComboboxDAO objCombobox = objDF.getComboboxDAO();     
    session = request.getSession(true);
    BeanUsuarioAD objbean = (BeanUsuarioAD) session.getAttribute("usuario");
    
    String periodo=null;
    ArrayList ListarAnexos=null;
     
 if (reporte.equals("REG_DOC_01")) {//Muestra Gestión PDF
            
     String tipo = (String) request.getParameter("tipo");   
     
        out.println("<select name='org' id='org'  class='selectpicker' data-live-search='true'   >");
       
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

    }


else if(reporte.equals("REG_DOC_02")){   
    
    BeanUsuarioAD beanusuario = (BeanUsuarioAD) session.getAttribute("usuario");     
    String cod_org_usuario = beanusuario.getCUSUARIO_COD_ORG();
    String cod_org_jefe_unidad = beanusuario.getJEFE_UNIDAD();         
    ArrayList listardocumento = (ArrayList) objRegDOc.obtenerFullDocumento(cod_org_usuario,cod_org_jefe_unidad,"Recepcion"); 
  
    if(listardocumento != null){
%>
        <table class="display" width="100%" border="1" id="example">
                                <thead>
                                     <tr bgcolor="#B0B199">                                      
                                        <th width="10%"><div align="center">AÑO</div></th>
                                        <th width="20%"><div align="center">FECHA_REG</div></th>
                                        <th width="20%"><div align="center">CODIGO GEDAD</div></th>                                        
                                        <th width="20%"><div align="center">DEP ORIGEN</div></th>
                                        <th width="10%"><div align="center">CLASE</div></th>
                                        <th width="10%"><div align="center">NRO. DOC</div></th>
                                        <th width="10%"><div align="center">FECHA DOC</div></th>
                                        <th width="500px"><div align="center">ASUNTO_DEL_DOCUMENTO</div></th>
                                        <th width="20px"><div align="center">PRIORIDAD</div></th>
                                        <th width="20px"><div align="center">TIPO DISTRIBUCIÓN</div></th>
                                        <th width="30%"><div align="center">ACTUALIZAR</div></th>
                                        <th width="30%"><div align="center">VER DOC</div></th>
                                        <th width="30%"><div align="center">VER ANEXO</div></th>                                         
                                        <th width="30%"><div align="center">ELIMINAR</div></th>    

                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                     for (int i = 0; i < listardocumento.size(); i++) {
                                            BeanDocumento1 objBeanC = (BeanDocumento1) listardocumento.get(i);
                                    %>
                                     <tr>                                        
                                        <td><div align="center"><%=objBeanC.getCDOCUMENTO_PERIODO()%></div></td>
                                        <td><div align="center"><%=objBeanC.getDDOCUMENTO_FEC_ACT()%></div></td>
                                        <td bgcolor="#CCD272" ><div align="center"><%=objBeanC.getCDOCUMENTO_COD_DOC_INT()%></div></td>
                                        <td><div align="center"><%=objBeanC.getCDOCUMENTO_COD_ORG_ORIG()%></div></td>
                                        <td><div align="center"><%=objBeanC.getCDOCUMENTO_CLASE()%></div></td>
                                        <td><div align="center"><%=objBeanC.getCDOCUMENTO_NRO_ORDEN()%></div></td>
                                        <td><div align="center"><%=objBeanC.getDDOCUMENTO_FECHA()%></div></td>
                                        <td><div align="center"><%=objBeanC.getVDOCUMENTO_ASUNTO()%></div></td> 
                                        <td><div align="center"><%=objBeanC.getCDOCUMENTO_PRIORIDAD()%></div></td> 
                                         <td><div align="center"><%=objBeanC.getCDISTRIBUCION_TIPO_DISTRIB()%></div></td> 
                                        <td  width="200px"><div align="center">ACTUALIZAR</div></td> 
                                        <td><div align="center">  
                                                <%if (objBeanC.getVDISTRIBUCION_TOKEN()==null){                                                    
                                                %>
                                                <a href="javascript:f_verPDF('<%=objBeanC.getCDOCUMENTO_PERIODO()%>','<%=objBeanC.getCDOCUMENTO_COD_DOC_INT()%>','I','<%=objbean.getJEFE_UNIDAD()%>','<%=objBeanC.getVDISTRIBUCION_TOKEN()%>');">
                                                    <img src="imagenes/icono/noexiste.png" width="35" height="35" border="0" /></a>
                                                  
                                                <%}else {%>
                                                 <a href="javascript:f_verPDF('<%=objBeanC.getCDOCUMENTO_PERIODO()%>','<%=objBeanC.getCDOCUMENTO_COD_DOC_INT()%>','I','<%=objbean.getJEFE_UNIDAD()%>','<%=objBeanC.getVDISTRIBUCION_TOKEN()%>');">
                                                    <img src="imagenes/icono/pdf.png" width="35" height="35" border="0" /></a>
                                                
                                                <%}%>
                                            </div>
                                        </td> 
                                        <td><div align="center">   
                                                <a href="javascript:f_openAnexoVentana('<%=objBeanC.getCDOCUMENTO_PERIODO()%>','<%=objBeanC.getCDOCUMENTO_COD_DOC_INT()%>' );">
                                                    <img src="imagenes/icono/anexos.fw.png" width="35" height="35" border="0" /></a>
                                            </div></td> 
                                       
                                        <td><div align="center">   
                                                <a href="javascript:eliminar('<%=objBeanC.getCDOCUMENTO_PERIODO()%>','<%=objBeanC.getCDOCUMENTO_COD_DOC_INT()%>');">
                                                    <img src="imagenes/icono/delete.png" width="35" height="35" border="0" /></a>
                                            </div></td> 

                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>
   <%}else {

    %>
    <table class="display" width="100%" border="1">
         <thead>
                                     <tr bgcolor="#B0B199">                                      
                                        <th width="10%"><div align="center">AÑO</div></th>
                                        <th width="20%"><div align="center">FECHA_REG</div></th>
                                        <th width="20%"><div align="center">CODIGO GEDAD</div></th>                                        
                                        <th width="20%"><div align="center">DEP ORIGEN</div></th>
                                        <th width="10%"><div align="center">CLASE</div></th>
                                        <th width="10%"><div align="center">NRO. DOC</div></th>
                                        <th width="10%"><div align="center">FECHA DOC</div></th>
                                        <th width="500px"><div align="center">ASUNTO_DEL_DOCUMENTO</div></th>
                                        <th width="20px"><div align="center">PRIORIDAD</div></th>
                                        <th width="20px"><div align="center">TIPO DISTRIBUCIÓN</div></th>
                                        <th width="30%"><div align="center">ACTUALIZAR</div></th>
                                        <th width="30%"><div align="center">VER DOC</div></th>
                                        <th width="30%"><div align="center">VER ANEXO</div></th>                                         
                                        <th width="30%"><div align="center">ELIMINAR</div></th>    

                                    </tr>
          </thead>
    </table>


<%
    }

}else if(reporte.equals("REG_DOC_03")){
   String periodo_mp = (String) request.getParameter("periodo");   
   String cod_int = (String) request.getParameter("cod_int"); 
   String tipo_org = (String) request.getParameter("tipo_org");
   String organizacion_jefe = (String) request.getParameter("organizacion_jefe");
   String token = (String) request.getParameter("token");

%>
<div class="embed-responsive embed-responsive-16by9">
    <iframe class="embed-responsive-item"  src="<%= request.getContextPath() %>/mostrarPDF_MP?periodo_mp=<%=periodo_mp%>&cod_int=<%=cod_int%>&tipo_org=<%=tipo_org%>&organizacion_jefe=<%=organizacion_jefe%>&token=<%=token%>"></iframe>
</div>

<%
}else if(reporte.equals("REG_DOC_04")){
   String periodo_mp = (String) request.getParameter("periodo");   
   String cod_int = (String) request.getParameter("cod_int");   
   String cod_jefe_unidad = objbean.getJEFE_UNIDAD();  
   objRegDOc.eliminarRegistro_MP(periodo_mp,cod_int,cod_jefe_unidad); 

   String cod_org_usuario = objbean.getCUSUARIO_COD_ORG();
   String cod_org_jefe_unidad = objbean.getJEFE_UNIDAD();         

    ArrayList listardocumento = (ArrayList) objRegDOc.obtenerFullDocumento(cod_org_usuario,cod_org_jefe_unidad,"Recepcion");           
           
    if(listardocumento != null){
   %> 
     <table class="display" width="100%" border="1" id="example">
                                <thead>
                                   <tr bgcolor="#B0B199">                                      
                                        <th width="10%"><div align="center">AÑO</div></th>
                                        <th width="20%"><div align="center">FECHA_REG</div></th>
                                        <th width="20%"><div align="center">CODIGO GEDAD</div></th>                                        
                                        <th width="20%"><div align="center">DEP ORIGEN</div></th>
                                        <th width="10%"><div align="center">CLASE</div></th>
                                        <th width="10%"><div align="center">NRO. DOC</div></th>
                                        <th width="10%"><div align="center">FECHA DOC</div></th>
                                        <th width="500px"><div align="center">ASUNTO_DEL_DOCUMENTO</div></th>
                                         <th width="20px"><div align="center">PRIORIDAD</div></th>
                                         <th width="20px"><div align="center">TIPO DISTRIBUCIÓN</div></th>
                                        <th width="30%"><div align="center">ACTUALIZAR</div></th>
                                        <th width="30%"><div align="center">VER DOC</div></th>
                                        <th width="30%"><div align="center">VER ANEXO</div></th>                                         
                                        <th width="30%"><div align="center">ELIMINAR</div></th>    

                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                       

                                        for (int i = 0; i < listardocumento.size(); i++) {
                                            BeanDocumento1 objBeanC = (BeanDocumento1) listardocumento.get(i);
                                    %>
                                    <tr>                                        
                                        <td><div align="center"><%=objBeanC.getCDOCUMENTO_PERIODO()%></div></td>
                                        <td><div align="center"><%=objBeanC.getDDOCUMENTO_FEC_ACT()%></div></td>
                                        <td bgcolor="#CCD272" ><div align="center"><%=objBeanC.getCDOCUMENTO_COD_DOC_INT()%></div></td>
                                        <td><div align="center"><%=objBeanC.getCDOCUMENTO_COD_ORG_ORIG()%></div></td>
                                        <td><div align="center"><%=objBeanC.getCDOCUMENTO_CLASE()%></div></td>
                                        <td><div align="center"><%=objBeanC.getCDOCUMENTO_NRO_ORDEN()%></div></td>
                                        <td><div align="center"><%=objBeanC.getDDOCUMENTO_FECHA()%></div></td>
                                        <td><div align="center"><%=objBeanC.getVDOCUMENTO_ASUNTO()%></div></td> 
                                        <td><div align="center"><%=objBeanC.getCDOCUMENTO_PRIORIDAD()%></div></td> 
                                         <td><div align="center"><%=objBeanC.getCDISTRIBUCION_TIPO_DISTRIB()%></div></td> 
                                        <td  width="200px"><div align="center">ACTUALIZAR</div></td> 
                                        <td><div align="center">  
                                                <%if (objBeanC.getVDISTRIBUCION_TOKEN()==null){                                                    
                                                %>
                                                <a href="javascript:f_verPDF('<%=objBeanC.getCDOCUMENTO_PERIODO()%>','<%=objBeanC.getCDOCUMENTO_COD_DOC_INT()%>','I','<%=objbean.getJEFE_UNIDAD()%>','<%=objBeanC.getVDISTRIBUCION_TOKEN()%>');">
                                                    <img src="imagenes/icono/noexiste.png" width="35" height="35" border="0" /></a>
                                                  
                                                <%}else {%>
                                                 <a href="javascript:f_verPDF('<%=objBeanC.getCDOCUMENTO_PERIODO()%>','<%=objBeanC.getCDOCUMENTO_COD_DOC_INT()%>','I','<%=objbean.getJEFE_UNIDAD()%>','<%=objBeanC.getVDISTRIBUCION_TOKEN()%>');">
                                                    <img src="imagenes/icono/pdf.png" width="35" height="35" border="0" /></a>
                                                
                                                <%}%>
                                            </div>
                                        </td> 
                                        <td><div align="center">   
                                                <a href="javascript:f_openAnexoVentana('<%=objBeanC.getCDOCUMENTO_PERIODO()%>','<%=objBeanC.getCDOCUMENTO_COD_DOC_INT()%>' );">
                                                    <img src="imagenes/icono/anexos.fw.png" width="35" height="35" border="0" /></a>
                                            </div></td> 
                                       
                                        <td><div align="center">   
                                                <a href="javascript:eliminar('<%=objBeanC.getCDOCUMENTO_PERIODO()%>','<%=objBeanC.getCDOCUMENTO_COD_DOC_INT()%>');">
                                                    <img src="imagenes/icono/delete.png" width="35" height="35" border="0" /></a>
                                            </div></td> 

                                    </tr>
                                    <%}%>
                                </tbody>
                            </table>

<%
 }else {
%>

<table class="display" width="100%" border="1">
         <thead>
                                    <tr bgcolor="#B0B199">                                      
                                        <th width="10%"><div align="center">AÑO</div></th>
                                        <th width="20%"><div align="center">FECHA_REG</div></th>
                                        <th width="20%"><div align="center">CODIGO GEDAD</div></th>                                        
                                        <th width="20%"><div align="center">DEP ORIGEN</div></th>
                                        <th width="10%"><div align="center">CLASE</div></th>
                                        <th width="10%"><div align="center">NRO. DOC</div></th>
                                        <th width="10%"><div align="center">FECHA DOC</div></th>
                                        <th width="500px"><div align="center">ASUNTO_DEL_DOCUMENTO</div></th>
                                        <th width="20px"><div align="center">TIPO DISTRIBUCIÓN</div></th>
                                        <th width="30%"><div align="center">ACTUALIZAR</div></th>
                                        <th width="30%"><div align="center">VER DOC</div></th>
                                        <th width="30%"><div align="center">VER ANEXO</div></th>                                         
                                        <th width="30%"><div align="center">ELIMINAR</div></th>    

                                    </tr>
                                    </tr>
          </thead>
    </table>

<%
}
}else if(reporte.equals("REG_DOC_05")){

System.out.println("------------------------------------------------------------------------------");
  periodo = request.getParameter("periodo");       
 String cod_docinterno = request.getParameter("cod_interno"); 
  
 ListarAnexos = (ArrayList)objRD.obtenerFullAnexosXDocumento(periodo,cod_docinterno);
 int nroFilas = ListarAnexos.size();

%>

<table width="100%" border="0">
                <input type="hidden" name="txh_perido_anexos" id="txh_perido_anexos" value="<%=periodo %>"  />  
                <input type="hidden" name="txh_codinter_anexos" id="txh_codinter_anexos" value="<%=cod_docinterno %>" />  
                <input type="hidden" name="txh_secuencia_anexos" id="txh_secuencia_anexos"  />  
                <input type="hidden" name="txh_archivo_anexos" id="txh_archivo_anexos"    />  
    <!-- Div Botones-->                
    <div align="center"><a href="javascript:f_InsertarAnexos();"><img src="<%=request.getContextPath()%>/imagenes/icono/add_anexos.png" width="60px" height="60px" />Anadir</a>
                <a href="javascript:f_MostraAnexos();"><img src="<%=request.getContextPath()%>/imagenes/icono/ver_anexos.png" width="60px" height="60px" />Ver</a>
                <a href="javascript:f_ActualizarAnexos();"><img src="<%=request.getContextPath()%>/imagenes/icono/actualizar_anexos.png" width="60px" height="60px" />Actualizar</a>
                <a href="javascript:f_EliminarAnexos();"><img src="<%=request.getContextPath()%>/imagenes/icono/del_anexos.png" width="60px" height="60px" />Eliminar</a>
    </div>

<!--DIV TABLA DE ANEXOS -->
            <div class="modal-body" id="modalListaAnexos">

             <%
                                          if (ListarAnexos != null) {

                                                        %>
                                                        <table class="display" id="table_anexos" width="100%" border="1">
                                                            <thead>
                                                                <tr>
                                                                    <th><div align="center">SELECIONE</div></th>
                                                                    <th><div align="center">AÑO</div></th>                                                                   
                                                                    <th><div align="center">SEC.</div></th>
                                                                    <th><div align="center">NOMBRE</div></th>

                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <%
                                                                    for (int i = 0; i < ListarAnexos.size(); i++) {
                                                                        BeanAnexo objBeanA = (BeanAnexo) ListarAnexos.get(i);
                                                                %>
                                                    <tr><td ><div align="center"><input name="trabajo" type="radio" onClick="javascript:f_CapturaAnexos('<%=objBeanA.getCANEXO_PERIODO()%>','<%=objBeanA.getCANEXO_COD_DOC_INT()%>','<%=objBeanA.getCANEXO_SECUENCIA()%>','<%=objBeanA.getVANEXO_NOMBRE()%>')"/></div></td>                                                                      
                                                    <td><%=objBeanA.getCANEXO_PERIODO()%></td>                                                   
                                                    <td><%=objBeanA.getCANEXO_SECUENCIA()%></td>
                                                    <td><%=objBeanA.getVANEXO_NOMBRE()%></td>                                        
                                                    </tr>

                                                                <%}%>
                                                                <input type="hidden" name="hidNrofilas" id="hidNrofilas"  value="<%=nroFilas%>"  />  
                                                            </tbody>
                                                        </table>

                                                        <%}else{%>
                                                        <input type="text" name="hidNrofilas" id="hidNrofilas"  value="0"  /> 
                                                            <%}%>     


            </div>
             <!--FIN --> 
   
            <!--DIV PARA MOSTRA LA CAPA PARA AÑADIR ANEXO -->
           <div id="capa_add_anexos" style="visibility: hidden;width:100%; align-content: center">

              <h3>Cargar Anexos</h3>
              <form method="POST" action="#" enctype="multipart/form-data" id="frm_anexos" target="frame_support_anexo">
                  <!-- COMPONENT START -->
                  <div class="form-group">
                      <div class="input-group input-file" name="Fichier1">
                          <label for="url_anexo_mp"></label>
                          <input type="file" class="form-control" id="url_anexo_mp" name="fileAnexo"  />
                          <span class="input-group-btn">
                              <button class="btn btn-warning btn-reset" type="button" onclick="javascript:f_Grabar_Anexos();"><b>GRABAR</b></button>
                               <button class="btn btn-info btn-info"  type="button" onclick="javascript:f_cancelar();"><b>CANCELAR</b></button>
                          </span>
                          
                      </div>
                  </div>
              </form>

              <!-- agregar despues el css: display:none -->
              <iframe name="frame_support_anexo" style="background: rgba(0,0,0,0.3); width: 100%; height: 80px;visibility: hidden">
                  IFrame de soporte
              </iframe>


            </div>                                                   

 <br>
 <!-- FIN DE DIV-->
 </table>

<%
}else if(reporte.equals("REG_DOC_06")){

periodo = request.getParameter("periodo"); 
String cod_int = request.getParameter("cod_int"); 
String tipo_orig = request.getParameter("tipo_orig"); 
String cod_org = request.getParameter("cod_org"); 
String clase = request.getParameter("clase"); 
String nro_orden = request.getParameter("nro_orden"); 
String indic = request.getParameter("indic"); 
String fecha = request.getParameter("fecha"); 
String asunto = request.getParameter("asunto"); 
String tipo_dist = request.getParameter("tipo_dist"); 
String prioridad = request.getParameter("prioridad"); 
%>

       <div align="left">

                            <table width="100%">
                                <tr>                        
                                    <td  style="background: #FFD153">
                                        <div align="left"><span style="color:rgb(6, 32, 27); font-family: monospace;font-size: 16px"><u>I. Datos del la Organización que Remite : </u></span></div>
                                    </td>    
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%">
                                            <tr>
                                                <td>&nbsp;&nbsp;</td>
                                                <td><div align="left" class="EstiloOF">Año</div></td>
                                                <td>&nbsp;&nbsp;</td>
                                                <td><div align="left" class="EstiloOF">Procedencia</div> </td>
                                                <td>&nbsp;&nbsp;</td>
                                                <td><div align="left" class="EstiloOF">Dependencia</div> </td>
                                            </tr>
                                            <tr>
                                                <td>&nbsp;&nbsp;</td>
                                                <td><select name="cbo_Periodo_Act" class="form-control" id="cbo_Periodo_Act" >
                                                        <%
                                                            Iterator iterator = objCombobox.obtenerPeriodo().iterator();
                                                            while (iterator.hasNext()) {
                                                                BeanPeriodo bean = (BeanPeriodo) iterator.next();
                                                                String seleccion = (bean.getCPERIODO_CODIGO().equals(periodo)) ? "selected" : "";
                                                                out.println("<option value= " + bean.getCPERIODO_CODIGO() +" " + seleccion + ">" + bean.getCPERIODO_CODIGO() + "</option>");

                                                            }                                                            

                                                        %>  
                                                    </select>
                                                </td>
                                                <td>&nbsp;&nbsp;</td>
                                                <div id="retorna_org">
                                                <td><select name="cbo_Tipo_Organizacion_Act" class="form-control" id="cbo_Tipo_Organizacion_Act" onchange="f_DIS(this.value)">
                                                        <option value="I">Interna</option>
                                                        <option value="E">Externa</option> 
                                                    </select>
                                                    <td>&nbsp;&nbsp;</td>
                                                </td>
                                                <td><div id="dis_org">
                                                        <select name='org_Act' id='org_Act'  class='selectpicker' data-live-search='true'   >
                                                            <%     Iterator iteratorOrgI = objCombobox.obtenerOrganizacionEjercito_MP().iterator();
                                                            
                                                                while (iteratorOrgI.hasNext()) {                                                                      
                                                                    BeanOrganizacionInterna beanorgi = (BeanOrganizacionInterna) iteratorOrgI.next();  
                                                                    String seleccion = (beanorgi.getCOINTERNA_CODIGO().equals(cod_org)) ? "selected" : "";
                                                                    out.println("<option value=" + beanorgi.getCOINTERNA_CODIGO() +" " + seleccion + ">" + beanorgi.getVOINTERNA_NOM_CORTO() + "</option>");
                                                                }

                                                            %>  
                                                        </select>
                                                    </div>

                                                </td>
                                                </div>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>

                            </table>    
                            <table width="100%">
                                <tr>                        
                                    <td  style="background: #FFD153">
                                        <div align="left"><span style="color:rgb(6, 32, 27);font-family: monospace;font-size: 16px"><u>II. Datos del documento : </u></span></div>
                                    </td>       
                                </tr>
                                <tr>
                                    <td>
                                        <table width="100%">
                                            <tr>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td width="20%"><div align="left" class="EstiloOF">Clase Documento</div></td>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td width="20%"><div align="left" class="EstiloOF">Nro Documento</div> </td>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td width="20%"><div align="left" class="EstiloOF">Indicativo</div> </td>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td width="20%"><div align="left" class="EstiloOF">Fecha Documento</div> </td>
                                            </tr>
                                            <tr>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td width="20%"><div align="left" class="EstiloOF">
                                                        <select name='cbx_Clase_Doc_Act' id='cbx_Clase_Doc_Act'  class='selectpicker' data-live-search='true'   >
                                                            <%  Iterator iteratorClaseDoc = objCombobox.obtenerClaseDocumento().iterator();
                                                                while (iteratorClaseDoc.hasNext()) {
                                                                    BeanClase beanclase = (BeanClase) iteratorClaseDoc.next();
                                                                    String seleccion = (beanclase.getCCLASE_CODIGO().equals(clase)) ? "selected" : "";
                                                                    out.println("<option value=" + beanclase.getCCLASE_CODIGO() +" " + seleccion + ">" + beanclase.getVCLASE_NOM_LARGO() + "</option>");
                                                                }

                                                            %>  
                                                        </select>
                                                    </div>
                                                </td>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td width="20%"><div align="left" class="EstiloOF" ><input name="txt_Nro_Orden_Act" id="txt_Nro_Orden_Act" type="text" class="form-control" size="3"  value="<%=nro_orden%>"/></div> </td>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td width="20%"><div align="left" class="EstiloOF"><input name="txt_Clave_Indic_Act" id="txt_Clave_Indic_Act"   type="text" class="form-control" size="3"  value="<%=indic%>"/></div> </td>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td width="20%"><div align="left" > 

                                                        <div class="input-group date" data-provide="datepicker" data-date-format="dd/mm/yyyy">
                                                            <input type="text" class="form-control" name="txt_fecha_MP_Act" id="txt_fecha_MP_Act" value="<%=fecha%>">
                                                                <div class="input-group-addon">
                                                                    <span class="glyphicon glyphicon-calendar"></span>
                                                                </div>
                                                        </div>                                                        

                                                    </div> </td>
                                            </tr>
                                            <tr>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td colspan="7" width="85%"><div align="left" class="EstiloOF">Asunto</div></td>                                              
                                            </tr>
                                            <tr>
                                                <td width="5%">&nbsp;&nbsp;</td>
                                                <td width="85%" colspan="7"><div align="left" class="EstiloOF"><input name="txt_Asunto_MP_Act" id="txt_Asunto_MP_Act"   type="text" class="form-control" size="3"  value="<%=asunto%>"/></div></td>                                              
                                            </tr>
                                            <tr>
                                                <td width="10%">&nbsp;&nbsp;</td>  
                                                <td width="40%" colspan="3"><div align="left" class="EstiloOF">Tipo Distribución</div></td>
                                                <td width="10%">&nbsp;&nbsp;</td>                                                  
                                                <td width="40%" colspan="3"><div align="left" class="EstiloOF">Prioridad</div> </td>


                                            </tr>
                                            <tr>
                                                <td width="5%">&nbsp;&nbsp;</td>  
                                                <td width="45%" colspan="3"><div align="left" class="EstiloOF">
                                                        <select name='cbx_tipo_distri_Act' id='cbx_tipo_distri_Act'  class='selectpicker' data-live-search='true'>
                                                            <option value="T">COMUN</option>
                                                            <option value="C">C'INF</option>
                                                        </select>

                                                    </div>
                                                </td>
                                                <td width="10%">&nbsp;&nbsp;</td>                                           

                                                <td width="45%" colspan="3"><div align="left" class="EstiloOF"> 
                                                        <select name='cbx_Prioridad_Act' id='cbx_Prioridad_Act'  class='selectpicker' data-live-search='true'   >
                                                            <%                                                        
                                                                Iterator iteratorPrioridad = objCombobox.obtenerPrioridades().iterator();
                                                                while (iteratorPrioridad.hasNext()) {
                                                                    BeanPrioridadDocumento beanprioridad = (BeanPrioridadDocumento) iteratorPrioridad.next();
                                                                     String seleccion = (beanprioridad.getCodigo().equals(prioridad)) ? "selected" : "";
                                                                    out.println("<option value=" + beanprioridad.getCodigo() +" " + seleccion + ">" + beanprioridad.getNombre() + "</option>");
                                                                }

                                                            %>  
                                                        </select>
                                                    </div> 
                                                </td>

                                            </tr>

                                        </table>    
                                    </td>
                                </tr><BR>

                            </table>
                            <table width="100%">
                                <tr>                        
                                    <td colspan="6"  style="background: #FFD153">
                                        <div align="left"><span style="color:rgb(6, 32, 27); font-family: monospace;font-size: 16px"><u>III. Adjuntar Documentos : </u></span></div>
                                    </td>       
                                </tr>
                                <tr>
                                    <td colspan="7">
                                        <div id="capa_add_" style="width:100%; align-content: center">                                   
                                            <form method="POST" action="#" enctype="multipart/form-data" id="frm_documento_Act" target="frame_support_Act">
                                                <!-- COMPONENT START -->
                                                <div class="form-group">
                                                    <div class="input-group input-file" name="Fichier1">
                                                        <label for="url_anexo_revisar_Act"></label>
                                                        <input type="file" class="form-control" id="url_anexo_revisar_Act" name="fileAnexo" style="width: 550px" />
                                                        <span class="input-group-btn">
                                                            <button class="btn btn-warning btn-reset" type="button" onclick="javascript:f_Grabar_Documento();"><b>GRABAR</b></button>
                                                            <button class="btn btn-info btn-info"  type="button" onclick="javascript:f_cancelar();"><b>CANCELAR</b></button>
                                                        </span>
                                                    </div>
                                                </div>
                                            </form>

                                            <!-- agregar despues el css: display:none -->
                                            <iframe name="frame_support_Act" style="background: rgba(0,0,0,0.3); width: 100%; height: 80px;visibility: hidden">
                                                IFrame de soporte
                                            </iframe>


                                        </div> 
                                    </td>
                                </tr><BR>

                            </table>


                        </div>
<%
}
%>