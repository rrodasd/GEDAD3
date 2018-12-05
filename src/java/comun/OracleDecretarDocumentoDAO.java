package comun;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import oracle.jdbc.OracleTypes;
import sagde.bean.BeanAccion;
import sagde.bean.BeanAnexo;
import sagde.bean.BeanDecreto;
import sagde.bean.BeanDistribucion;
import sagde.bean.BeanOrganizacionInterna;
import sagde.bean.BeanPrioridadDocumento;
import sagde.comun.OracleDBConn;
import sagde.comun.Parametros;

/**
 *
 * @author rbermudezf
 */
public class OracleDecretarDocumentoDAO implements DecretarDocumentoDAO {

    Connection conn = null;
    CallableStatement cs = null;
    PreparedStatement pcs = null;
    ResultSet rs = null;
    Statement st = null;
    Collection lista = null;

    private Connection getConnection() {
        OracleDBConn cnx = new OracleDBConn();
        return cnx.getConnection();
    }

    @Override
    public Collection obtenerDocumentos_X_Decretar(String interna, String usuario) throws SQLException {

        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_DECRETAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "A");
            cs.setString(3, interna);
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
                BeanDecreto objBeanD = new BeanDecreto();
                objBeanD.setCDOCUMENTO_PERIODO(rs.getString(1));
                objBeanD.setCDOCUMENTO_COD_DOC_INT(rs.getString(2));
                objBeanD.setCDECRETO_COD_ORG(rs.getString(3));
                objBeanD.setCDOCUMENTO_CLASE(rs.getString(4));
                objBeanD.setVCLASE_NOM_CORTO(rs.getString(5));
                objBeanD.setCDOCUMENTO_NRO_ORDEN(rs.getString(6));
                objBeanD.setVDOCUMENTO_CLAVE_INDIC(rs.getString(7));
                objBeanD.setVDOCUMENTO_ASUNTO(rs.getString(8));
                objBeanD.setVOINTERNA_NOM_CORTO(rs.getString(9));
                objBeanD.setDDECRETO_FECH_DEC(rs.getString(10));
                objBeanD.setDDOCUMENTO_FECHA(rs.getString(11));
                objBeanD.setCDISTRIBUCION_TIPO_DISTRIB(rs.getString(12));
                objBeanD.setDDECRETO_FECH_EJEC(rs.getString(13));
                objBeanD.setFECH_DEC(rs.getString(14));
                objBeanD.setVDISTRIBUCION_TOKEN(rs.getString(15));
                objBeanD.setTIPO_DECRETO(rs.getString(16));
                objBeanD.setCDECRETO_PRIORIDAD(rs.getString(17));
                objBeanD.setCDECRETO_COD_ORG_ENC(rs.getString(18));
                objBeanD.setVDECRETO_OBSERVACION(rs.getString(19));
                objBeanD.setCDOCUMENTO_COD_ORG_DEP(rs.getString(20));
                objBeanD.setCDOCUMENTO_TIPO_ORG_ORIG(rs.getString(21));
                objBeanD.setVPRIORIDAD_NOMBRE(rs.getString(22));
                objBeanD.setVDISTRIBUCION_NOM_FILE(rs.getString(23));
                lista.add(objBeanD);
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
    public Collection obtenerOrganizacionEncargatura(String interna, String usuario) throws SQLException {

        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_DECRETAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "B");
            cs.setString(3, interna);
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
                BeanOrganizacionInterna objBeanOI = new BeanOrganizacionInterna();
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
    public Collection obtenerDocumentos_X_DecretarconFiltro(String interna, String interna_encargada) throws SQLException {

        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_DECRETAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "C");
            cs.setString(3, interna);
            cs.setString(4, interna_encargada);
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
                BeanDecreto objBeanD = new BeanDecreto();
                objBeanD.setCDOCUMENTO_PERIODO(rs.getString(1));
                objBeanD.setCDOCUMENTO_COD_DOC_INT(rs.getString(2));
                objBeanD.setCDECRETO_COD_ORG(rs.getString(3));
                objBeanD.setCDOCUMENTO_CLASE(rs.getString(4));
                objBeanD.setVCLASE_NOM_CORTO(rs.getString(5));
                objBeanD.setCDOCUMENTO_NRO_ORDEN(rs.getString(6));
                objBeanD.setVDOCUMENTO_CLAVE_INDIC(rs.getString(7));
                objBeanD.setVDOCUMENTO_ASUNTO(rs.getString(8));
                objBeanD.setVOINTERNA_NOM_CORTO(rs.getString(9));
                objBeanD.setDDECRETO_FECH_DEC(rs.getString(10));
                objBeanD.setDDOCUMENTO_FECHA(rs.getString(11));
                objBeanD.setCDISTRIBUCION_TIPO_DISTRIB(rs.getString(12));
                objBeanD.setDDECRETO_FECH_EJEC(rs.getString(13));
                objBeanD.setFECH_DEC(rs.getString(14));
                objBeanD.setVDISTRIBUCION_TOKEN(rs.getString(15));
                objBeanD.setTIPO_DECRETO(rs.getString(16));
                objBeanD.setCDECRETO_PRIORIDAD(rs.getString(17));
                objBeanD.setCDECRETO_COD_ORG_ENC(rs.getString(18));
                objBeanD.setVDECRETO_OBSERVACION(rs.getString(19));                
                objBeanD.setCDOCUMENTO_COD_ORG_DEP(rs.getString(20));
                objBeanD.setCDOCUMENTO_TIPO_ORG_ORIG(rs.getString(21));
                objBeanD.setVPRIORIDAD_NOMBRE(rs.getString(22));
                objBeanD.setVDISTRIBUCION_NOM_FILE(rs.getString(23));
                lista.add(objBeanD);
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
    public Collection obtenerOrganizacionSubordinada(String interna, String internaSesion) throws SQLException {

        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_DECRETAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "D");
            cs.setString(3, interna);
            cs.setString(4, internaSesion);
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
                BeanOrganizacionInterna objBeanOI = new BeanOrganizacionInterna();
                objBeanOI.setCOINTERNA_CODIGO(rs.getString(1));
                objBeanOI.setNOINTERNA_NIVEL(rs.getString(2));
                objBeanOI.setVOINTERNA_NOM_CORTO(rs.getString(3));
                objBeanOI.setVOINTERNA_NOM_LARGO(rs.getString(4));
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
    public Collection obtenerAccion() throws SQLException {

        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_DECRETAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "E");
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
                BeanAccion objBeanA = new BeanAccion();
                objBeanA.setCACCION_CODIGO(rs.getString(1));
                objBeanA.setVACCION_NOMBRE(rs.getString(2));
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
    public Collection obtenerPrioridades() throws SQLException {

        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_DECRETAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "F");
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
    public void insertarDecreto(BeanDecreto objBean, String interna, String encargada) throws SQLException {

        try {
            conn = getConnection();
            ArrayList listaInterna = (ArrayList) objBean.getLISTA_INTERNA();
            for (int j = 0; j < listaInterna.size(); j++) {
                objBean.setCDECRETO_COD_ORG((listaInterna.get(j).toString()));
                ArrayList listaAccion = (ArrayList) objBean.getLISTA_ACCION();
                for (int i = 0; i < listaAccion.size(); i++) {
                    String query = "{call SP_DECRETAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
                    cs = conn.prepareCall(query);
                    cs.setString(1, "A");
                    cs.setString(2, objBean.getCDOCUMENTO_PERIODO());
                    cs.setString(3, objBean.getCDOCUMENTO_COD_DOC_INT());
                    cs.setString(4, objBean.getCDECRETO_COD_ORG());
                    cs.setString(5, "");
                    cs.setString(6, listaAccion.get(i).toString());
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
                }
                String query = "{call SP_DECRETAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
                cs = conn.prepareCall(query);
                cs.setString(1, "B");
                cs.setString(2, objBean.getCDOCUMENTO_PERIODO());
                cs.setString(3, objBean.getCDOCUMENTO_COD_DOC_INT());
                cs.setString(4, objBean.getCDECRETO_COD_ORG());
                cs.setString(5, objBean.getCDECRETO_NRO_DECRETO());
                cs.setString(6, objBean.getCDECRETO_PRIORIDAD());
                cs.setString(7, "");
                cs.setString(8, objBean.getVDECRETO_OBSERVACION());
                cs.setString(9, "");
                cs.setString(10, objBean.getVDECRETO_COD_USUARIO());
                cs.setString(11, objBean.getDDECRETO_FECH_EJEC());
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
            }
            String query = "{call SP_DECRETAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
            cs = conn.prepareCall(query);
            cs.setString(1, "C");
            cs.setString(2, objBean.getCDOCUMENTO_PERIODO());
            cs.setString(3, objBean.getCDOCUMENTO_COD_DOC_INT());
            cs.setString(4, interna);
            cs.setString(5, encargada);
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
    public void elevarDecreto(BeanDecreto objBean) throws SQLException {
        try {
            conn = getConnection();
            String query = "{call SP_DECRETAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
            cs = conn.prepareCall(query);
            cs.setString(1, "D");
            cs.setString(2, objBean.getCDOCUMENTO_PERIODO());
            cs.setString(3, objBean.getCDOCUMENTO_COD_DOC_INT());
            cs.setString(4, objBean.getCDECRETO_COD_ORG());
            cs.setString(5, objBean.getCDECRETO_NRO_DECRETO());
            cs.setString(6, objBean.getCDECRETO_PRIORIDAD());
            cs.setString(7, objBean.getCDECRETO_COD_ORG_ENC());
            cs.setString(8, objBean.getVDECRETO_OBSERVACION());
            cs.setString(9, "");
            cs.setString(10, objBean.getVDECRETO_COD_USUARIO());
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
        }catch(SQLException e){
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        }finally{
            cs.close();
            conn.close();
        }
    }

    @Override
    public Collection obtenerAccionesDecretadas(BeanDecreto objBean) throws SQLException {
        
        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_DECRETAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "G");
            cs.setString(3, objBean.getCDOCUMENTO_PERIODO());
            cs.setString(4, objBean.getCDOCUMENTO_COD_DOC_INT());
            cs.setString(5, objBean.getCDECRETO_COD_ORG());
            cs.setString(6, objBean.getCDECRETO_COD_ORG_ENC());
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                BeanAccion objBeanA = new BeanAccion();
                objBeanA.setCACCION_CODIGO(rs.getString(1));
                objBeanA.setVACCION_NOMBRE(rs.getString(2));
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
    public void archivarDecreto(BeanDecreto objBean) throws SQLException {
        try {
            conn = getConnection();
            String query = "{call SP_DECRETAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
            cs = conn.prepareCall(query);
            cs.setString(1, "E");
            cs.setString(2, objBean.getCDOCUMENTO_PERIODO());
            cs.setString(3, objBean.getCDOCUMENTO_COD_DOC_INT());
            cs.setString(4, objBean.getCDECRETO_COD_ORG());
            cs.setString(5, objBean.getCDECRETO_COD_ORG_ENC());
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
        }catch(SQLException e){
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        }finally{
            cs.close();
            conn.close();
        }
    }

    @Override
    public Collection obtenerDecretos(String periodo, String interna) throws SQLException {
        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_DECRETAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "I");
            cs.setString(3, periodo);
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
                BeanAccion objBeanA = new BeanAccion();
                objBeanA.setCACCION_CODIGO(rs.getString(1));
                objBeanA.setVACCION_NOMBRE(rs.getString(2));
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
    public Collection listaAnexo(String periodo, String interna) throws SQLException {
        lista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_DECRETAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "J");
            cs.setString(3, periodo);
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
                BeanAnexo objBeanA = new BeanAnexo();
                objBeanA.setCANEXO_PERIODO(rs.getString(1));
                objBeanA.setCANEXO_COD_DOC_INT(rs.getString(2));
                objBeanA.setCANEXO_SECUENCIA(rs.getString(3));
                objBeanA.setVANEXO_NOMBRE(rs.getString(4));
                objBeanA.setVANEXO_TOKEN(rs.getString(5));
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
    public void acuseReciboDistribucion(BeanDistribucion objBeanD) throws SQLException {
        try {
            conn = getConnection();
            String query = "{call SP_DECRETAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
            cs = conn.prepareCall(query);
            cs.setString(1, "F");
            cs.setString(2, objBeanD.getPeriodo());
            cs.setString(3, objBeanD.getCodigoDocumento());
            cs.setString(4, objBeanD.getCodigoOrganizacion());
            cs.setString(5, objBeanD.getTipoOrganizacion());
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
        }catch(SQLException e){
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        }finally{
            cs.close();
            conn.close();
        }
    }

}
