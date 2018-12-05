package comun;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import oracle.jdbc.OracleTypes;
import sagde.bean.BeanOrganizacionInterna;
import sagde.bean.BeanPersona;
import sagde.bean.BeanUsuarioAD;
import sagde.comun.OracleDBConn;
import sagde.comun.Parametros;

public class OracleUsuarioADDAO implements UsuarioADDAO {

    Connection conn = null;
    CallableStatement cs = null;
    PreparedStatement pcs = null;
    ResultSet rs = null;

    private Connection getConnection() {
        OracleDBConn cnx = new OracleDBConn();
        return cnx.getConnection();
    }

    @Override
    public Collection listarUsuario(String interna) throws SQLException {

        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_USUARIO_AD(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "A");
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
                BeanUsuarioAD objBeanUAD = new BeanUsuarioAD();
                objBeanUAD.setVUSUARIO_CODIGO(rs.getString(1));
                objBeanUAD.setCUSUARIO_COD_ORG(rs.getString(2));
                objBeanUAD.setVUSUARIO_CARGO(rs.getString(3));
                objBeanUAD.setDUSUARIO_FECH_REG(rs.getString(4));
                objBeanUAD.setCUSUARIO_ESTADO(rs.getString(5));
                objBeanUAD.setCUSUARIO_FLAG_JEFE(rs.getString(6));
                objBeanUAD.setCPERSONA_NRODOC(rs.getString(7));
                objBeanUAD.setCMILITAR_CIP(rs.getString(8));
                objBeanUAD.setVPERSONA_NOMBRE(rs.getString(9));
                objBeanUAD.setVPERSONA_APETPAT(rs.getString(10));
                objBeanUAD.setVPERSONA_APETMAT(rs.getString(11));
                objBeanUAD.setAPENOM(rs.getString(12));
                objBeanUAD.setCMILITAR_GRADOACTUAL(rs.getString(13));
                objBeanUAD.setCGRADO_DESCCORT(rs.getString(14));
                objBeanUAD.setCARMA_COD(rs.getString(15));
                objBeanUAD.setVARMAS_DESCOR(rs.getString(16));
                objBeanUAD.setVPERSONA_CORREOEP(rs.getString(17));
                objBeanUAD.setNICKNAME(rs.getString(18));
                objBeanUAD.setCMILITAR_UUACTUAL(rs.getString(19));
                objBeanUAD.setVUNIDAD_DESCOR(rs.getString(20));
                objBeanUAD.setVOINTERNA_NOM_CORTO(rs.getString(21));
                objLista.add(objBeanUAD);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objLista;

    }
    
