package comun;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import oracle.jdbc.OracleTypes;
import sagde.bean.BeanAnexo;
import sagde.bean.BeanArchivo;
import sagde.bean.BeanClase;
import sagde.bean.BeanClasificacionDocumento;
import sagde.bean.BeanCuerpoDocumento;
import sagde.bean.BeanDistribucion;
import sagde.bean.BeanDocumento;
import sagde.bean.BeanHistorialDocumento;
import sagde.bean.BeanOrganizacionExterna;
import sagde.bean.BeanOrganizacionInterna;
import sagde.bean.BeanPeriodo;
import sagde.bean.BeanPrioridadDocumento;
import sagde.bean.BeanReferencia;
import sagde.bean.BeanReferenciaOrden;
import sagde.bean.BeanRegistroDocumento;
import sagde.bean.BeanTemporal;
import sagde.bean.BeanUsuarioAD;
import sagde.comun.OracleDBConn;
import sagde.comun.Parametros;

/**
 *
 * @author rbermudezf
 */
public class OracleFormularDocumentoDAO implements FormularDocumentoDAO {

    Connection conn = null;
    CallableStatement cs = null;
    PreparedStatement pcs = null;
    ResultSet rs = null;
    Statement st = null;
    Collection lista = null;
    BeanPeriodo objBeanP = null;
    BeanDistribucion objBeanDI = null;
    BeanOrganizacionInterna objBeanOI = null;
    BeanDocumento objBeanD = null;
    BeanAnexo objBeanAN = null;
    BeanClase objBeanC = null;
    BeanReferencia objBeanR = null;
    BeanReferenciaOrden objBeanRO = null;
    BeanTemporal objBeanT = null;

    private Connection getConnection() {
        OracleDBConn cnx = new OracleDBConn();
        return cnx.getConnection();
    }

