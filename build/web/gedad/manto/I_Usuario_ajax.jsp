<%@taglib uri="/WEB-INF/tlds/libreria.tld" prefix="lb"%>
<%@page import="comun.DAOFactory"%>
<%@page import="comun.UsuarioADDAO"%>
<%@page import="sagde.bean.*" %>
<%@page import="java.util.*"%>
<%@page import="java.util.Base64.Decoder"%>
<%
    String hora = (String) request.getParameter("pasacache");
    String reporte = (String) request.getParameter("reporte");
    String hecho = (String) request.getParameter("hecho");
    String interna = (String) request.getParameter("interna");
    String usuario = (String) request.getParameter("usuario");
    String cargo = (String) request.getParameter("cargo");
    String jefe = (String) request.getParameter("jefe");
    String internaEnc = (String) request.getParameter("internaEnc");
    String estado = (String) request.getParameter("estado");
    String estadoFiltro = (String) request.getParameter("estadoFiltro");
    String paterno = (String) request.getParameter("paterno");
    String materno = (String) request.getParameter("materno");
    String nombres = (String) request.getParameter("nombres");
    String dni = (String) request.getParameter("dni");

    BeanUsuarioAD objBeanU = (BeanUsuarioAD) session.getAttribute("usuario");
    DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
    UsuarioADDAO objUAD = objDAOFactory.getUsuarioADDAO();

    //01.FORMULARIO VACIO PARA INSERCION
    //02.INSERTA O ACTUALIZA, LUEGO LISTA
    //03.FORMULARIO LLENO PARA ACTUALIZAR
    //04.FORMULARIO VACIO PARA BUSQUEDA
    //05.BUSQUEDA DE PERSONAS POR APELLIDOS Y NOMBRES
    //06.BUSQUEDA DE PERSONA POR DNI    
    if (reporte.equals("01")) {

%>
<table width="100%" border="0" cellpadding="2" cellspacing="2" bordercolor="#66CCCC" bgcolor="#6E6855" style="background-position:center">
    <tr>
        <td width="100%">
            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="0" bgcolor="#6E6855">
                <tr>
                    <td width="30%">
                        <label class="label-titulo">DNI:</label>
                    </td>
                    <td width="45%" align="left" valign="middle">
                        <div align="left" valign="middle">
                            <input type="text" name="txt_DniB" id="txt_DniB" class="form-control" />
                        </div>
                    </td>
                    <td width="5%"></td>
                    <td width="20%">
                        <input type="button" class="btn btn-primary btn-block" onclick="f_openBusqueda()" value="..." />
                        <input type="button" class="btn btn-success btn-block" onclick="f_Buscar()" value="Buscar" />
                    </td>
                </tr>
                <tr height="5"></tr>
                <tr>
                    <td colspan="4">
                        <span id="rpta_bus">
                            <table width="100%">
                                <tr>
                                    <td width="30%">
                                        <label class="label-titulo">Usuario:</label></td>
                                    <td width="70%" align="left" valign="middle">
                                        <div align="left" valign="middle">
                                            <input type="text" name="txt_Usuario" class="form-control" disabled="true"/>
                                        </div>
                                    </td>
                                </tr>
                                <tr height="5"></tr>
                                <tr>
                                    <td width="30%">
                                        <label class="label-titulo">Grado:</label></td>
                                    <td width="70%" align="left" valign="middle">
                                        <div align="left" valign="middle">
                                            <input type="text" name="txt_Grado" class="form-control" disabled="true"/>
                                        </div>
                                    </td>
                                </tr>
                                <tr height="5"></tr>
                                <tr>
                                    <td>
                                        <label class="label-titulo">Arma:</label></td>
                                    <td align="left" valign="middle">
                                        <div align="left" valign="middle">
                                            <input type="text" name="txt_Arma" class="form-control" disabled="true"/>
                                        </div>
                                    </td>
                                </tr>
                                <tr height="5"></tr>
                                <tr>
                                    <td>
                                        <label class="label-titulo">Apellidos y Nombres:</label></td>
                                    <td align="left" valign="middle">
                                        <div align="left" valign="middle">
                                            <input type="text" name="txt_Apenom" class="form-control" disabled="true"/>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </span>
                    </td>
                </tr>
                <tr height="5"></tr>
                <tr>
                    <td>
                        <label class="label-titulo">Organizacion:</label></td>
                    <td colspan="3" align="left" valign="middle">
                        <div align="left" valign="middle">
                            <select name="cbo_Interna" id="cbo_Interna" class="form-control selectpicker" data-style="btn-info" data-live-search="true" >
                                <option value="000">--Elija Opcion--</option>
                                <%                                    Iterator iteratorI = objUAD.listarOrganizacionxCodigo(internaEnc).iterator();
                                    while (iteratorI.hasNext()) {
                                        BeanOrganizacionInterna objBeanOI = (BeanOrganizacionInterna) iteratorI.next();
                                        out.println("<option value=" + objBeanOI.getCOINTERNA_CODIGO() + " >");
                                        int largo = Integer.parseInt(objBeanOI.getNOINTERNA_NIVEL());
                                        for (int i = 1; i <= largo; i++) {
                                            out.println("-");
                                        }
                                        out.println(objBeanOI.getVOINTERNA_NOM_CORTO() + "</option>");
                                    }
                                %>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr height="5"></tr>
                <tr>
                    <td>
                        <label class="label-titulo">Cargo:</label></td>
                    <td colspan="3" align="left" valign="middle">
                        <div align="left" valign="middle">
                            <input type="text" name="txt_Cargo" maxlength="150" class="form-control" />
                        </div>
                    </td>
                </tr>
                <tr height="5"></tr>
                <tr>
                    <td>
                        <label class="label-titulo">Usuario Jefe:</label></td>
                    <td colspan="3" align="left" valign="middle">
                        <div align="left" valign="middle">
                            <select name="cbo_Jefe" id="cbo_Jefe" class="form-control selectpicker" data-style="btn-info" data-live-search="true" >
                                <option value="000">--Elija Opcion--</option>
                                <option value="S">Jefe de esta Organizacion</option>
                                <option value="N">No es Jefe de esta Organizacion</option>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr height="20"></tr>
            </table>
        </td>
    </tr>
</table>
<table width="40%" border="0" align="center" cellpadding="0" cellspacing="0" >
    <tr>
        <td width="45%"><input type="button" class="btn btn-primary btn-block" value="Grabar" onclick="f_agregar()" /></td>
        <td width="10%">&nbsp;</td>
        <td width="45%"><input type="button" class="btn btn-primary btn-block" value="Cancelar" onclick="f_cancelar()" /></td>
    </tr>
</table>
<%
} else if (reporte.equals("02")) {
    Decoder decoder = Base64.getDecoder();
    cargo = new String(decoder.decode(cargo));
    BeanUsuarioAD objBeanUAD = new BeanUsuarioAD();
    objBeanUAD.setVUSUARIO_CODIGO(usuario);
    objBeanUAD.setCUSUARIO_COD_ORG(interna);
    objBeanUAD.setVUSUARIO_CARGO(cargo);
    objBeanUAD.setCUSUARIO_FLAG_JEFE(jefe);
    if (hecho.equals("I")) {
        objUAD.insertarUsuario(objBeanUAD);
    } else if (hecho.equals("A")) {
        objBeanUAD.setCUSUARIO_ESTADO(estado);
        objUAD.actualizarUsuario(objBeanUAD);
    }else if (hecho.equals("AO")) {
        objUAD.actualizarUsuarioSE(objBeanUAD);
    }
    ArrayList ListarUsuario = new ArrayList();
    if (estadoFiltro.equals("SIN_FILTRO")) {
        ListarUsuario = (ArrayList) objUAD.listarUsuario(internaEnc.trim());
    } else {
        ListarUsuario = (ArrayList) objUAD.listarUsuarioxEstado(internaEnc.trim(), estadoFiltro);
    }

    request.setAttribute("ListarUsuario", ListarUsuario);

%>
<table class="display" border="1" id="listaUsuario">
    <thead>
        <tr bgcolor="#B0B199">
            <th width="20%"><div align="center">CODIGO O.I.</div></th>
            <th width="10%"><div align="center">ORGANIZACIÓN</div></th>
            <th width="10%"><div align="center">USUARIO</div></th>
            <th width="10%"><div align="center">GRADO</div></th>
            <th width="10%"><div align="center">ARMA</div></th>
            <th width="20%"><div align="center">APELLIDOS Y NOMBRES</div></th>
            <th width="20%"><div align="center">CARGO QUE OCUPA</div></th>                                        
            <th width="5%">&nbsp;</th>
        </tr>
    </thead>
    <tbody>
        <%            for (int i = 0; i < ListarUsuario.size(); i++) {
                objBeanUAD = (BeanUsuarioAD) ListarUsuario.get(i);
                if (objBeanUAD.getVARMAS_DESCOR() == null) {
                    objBeanUAD.setVARMAS_DESCOR("");
                }
                if (objBeanUAD.getCGRADO_DESCCORT() == null) {
                    objBeanUAD.setCGRADO_DESCCORT("");
                }
        %>
        <tr>
            <td><div align="center"><%=objBeanUAD.getCUSUARIO_COD_ORG()%></div></td>
            <td><%=objBeanUAD.getVOINTERNA_NOM_CORTO()%></td>
            <td bgcolor="#CCD272"><div align="center"><%=objBeanUAD.getVUSUARIO_CODIGO()%></div></td>
            <td><%=objBeanUAD.getCGRADO_DESCCORT()%></td>
            <td><%=objBeanUAD.getVARMAS_DESCOR()%></td>
            <td><%=objBeanUAD.getAPENOM()%></td>
            <td><%=objBeanUAD.getVUSUARIO_CARGO()%></td>
            <td><div align="center"><a href="javascript:f_actualizar('<%=objBeanUAD.getVUSUARIO_CODIGO()%>');"><img src="<%= request.getContextPath()%>/imagenes/icono/modificar.jpg" height="25px" width="25px" alt="Editar" /></a></div></td>
        </tr>
        <%}%>
    </tbody>
</table>
<%
} else if (reporte.equals("03")) {

    BeanUsuarioAD objBeanUAD = objUAD.obtenerUsuario(usuario);
    if (objBeanUAD.getVARMAS_DESCOR() == null) {
        objBeanUAD.setVARMAS_DESCOR("");
    }
    if (objBeanUAD.getCGRADO_DESCCORT() == null) {
        objBeanUAD.setCGRADO_DESCCORT("");
    }
%>
<table width="100%" border="0" cellpadding="2" cellspacing="2" bordercolor="#66CCCC" bgcolor="#6E6855" style="background-position:center">
    <tr>
        <td width="100%">
            <table width="100%" align="center" border="0" cellpadding="0" cellspacing="0" bgcolor="#6E6855">
                <tr>
                    <td width="30%">
                        <label class="label-titulo">Usuario:</label></td>
                    <td width="70%" align="left" valign="middle">
                        <div align="left" valign="middle">
                            <input type="text" name="txt_Usuario" class="form-control" disabled="true" value="<%=objBeanUAD.getVUSUARIO_CODIGO()%>"/>
                        </div>
                    </td>
                </tr>
                <tr height="5"></tr>
                <tr>
                    <td width="30%">
                        <label class="label-titulo">Grado:</label></td>
                    <td width="70%" align="left" valign="middle">
                        <div align="left" valign="middle">
                            <input type="text" name="txt_Grado" class="form-control" disabled="true" value="<%=objBeanUAD.getCGRADO_DESCCORT()%>"/>
                        </div>
                    </td>
                </tr>
                <tr height="5"></tr>
                <tr>
                    <td>
                        <label class="label-titulo">Arma:</label></td>
                    <td align="left" valign="middle">
                        <div align="left" valign="middle">
                            <input type="text" name="txt_Arma" class="form-control" disabled="true" value="<%=objBeanUAD.getVARMAS_DESCOR()%>"/>
                        </div>
                    </td>
                </tr>
                <tr height="5"></tr>
                <tr>
                    <td>
                        <label class="label-titulo">Apellidos y Nombres:</label></td>
                    <td align="left" valign="middle">
                        <div align="left" valign="middle">
                            <input type="text" name="txt_Apenom" class="form-control" disabled="true" value="<%=objBeanUAD.getAPENOM()%>" />
                        </div>
                    </td>
                </tr>
                <tr height="5"></tr>
                <tr>
                    <td>
                        <label class="label-titulo">Organizacion:</label></td>
                    <td colspan="3" align="left" valign="middle">
                        <div align="left" valign="middle">
                            <select name="cbo_Interna" id="cbo_Interna" class="form-control selectpicker" data-style="btn-info" data-live-search="true" >
                                <option value="000">--Elija Opcion--</option>
                                <%
                                    Iterator iteratorI = objUAD.listarOrganizacionxCodigo(internaEnc).iterator();
                                    while (iteratorI.hasNext()) {
                                        BeanOrganizacionInterna objBeanOI = (BeanOrganizacionInterna) iteratorI.next();
                                        String seleccion = (objBeanOI.getCOINTERNA_CODIGO().equals(objBeanUAD.getCUSUARIO_COD_ORG())) ? "selected" : "";
                                        out.print("<option value=" + objBeanOI.getCOINTERNA_CODIGO() + " " + seleccion + ">");
                                        int largo = Integer.parseInt(objBeanOI.getNOINTERNA_NIVEL());
                                        for (int i = 1; i <= largo; i++) {
                                            out.print("-");
                                        }
                                        out.println(objBeanOI.getVOINTERNA_NOM_CORTO() + "</option>");
                                    }
                                %>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr height="5"></tr>
                <tr>
                    <td>
                        <label class="label-titulo">Cargo:</label></td>
                    <td colspan="3" align="left" valign="middle">
                        <div align="left" valign="middle">
                            <input type="text" name="txt_Cargo" maxlength="150" class="form-control" value="<%=objBeanUAD.getVUSUARIO_CARGO()%>" />
                        </div>
                    </td>
                </tr>
                <tr height="5"></tr>
                <tr>
                    <td>
                        <label class="label-titulo">Usuario Jefe:</label></td>
                    <td colspan="3" align="left" valign="middle">
                        <div align="left" valign="middle">
                            <select name="cbo_Jefe" id="cbo_Jefe" class="form-control selectpicker" data-style="btn-info" data-live-search="true" >
                                <option value="0">--Elija Opcion--</option>
                                <option value="S" <%if (objBeanUAD.getCUSUARIO_FLAG_JEFE().equals("S")) {%> selected <%}%> >Jefe de esta Organizacion</option>
                                <option value="N" <%if (objBeanUAD.getCUSUARIO_FLAG_JEFE().equals("N")) {%> selected <%}%> >No es Jefe de esta Organizacion</option>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr height="5"></tr>
                <tr>
                    <td>
                        <label class="label-titulo">Estado:</label></td>
                    <td colspan="3" align="left" valign="middle">
                        <div align="left" valign="middle">
                            <select name="cbo_Estado" id="cbo_Estado" class="form-control selectpicker" data-style="btn-info" data-live-search="true" >
                                <option value="0">--Elija Opcion--</option>
                                <option value="A" <%if (objBeanUAD.getCUSUARIO_ESTADO().equals("A")) {%> selected <%}%> >Activo</option>
                                <option value="B" <%if (objBeanUAD.getCUSUARIO_ESTADO().equals("B")) {%> selected <%}%> >Inactivo</option>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr height="20"></tr>
            </table>
        </td>
    </tr>
</table>
<table width="40%" border="0" align="center" cellpadding="0" cellspacing="0" >
    <tr>
        <td width="45%"><input type="button" class="btn btn-primary btn-block" value="Grabar" onclick="f_modificar()" /></td>
        <td width="10%">&nbsp;</td>
        <td width="45%"><input type="button" class="btn btn-primary btn-block" value="Cancelar" onclick="f_cancelar()" /></td>
    </tr>
</table>
<%
} else if (reporte.equals("04")) {
%>
<table width="100%">
    <tr>
        <td>
            <table width="100%">
                <tr>
                    <td width="32%"><div align="left" class="EstiloOF">Apellido Paterno</div></td>
                    <td width="2%">&nbsp;</td>
                    <td width="32%"><div align="left" class="EstiloOF">Apellido Materno</div></td>
                    <td width="2%">&nbsp;</td>
                    <td width="32%"><div align="left" class="EstiloOF">Nombres</div></td>
                </tr>
                <tr>
                    <td>
                        <input name="txt_paternoB" id="txt_paternoB" type="text" class="form-control" />
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <input name="txt_maternoB" id="txt_maternoB" type="text" class="form-control"  />
                    </td>
                    <td>&nbsp;</td>
                    <td>
                        <input name="txt_nombresB" id="txt_nombresB" type="text" class="form-control"  />
                    </td>
                </tr>
                <tr height="5"></tr>
                <tr>
                    <td colspan="4">&nbsp;</td>
                    <td><input type="button" class="btn btn-info form-control" value="BUSQUEDA" onclick="javascript:f_Buscar_Persona();"></button></td>
                </tr>
            </table>
        </td>
    </tr>
    <tr height="5px"></tr>
    <!-- Para la tabla de Persona -->   
    <tr>
        <td>
            <div id="listaBusPer">&nbsp;</div>
        </td>
    </tr>
</table>
<%
} else if (reporte.equals("05")) {

    ArrayList ListarPersonas = (ArrayList) objUAD.busquedaxApellidosyNombres(paterno, materno, nombres);
    request.setAttribute("ListarPersonas", ListarPersonas);
%>
<table class="display" border="1" id="listaPersona">
    <thead>
        <tr bgcolor="#B0B199">
            <th width="15%"><div align="center">GRADO</div></th>
            <th width="15%"><div align="center">ARMA</div></th>
            <th width="50%"><div align="center">APELLIDOS Y NOMBRES</div></th>
            <th width="15%"><div align="center">DNI</div></th>
            <th width="5%">&nbsp;</th>
        </tr>
    </thead>
    <tbody>
        <%
            for (int i = 0; i < ListarPersonas.size(); i++) {
                BeanPersona objBeanP = (BeanPersona) ListarPersonas.get(i);
                if (objBeanP.getCGRADO_DESCCORT() == null) {
                    objBeanP.setCGRADO_DESCCORT("");
                }
                if (objBeanP.getVARMAS_DESCOR() == null) {
                    objBeanP.setVARMAS_DESCOR("");
                }
        %>
        <tr>
            <td><%=objBeanP.getCGRADO_DESCCORT()%></td>
            <td><%=objBeanP.getVARMAS_DESCOR()%></td>
            <td><%=objBeanP.getAPENOM()%></td>
            <td><%=objBeanP.getCPERSONA_NRODOC()%></td>
            <td><div align="center"><a href="javascript:f_enviarDNI('<%=objBeanP.getCPERSONA_NRODOC()%>');"><img src="<%= request.getContextPath()%>/imagenes/icono/devolver.jpg" height="25px" width="25px" alt="Editar" /></a></div></td>
        </tr>
        <%}%>
    </tbody>
</table>
<%
} else if (reporte.equals("06")) {
    BeanUsuarioAD objBeanUAD = objUAD.obtenerUsuarioxDni(dni);
%>
<table width="100%">
    <tr>
        <td width="30%">
            <label class="label-titulo">Usuario:</label></td>
        <td width="70%" align="left" valign="middle">
            <div align="left" valign="middle">
                <input type="text" name="txt_Usuario" class="form-control" disabled="true" value="<%=objBeanUAD.getNICKNAME()%>" />
            </div>
        </td>
    </tr>
    <tr height="5"></tr>
    <tr>
        <td width="30%">
            <label class="label-titulo">Grado:</label></td>
        <td width="70%" align="left" valign="middle">
            <div align="left" valign="middle">
                <input type="text" name="txt_Grado" class="form-control" disabled="true" value="<%=objBeanUAD.getCGRADO_DESCCORT()%>" />
            </div>
        </td>
    </tr>
    <tr height="5"></tr>
    <tr>
        <td>
            <label class="label-titulo">Arma:</label></td>
        <td align="left" valign="middle">
            <div align="left" valign="middle">
                <input type="text" name="txt_Arma" class="form-control" disabled="true" value="<%=objBeanUAD.getVARMAS_DESCOR()%>" />
            </div>
        </td>
    </tr>
    <tr height="5"></tr>
    <tr>
        <td>
            <label class="label-titulo">Apellidos y Nombres:</label></td>
        <td align="left" valign="middle">
            <div align="left" valign="middle">
                <input type="text" name="txt_Apenom" class="form-control" disabled="true" value="<%=objBeanUAD.getAPENOM()%>" />
            </div>
        </td>
    </tr>
    <%
        if (objBeanUAD.getCUSUARIO_COD_ORG() != null) {
    %>
    <tr height="5"></tr>
    <tr style="border: 1px">
        <td>
            <label class="label-titulo">Organización Actual:</label></td>
        <td align="left" valign="middle">
            <div align="left" valign="middle">
                <input type="text" name="txt_Apenom" class="form-control" disabled="true" value="<%=objBeanUAD.getVOINTERNA_NOM_CORTO()%>" />
                <input type="hidden" name="txh_Existe" id="txh_Existe" value="S" />
            </div>
        </td>
    </tr>
    <%
    } else {
    %>
    <input type="hidden" name="txh_Existe" id="txh_Existe" value="N" />
    <%
        }
    %>
</table>
<%
    }
%>