    @Override
    public BeanUsuarioAD obtenerUsuario(String usuario) throws SQLException {
        System.out.println("usuariousuariousuariousuariousuario+"+usuario+"-");
        BeanUsuarioAD objBeanUAD = new BeanUsuarioAD();
        try {
            conn = getConnection();
            String query = "begin ? := SF_USUARIO_AD(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "B");
            cs.setString(3, usuario);
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
                objBeanUAD = new BeanUsuarioAD();
                objBeanUAD.setVUSUARIO_CODIGO(rs.getString(1));
                objBeanUAD.setCUSUARIO_COD_ORG(rs.getString(2));
                objBeanUAD.setVUSUARIO_CARGO(rs.getString(3));
                objBeanUAD.setDUSUARIO_FECH_REG(rs.getString(4));
                objBeanUAD.setCUSUARIO_ESTADO(rs.getString(5));
                objBeanUAD.setCUSUARIO_FLAG_JEFE(rs.getString(6));
                objBeanUAD.setCPERSONA_NRODOC(rs.getString(7));
                objBeanUAD.setCMILITAR_CIP(rs.getString(8));
                objBeanUAD.setVPERSONA_NOMBRE(rs.getString(9));
                objBeanUAD.setVPERSONA_APETPAT(rs.getString(10));
                objBeanUAD.setVPERSONA_APETMAT(rs.getString(11));
                objBeanUAD.setAPENOM(rs.getString(12));
                objBeanUAD.setCMILITAR_GRADOACTUAL(rs.getString(13));
                objBeanUAD.setCGRADO_DESCCORT(rs.getString(14));
                objBeanUAD.setCARMA_COD(rs.getString(15));
                objBeanUAD.setVARMAS_DESCOR(rs.getString(16));
                objBeanUAD.setVPERSONA_CORREOEP(rs.getString(17));
                objBeanUAD.setNICKNAME(rs.getString(18));
                objBeanUAD.setCMILITAR_UUACTUAL(rs.getString(19));
                objBeanUAD.setVUNIDAD_DESCOR(rs.getString(20));
                objBeanUAD.setJEFE_UNIDAD(rs.getString(21));
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objBeanUAD;

    }

    @Override
    public Collection listarUsuarioxEstado(String interna, String estado) throws SQLException {
        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_USUARIO_AD(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "E");
            cs.setString(3, interna);
            cs.setString(4, estado);
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
                objBeanUAD.setDUSUARIO_FECH_REG(rs.getString(4));
                objBeanUAD.setCUSUARIO_ESTADO(rs.getString(5));
                objBeanUAD.setCUSUARIO_FLAG_JEFE(rs.getString(6));
                objBeanUAD.setCPERSONA_NRODOC(rs.getString(7));
                objBeanUAD.setCMILITAR_CIP(rs.getString(8));
                objBeanUAD.setVPERSONA_NOMBRE(rs.getString(9));
                objBeanUAD.setVPERSONA_APETPAT(rs.getString(10));
                objBeanUAD.setVPERSONA_APETMAT(rs.getString(11));
                objBeanUAD.setAPENOM(rs.getString(12));
                objBeanUAD.setCMILITAR_GRADOACTUAL(rs.getString(13));
                objBeanUAD.setCGRADO_DESCCORT(rs.getString(14));
                objBeanUAD.setCARMA_COD(rs.getString(15));
                objBeanUAD.setVARMAS_DESCOR(rs.getString(16));
                objBeanUAD.setVPERSONA_CORREOEP(rs.getString(17));
                objBeanUAD.setNICKNAME(rs.getString(18));
                objBeanUAD.setCMILITAR_UUACTUAL(rs.getString(19));
                objBeanUAD.setVUNIDAD_DESCOR(rs.getString(20));
                objBeanUAD.setVOINTERNA_NOM_CORTO(rs.getString(21));
                objLista.add(objBeanUAD);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objLista;
    }

    @Override
    public void insertarUsuario(BeanUsuarioAD objBean) throws SQLException {
        try {
            conn = getConnection();
            String query = "{call SP_USUARIO_AD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
            cs = conn.prepareCall(query);
            cs.setString(1, "A");
            cs.setString(2, objBean.getVUSUARIO_CODIGO());
            cs.setString(3, objBean.getCUSUARIO_COD_ORG());
            cs.setString(4, objBean.getVUSUARIO_CARGO());
            cs.setString(5, objBean.getCUSUARIO_FLAG_JEFE());
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
    public void actualizarUsuario(BeanUsuarioAD objBean) throws SQLException {
        try {
            conn = getConnection();
            String query = "{call SP_USUARIO_AD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
            cs = conn.prepareCall(query);
            cs.setString(1, "B");
            cs.setString(2, objBean.getVUSUARIO_CODIGO());
            cs.setString(3, objBean.getCUSUARIO_COD_ORG());
            cs.setString(4, objBean.getVUSUARIO_CARGO());
            cs.setString(5, objBean.getCUSUARIO_ESTADO());
            cs.setString(6, objBean.getCUSUARIO_FLAG_JEFE());
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
    public Collection listarOrganizacionxCodigo(String interna) throws SQLException {
        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_USUARIO_AD(?,?,?,?,?,?,?,?,?,?,?); end;";
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
            while (rs.next()) {
                BeanOrganizacionInterna objBeanOI = new BeanOrganizacionInterna();
                objBeanOI.setCOINTERNA_CODIGO(rs.getString(1));
                objBeanOI.setVOINTERNA_NOM_CORTO(rs.getString(2));
                objBeanOI.setVOINTERNA_NOM_LARGO(rs.getString(3));
                objBeanOI.setNOINTERNA_NIVEL(rs.getString(4));
                objLista.add(objBeanOI);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objLista;
    }

    @Override
    public Collection busquedaxApellidosyNombres(String paterno, String materno, String nombres) throws SQLException {
        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_USUARIO_AD(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "D");
            cs.setString(3, paterno);
            cs.setString(4, materno);
            cs.setString(5, nombres);
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
                BeanPersona objBeanP = new BeanPersona();
                objBeanP.setCPERSONA_NRODOC(rs.getString(1));
                objBeanP.setCMILITAR_CIP(rs.getString(2));
                objBeanP.setVPERSONA_NOMBRE(rs.getString(3));
                objBeanP.setVPERSONA_APETPAT(rs.getString(4));
                objBeanP.setVPERSONA_APETMAT(rs.getString(5));
                objBeanP.setAPENOM(rs.getString(6));
                objBeanP.setCMILITAR_GRADOACTUAL(rs.getString(7));
                objBeanP.setCGRADO_DESCCORT(rs.getString(8));
                objBeanP.setCARMA_COD(rs.getString(9));
                objBeanP.setVARMAS_DESCOR(rs.getString(10));
                objBeanP.setVPERSONA_CORREOEP(rs.getString(11));
                objBeanP.setUSUARIO(rs.getString(12));
                objBeanP.setCMILITAR_UUACTUAL(rs.getString(13));
                objBeanP.setVUNIDAD_DESCOR(rs.getString(14));
                objLista.add(objBeanP);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objLista;
    }

    @Override
    public BeanUsuarioAD obtenerUsuarioxDni(String dni) throws SQLException {
        BeanUsuarioAD objBeanUAD = new BeanUsuarioAD();
        try {
            conn = getConnection();
            String query = "begin ? := SF_USUARIO_AD(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "C");
            cs.setString(3, dni);
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
                objBeanUAD = new BeanUsuarioAD();
                objBeanUAD.setVUSUARIO_CODIGO(rs.getString(1));
                objBeanUAD.setCUSUARIO_COD_ORG(rs.getString(2));
                objBeanUAD.setVUSUARIO_CARGO(rs.getString(3));
                objBeanUAD.setDUSUARIO_FECH_REG(rs.getString(4));
                objBeanUAD.setCUSUARIO_ESTADO(rs.getString(5));
                objBeanUAD.setCUSUARIO_FLAG_JEFE(rs.getString(6));
                objBeanUAD.setCPERSONA_NRODOC(rs.getString(7));
                objBeanUAD.setCMILITAR_CIP(rs.getString(8));
                objBeanUAD.setVPERSONA_NOMBRE(rs.getString(9));
                objBeanUAD.setVPERSONA_APETPAT(rs.getString(10));
                objBeanUAD.setVPERSONA_APETMAT(rs.getString(11));
                objBeanUAD.setAPENOM(rs.getString(12));
                objBeanUAD.setCMILITAR_GRADOACTUAL(rs.getString(13));
                objBeanUAD.setCGRADO_DESCCORT(rs.getString(14));
                objBeanUAD.setCARMA_COD(rs.getString(15));
                objBeanUAD.setVARMAS_DESCOR(rs.getString(16));
                objBeanUAD.setVPERSONA_CORREOEP(rs.getString(17));
                objBeanUAD.setNICKNAME(rs.getString(18));
                objBeanUAD.setCMILITAR_UUACTUAL(rs.getString(19));
                objBeanUAD.setVUNIDAD_DESCOR(rs.getString(20));
                objBeanUAD.setVOINTERNA_NOM_CORTO(rs.getString(21));
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objBeanUAD;
    }

    @Override
    public void actualizarUsuarioSE(BeanUsuarioAD objBean) throws SQLException {
        try {
            conn = getConnection();
            String query = "{call SP_USUARIO_AD(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
            cs = conn.prepareCall(query);
            cs.setString(1, "C");
            cs.setString(2, objBean.getVUSUARIO_CODIGO());
            cs.setString(3, objBean.getCUSUARIO_COD_ORG());
            cs.setString(4, objBean.getVUSUARIO_CARGO());
            cs.setString(5, "");
            cs.setString(6, objBean.getCUSUARIO_FLAG_JEFE());
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