    @Override
    public Collection listaClaseFormular() throws SQLException {
        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "A");
            cs.setString(3, "");
            cs.setString(4, "");
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanC = new BeanClase();
                objBeanC.setCCLASE_CODIGO(rs.getString(1));
                objBeanC.setVCLASE_NOM_LARGO(rs.getString(2));
                objBeanC.setVCLASE_NOM_CORTO(rs.getString(3));
                objBeanC.setVCLASE_RUTA(rs.getString(4));
                objBeanC.setNCLASE_NRO_FIRMAS(rs.getString(5));
                lista.add(objBeanC);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return lista;
    }

    @Override
    public Collection obtenerOrganizacionInternaNombreLargo(String usuario, String nivel) throws SQLException {

        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "B");
            cs.setString(3, nivel);
            cs.setString(4, usuario);
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanOI = new BeanOrganizacionInterna();
                objBeanOI.setCOINTERNA_CODIGO(rs.getString(1));
                objBeanOI.setVOINTERNA_NOM_LARGO(rs.getString(2));
                lista.add(objBeanOI);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return lista;

    }

    @Override
    public Collection obtenerArchivoIndicativo() throws Exception {

        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "C");
            cs.setString(3, "");
            cs.setString(4, "");
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                BeanArchivo objBeanA = new BeanArchivo();
                objBeanA.setCARCHIVO_CODIGO(rs.getString(1));
                objBeanA.setVARCHIVO_NOMBRE(rs.getString(2));
                lista.add(objBeanA);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return lista;

    }

    @Override
    public String obtenerClave_IndicativoxUsuario(String interna) throws SQLException {

        String clave_indicativo = "";
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "D");
            cs.setString(3, interna);
            cs.setString(4, "");
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            if (rs.next()) {
                clave_indicativo = rs.getString(1);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return clave_indicativo;
    }

    @Override
    public BeanPeriodo obtenerDefinicionPeriodo(String anio) throws SQLException {

        objBeanP = new BeanPeriodo();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "E");
            cs.setString(3, anio);
            cs.setString(4, "");
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            if (rs.next()) {
                objBeanP = new BeanPeriodo();
                objBeanP.setCPERIODO_CODIGO(rs.getString(1));
                objBeanP.setVPERIODO_DEFINICION(rs.getString(2));
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objBeanP;

    }

    @Override
    public String obtenerOrganizacionLugarxUsuario(String interna) throws SQLException {

        String guarnicion = "";
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "F");
            cs.setString(3, interna);
            cs.setString(4, "");
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            if (rs.next()) {
                guarnicion = (rs.getString(1));
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return guarnicion;

    }

    @Override
    public Collection obtenerUsuariosxNiveles(String usuario, String rol) throws SQLException {

        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "G");
            cs.setString(3, rol);
            cs.setString(4, usuario);
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                BeanUsuarioAD objBeanUAD = new BeanUsuarioAD();
                objBeanUAD.setVUSUARIO_CODIGO(rs.getString(1));
                objBeanUAD.setCUSUARIO_COD_ORG(rs.getString(2));
                objBeanUAD.setVUSUARIO_CARGO(rs.getString(3));
                lista.add(objBeanUAD);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return lista;

    }

    @Override
    public Collection obtenerClasificacion() throws SQLException {

        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "H");
            cs.setString(3, "");
            cs.setString(4, "");
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                BeanClasificacionDocumento objBeanCFD = new BeanClasificacionDocumento();
                objBeanCFD.setCodigo(rs.getString(1));
                objBeanCFD.setNombre(rs.getString(2));
                lista.add(objBeanCFD);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return lista;

    }

    @Override
    public Collection obtenerPrioridades() throws SQLException {

        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "I");
            cs.setString(3, "");
            cs.setString(4, "");
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                BeanPrioridadDocumento objBeanPD = new BeanPrioridadDocumento();
                objBeanPD.setCodigo(rs.getString(1));
                objBeanPD.setNombre(rs.getString(2));
                lista.add(objBeanPD);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return lista;

    }

    @Override
    public Collection obtenerOrganizacionInternas(String interna) throws SQLException {

        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "J");
            cs.setString(3, interna);
            cs.setString(4, "");
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanOI = new BeanOrganizacionInterna();
                objBeanOI.setCOINTERNA_CODIGO(rs.getString(1));
                objBeanOI.setVOINTERNA_NOM_CORTO(rs.getString(2));
                lista.add(objBeanOI);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return lista;

    }

    @Override
    public Collection obtenerOrganizacionExterna() throws SQLException {

        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "K");
            cs.setString(3, "");
            cs.setString(4, "");
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                BeanOrganizacionExterna objBeanOE = new BeanOrganizacionExterna();
                objBeanOE.setNombre(rs.getString(1));
                objBeanOE.setCodigo(rs.getString(2));
                lista.add(objBeanOE);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return lista;

    }

    @Override
    public Collection obtenerOrganizacionEjercito(String interna, String dato) throws SQLException {

        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "L");
            cs.setString(3, interna);
            cs.setString(4, dato);
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanOI = new BeanOrganizacionInterna();
                objBeanOI.setVOINTERNA_NOM_CORTO(rs.getString(1));
                objBeanOI.setCOINTERNA_CODIGO(rs.getString(2));
                lista.add(objBeanOI);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return lista;

    }

    @Override
    public BeanDistribucion obtenerDistribucion(String tipo, String interna) throws Exception {

        objBeanDI = new BeanDistribucion();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "M");
            cs.setString(3, tipo);
            cs.setString(4, interna);
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanDI = new BeanDistribucion();
                objBeanDI.setTipoOrganizacion(tipo);
                objBeanDI.setCodigoOrganizacion(rs.getString(1));
                objBeanDI.setDescOrganizacion(rs.getString(2));
                objBeanDI.setGrado(rs.getString(3));
                objBeanDI.setNombre(rs.getString(4));
                objBeanDI.setCargo(rs.getString(5));
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objBeanDI;

    }

    @Override
    public boolean existeElemento(Collection c, BeanDistribucion bean) throws Exception {

        Iterator iterator = c.iterator();
        while (iterator.hasNext()) {
            objBeanDI = (BeanDistribucion) iterator.next();
            if (objBeanDI.getCodigoOrganizacion().equals(bean.getCodigoOrganizacion())) {
                return true;
            }
        }
        return false;

    }

    @Override
    public void FormularDocumentoTransaction(BeanDocumento beanDocumento, BeanCuerpoDocumento beanCuerpo, BeanHistorialDocumento beanHistorial, Collection distribuciones, Collection referencias, Collection piezasadjuntas) throws SQLException {
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_TRANSACTION(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?); end;";
            //conn.setAutoCommit(false);
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.VARCHAR);
            cs.setString(2, beanDocumento.getPeriodo());
            cs.setString(3, beanDocumento.getTipoOrganizacion());
            cs.setString(4, beanDocumento.getCodigoOrganizacion());
            cs.setString(5, beanDocumento.getClase());
            cs.setString(6, beanDocumento.getClave());
            cs.setString(7, beanDocumento.getArchivo());
            cs.setString(8, beanDocumento.getClasificacion());
            cs.setString(9, beanDocumento.getPrioridad());
            cs.setString(10, beanDocumento.getAsunto());
            cs.setString(11, beanDocumento.getUsuario());
            cs.setString(12, beanHistorial.getVHDOCUMENTO_COD_USUARIO());
            cs.setString(13, beanDocumento.getCodigoOrganizacionDep());
            cs.setString(14, beanDocumento.getCodigoOrganizacionNiv());
            cs.setString(15, beanDocumento.getGuarnicion());
            cs.setString(16, beanDocumento.getV_firma_usuario());
            cs.setString(17, beanHistorial.getVHDOCUMENTO_OBERVACION());
            cs.setString(18, beanDocumento.getV_tipo_accion());
            cs.executeUpdate();
            String numeroInternoReferencia = (String) cs.getObject(1);
            pcs = conn.prepareStatement("UPDATE SAGDE_CUERPO_DOC set LCDOCUMENTO_CUERPO_DOC=? where CCDOCUMENTO_PERIODO=? AND CCDOCUMENTO_COD_DOC_INT=?");
            pcs.setObject(1, beanCuerpo.getLCDOCUMENTO_CUERPO_DOC());
            pcs.setString(2, beanDocumento.getPeriodo());
            pcs.setString(3, numeroInternoReferencia);
            pcs.executeUpdate();
            cs.clearParameters();
            if (referencias != null) {
                Iterator iterator = referencias.iterator();
                while (iterator.hasNext()) {
                    cs.clearParameters();
                    objBeanT = (BeanTemporal) iterator.next();
                    cs = conn.prepareCall("{call SP_INS_REFERENCIA(?,?,?,?)}");
                    cs.setString(1, beanDocumento.getPeriodo());
                    cs.setString(2, numeroInternoReferencia);
                    cs.setString(3, objBeanT.getCTEMP_PERIODO());
                    cs.setString(4, objBeanT.getCTEMP_COD_DOC());
                    cs.execute();
                }
            }
            Iterator iterator2 = distribuciones.iterator();
            while (iterator2.hasNext()) {
                cs.clearParameters();
                objBeanDI = (BeanDistribucion) iterator2.next();
                cs = conn.prepareCall("{call SP_INS_DISTRIBUCION(?,?,?,?,?,?,?,?,?,?)}");
                cs.setString(1, beanDocumento.getPeriodo());
                cs.setString(2, numeroInternoReferencia);
                cs.setString(3, objBeanDI.getTipoOrganizacion());
                cs.setString(4, objBeanDI.getCodigoOrganizacion());
                cs.setString(5, objBeanDI.getGrado());
                cs.setString(6, objBeanDI.getNombre());
                cs.setString(7, objBeanDI.getCargo());
                cs.setString(8, objBeanDI.getTipo());
                cs.setString(9, "N");
                cs.setString(10, "");
                cs.execute();
            }
            if (piezasadjuntas != null) {
                Iterator iterator3 = piezasadjuntas.iterator();
                while (iterator3.hasNext()) {
                    pcs.clearParameters();
                    objBeanT = (BeanTemporal) iterator3.next();
                    pcs = conn.prepareStatement("INSERT INTO SAGDE_ANEXOS(CANEXO_PERIODO,CANEXO_COD_DOC_INT,CANEXO_SECUENCIA,VANEXO_NOMBRE,VANEXO_TOKEN) VALUES(?,?,?,?,?)");
                    String secuencia = generarCodigoAnexo(beanDocumento.getPeriodo(), numeroInternoReferencia);
                    pcs.setString(1, beanDocumento.getPeriodo());
                    pcs.setString(2, numeroInternoReferencia);
                    pcs.setString(3, secuencia);
                    pcs.setString(4, objBeanT.getVTEMP_NOMBRE());
                    pcs.setString(5, objBeanT.getVTEMP_TOKEN());
                    pcs.executeUpdate();
                }
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            cs.close();
            pcs.close();
            conn.close();
        }
    }

    @Override
    public String generarCodigoAnexo(String periodo, String interno) throws SQLException {

        String codigo = "";
        try {
            String sql = "SELECT LPAD(NVL(MAX(CANEXO_SECUENCIA),0)+1,5,'0') FROM SAGDE_ANEXOS where CANEXO_PERIODO=" + periodo + "AND CANEXO_COD_DOC_INT=" + interno;
            conn = getConnection();
            st = conn.createStatement();
            rs = st.executeQuery(sql);
            while (rs.next()) {
                codigo = rs.getString(1);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            st.close();
            conn.close();
        }
        return codigo;

    }

    @Override
    public String insertarAnexoTemporal(BeanTemporal objBean) throws SQLException {
        String nro_doc_int = "";
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO_ANE(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.VARCHAR);
            cs.setString(2, "A");
            cs.setString(3, objBean.getVTEMP_USUARIO());
            cs.setString(4, objBean.getCTEMP_CODORG());
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.executeUpdate();
            nro_doc_int = (String) cs.getObject(1);
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            cs.close();
            conn.close();
        }
        return nro_doc_int;
    }

    @Override
    public void insertarReferenciaTemporal(BeanTemporal objBean) throws SQLException {
        try {
            conn = getConnection();
            String query = "{call SP_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
            cs = conn.prepareCall(query);
            cs.setString(1, "B");
            cs.setString(2, objBean.getVTEMP_USUARIO());
            cs.setString(3, objBean.getCTEMP_CODORG());
            cs.setString(4, objBean.getCTEMP_PERIODO());
            cs.setString(5, objBean.getCTEMP_COD_DOC());
            cs.setString(6, objBean.getCTEMP_COD_ESTADO());
            cs.setString(7, objBean.getVTEMP_TOKEN());
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.setString(13, "");
            cs.setString(14, "");
            cs.setString(15, "");
            cs.setString(16, "");
            cs.setString(17, "");
            cs.setString(18, "");
            cs.setString(19, "");
            cs.setString(20, "");
            cs.setString(21, "");
            cs.executeUpdate();
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            cs.close();
            conn.close();
        }
    }

    @Override
    public Collection listarAnexoTemporal(String usuario, String interna) throws SQLException {
        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "N");
            cs.setString(3, usuario);
            cs.setString(4, interna);
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanT = new BeanTemporal();
                objBeanT.setVTEMP_USUARIO(rs.getString(1));
                objBeanT.setCTEMP_CODORG(rs.getString(2));
                objBeanT.setCTEMP_TIPO(rs.getString(3));
                objBeanT.setCTEMP_SECUENCIA(rs.getString(4));
                objBeanT.setVTEMP_NOMBRE(rs.getString(5));
                objBeanT.setVTEMP_TOKEN(rs.getString(6));
                lista.add(objBeanT);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return lista;
    }

    @Override
    public Collection listarReferenciaTemporal(String usuario, String interna) throws SQLException {
        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "O");
            cs.setString(3, usuario);
            cs.setString(4, interna);
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                BeanTemporal objBeanT = new BeanTemporal();
                objBeanT.setVTEMP_USUARIO(rs.getString(1));
                objBeanT.setCTEMP_CODORG(rs.getString(2));
                objBeanT.setCTEMP_TIPO(rs.getString(3));
                objBeanT.setCTEMP_SECUENCIA(rs.getString(4));
                objBeanT.setVTEMP_TOKEN(rs.getString(5));
                objBeanT.setCTEMP_PERIODO(rs.getString(6));
                objBeanT.setCTEMP_COD_DOC(rs.getString(7));
                objBeanT.setCTEMP_COD_ESTADO(rs.getString(8));
                objBeanT.setVTEMP_REFORD_COD(rs.getString(9));
                objBeanT.setCDOCUMENTO_CLASE(rs.getString(10));
                objBeanT.setVCLASE_NOM_CORTO(rs.getString(11));
                objBeanT.setCDOCUMENTO_NRO_ORDEN(rs.getString(12));
                objBeanT.setVDOCUMENTO_CLAVE_INDIC(rs.getString(13));
                objBeanT.setDDOCUMENTO_FECHA(rs.getString(14));
                objBeanT.setVREFORD_DESC(rs.getString(15));
                lista.add(objBeanT);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return lista;
    }

    @Override
    public void eliminarAnexoTemporal(BeanTemporal objBean) throws SQLException {
        try {
            conn = getConnection();
            String query = "{call SP_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
            cs = conn.prepareCall(query);
            cs.setString(1, "C");
            cs.setString(2, objBean.getVTEMP_USUARIO());
            cs.setString(3, objBean.getCTEMP_CODORG());
            cs.setString(4, objBean.getCTEMP_SECUENCIA());
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.setString(13, "");
            cs.setString(14, "");
            cs.setString(15, "");
            cs.setString(16, "");
            cs.setString(17, "");
            cs.setString(18, "");
            cs.setString(19, "");
            cs.setString(20, "");
            cs.setString(21, "");
            cs.executeUpdate();
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            cs.close();
            conn.close();
        }
    }

    @Override
    public void eliminarReferenciaTemporal(BeanTemporal objBean) throws SQLException {
        try {
            conn = getConnection();
            String query = "{call SP_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
            cs = conn.prepareCall(query);
            cs.setString(1, "D");
            cs.setString(2, objBean.getVTEMP_USUARIO());
            cs.setString(3, objBean.getCTEMP_CODORG());
            cs.setString(4, objBean.getCTEMP_SECUENCIA());
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.setString(13, "");
            cs.setString(14, "");
            cs.setString(15, "");
            cs.setString(16, "");
            cs.setString(17, "");
            cs.setString(18, "");
            cs.setString(19, "");
            cs.setString(20, "");
            cs.setString(21, "");
            cs.executeUpdate();
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            cs.close();
            conn.close();
        }
    }

    @Override
    public Collection obtenerPeriodo() throws SQLException {
        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "P");
            cs.setString(3, "");
            cs.setString(4, "");
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanP = new BeanPeriodo();
                objBeanP.setCPERIODO_CODIGO(rs.getString(1));
                objBeanP.setVPERIODO_DEFINICION(rs.getString(2));
                lista.add(objBeanP);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return lista;
    }

    @Override
    public Collection obtenerOrganizacionEjercito_MP() throws SQLException {
        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "Q");
            cs.setString(3, "");
            cs.setString(4, "");
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanOI = new BeanOrganizacionInterna();
                objBeanOI.setVOINTERNA_NOM_CORTO(rs.getString(1));
                objBeanOI.setCOINTERNA_CODIGO(rs.getString(2));
                lista.add(objBeanOI);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return lista;
    }

    @Override
    public Collection obtenerClaseDocumento() throws SQLException {
        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "R");
            cs.setString(3, "");
            cs.setString(4, "");
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanC = new BeanClase();
                objBeanC.setCCLASE_CODIGO(rs.getString(1));
                objBeanC.setVCLASE_NOM_LARGO(rs.getString(2));
                lista.add(objBeanC);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return lista;
    }

    @Override
    public Collection obtenerBusqReferencia(String cbo_Tipo_Organizacion, String org, String txtFecDesde, String txtFecHasta, String cbx_Clase_Doc, String txt_nro_doc, String txt_Asunto_Ref, String cbo_Periodo, String jefeUnidad) throws SQLException {
        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "S");
            cs.setString(3, cbo_Tipo_Organizacion);
            cs.setString(4, org);
            cs.setString(5, txtFecDesde);
            cs.setString(6, txtFecHasta);
            cs.setString(7, cbx_Clase_Doc);
            cs.setString(8, txt_nro_doc);
            cs.setString(9, txt_Asunto_Ref);
            cs.setString(10, cbo_Periodo);
            cs.setString(11, jefeUnidad);
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanR = new BeanReferencia();
                objBeanR.setCDOCUMENTO_PERIODO(rs.getString(1));
                objBeanR.setCDOCUMENTO_COD_DOC_INT(rs.getString(2));
                objBeanR.setCDOCUMENTO_CLASE(rs.getString(3));
                objBeanR.setVCLASE_NOM_CORTO(rs.getString(4));
                objBeanR.setCDOCUMENTO_NRO_ORDEN(rs.getString(5));
                objBeanR.setVDOCUMENTO_ASUNTO(rs.getString(6));
                objBeanR.setFECHA_DOC_ORIGEN(rs.getString(7));
                objBeanR.setFEC_ING_SISTEMA(rs.getString(8));
                objBeanR.setVOINTERNA_NOM_CORTO(rs.getString(9));
                objBeanR.setVDISTRIBUCION_TOKEN(rs.getString(10));
                lista.add(objBeanR);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return lista;
    }

    @Override
    public Collection obtenerReferenciaOrden() throws SQLException {
        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "T");
            cs.setString(3, "");
            cs.setString(4, "");
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanRO = new BeanReferenciaOrden();
                objBeanRO.setVREFORD_COD(rs.getString(1));
                objBeanRO.setVREFORD_DESC(rs.getString(2));
                lista.add(objBeanRO);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return lista;
    }

    @Override
    public void actualizarOrdenReferenciaTemporal(BeanTemporal objBean) throws SQLException {
        try {
            conn = getConnection();
            String query = "{call SP_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
            cs = conn.prepareCall(query);
            cs.setString(1, "E");
            cs.setString(2, objBean.getVTEMP_USUARIO());
            cs.setString(3, objBean.getCTEMP_CODORG());
            cs.setString(4, objBean.getCTEMP_SECUENCIA());
            cs.setString(5, objBean.getVTEMP_REFORD_COD());
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.setString(13, "");
            cs.setString(14, "");
            cs.setString(15, "");
            cs.setString(16, "");
            cs.setString(17, "");
            cs.setString(18, "");
            cs.setString(19, "");
            cs.setString(20, "");
            cs.setString(21, "");
            cs.executeUpdate();
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            cs.close();
            conn.close();
        }
    }

    @Override
    public String insertarReferencia(BeanRegistroDocumento objBeanRD) throws SQLException {
        String nro_doc_int = "";
        try {
            conn = getConnection();
            String query = "begin ? := SF_FORMULAR_DOCUMENTO_REF(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.VARCHAR);
            cs.setString(2, "A");
            cs.setString(3, objBeanRD.getCDOCUMENTO_PERIODO());
            cs.setString(4, objBeanRD.getCDOCUMENTO_TIPO_ORG_ORIG());
            cs.setString(5, objBeanRD.getCDOCUMENTO_COD_ORG_ORIG());
            cs.setString(6, objBeanRD.getCDOCUMENTO_CLASE());
            cs.setString(7, objBeanRD.getCDOCUMENTO_NRO_ORDEN());
            cs.setString(8, objBeanRD.getVDOCUMENTO_CLAVE_INDIC());
            cs.setString(9, objBeanRD.getDDOCUMENTO_FECHA());
            cs.setString(10, objBeanRD.getVDOCUMENTO_ASUNTO());
            cs.setString(11, objBeanRD.getCDOCUMENTO_CLASIFICACION());
            cs.setString(12, objBeanRD.getCDOCUMENTO_PRIORIDAD());
            cs.setString(13, objBeanRD.getVDOCUMENTO_USUARIO());
            cs.setString(14, objBeanRD.getCOD_ORG_USUARIO());
            cs.setString(15, "");
            cs.setString(16, "");
            cs.setString(17, "");
            cs.setString(18, "");
            cs.setString(19, "");
            cs.setString(20, "");
            cs.setString(21, "");
            cs.setString(22, "");
            cs.executeUpdate();
            nro_doc_int = (String) cs.getObject(1);
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            cs.close();
            conn.close();
        }
        return nro_doc_int;
    }

    @Override
    public void limpiaTemporales(String usuario, String interna) throws SQLException {
        try {
            conn = getConnection();
            String query = "{call SP_FORMULAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
            cs = conn.prepareCall(query);
            cs.setString(1, "F");
            cs.setString(2, usuario);
            cs.setString(3, interna);
            cs.setString(4, "");
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.setString(13, "");
            cs.setString(14, "");
            cs.setString(15, "");
            cs.setString(16, "");
            cs.setString(17, "");
            cs.setString(18, "");
            cs.setString(19, "");
            cs.setString(20, "");
            cs.setString(21, "");
            cs.executeUpdate();
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            cs.close();
            conn.close();
        }
    }

}
