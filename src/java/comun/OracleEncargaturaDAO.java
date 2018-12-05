package comun;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import oracle.jdbc.OracleTypes;
import sagde.bean.BeanEncargatura;
import sagde.comun.OracleDBConn;
import sagde.comun.Parametros;

/**
 *
 * @author rbermudezf
 */
public class OracleEncargaturaDAO implements EncargaturaDAO {

    Connection conn = null;
    CallableStatement cs = null;
    ResultSet rs = null;
    
    private Connection getConnection() {
        OracleDBConn cnx = new OracleDBConn();
        return cnx.getConnection();
    }
    
    @Override
    public String obtenerCodigoEncargaturaxTipo(BeanEncargatura objBeanE) throws Exception {
        String codigo = "";
        try {
            conn = getConnection();
            String query = "begin ? := SF_ENCARGATURA(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "A");
            cs.setString(3, objBeanE.getVENCARGATURA_USUARIO());
            cs.setString(4, objBeanE.getCENCARGATURA_TIPO());
            cs.setString(5, objBeanE.getCENCARGATURA_COD_ORG_ENC());
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
                codigo = (String) rs.getString(1);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return codigo;
    }

    @Override
    public Collection listarEncargaturaxTipo(String interna, String tipo) throws SQLException {
        
        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_ENCARGATURA(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "B");
            cs.setString(3, interna);
            cs.setString(4, tipo);
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
                BeanEncargatura objBeanE = new BeanEncargatura();
                objBeanE.setCENCARGATURA_COD_ORG(rs.getString(1));
                objBeanE.setVOINTERNA_NOM_CORTO(rs.getString(2));
                objBeanE.setCENCARGATURA_COD_ORG_ENC(rs.getString(3));
                objBeanE.setVOINTERNA_NOM_CORTO_2(rs.getString(4));
                objBeanE.setCENCARGATURA_TIPO(rs.getString(5));
                objBeanE.setDENCARGATURA_DESDE(rs.getString(6));
                objBeanE.setDENCARGATURA_HASTA(rs.getString(7));
                objBeanE.setVENCARGATURA_USUARIO(rs.getString(8));
                objBeanE.setAPENOM(rs.getString(9));
                objBeanE.setCMILITAR_GRADOACTUAL(rs.getString(10));
                objBeanE.setCGRADO_DESCCORT(rs.getString(11));
                objBeanE.setVARMA_CATEG(rs.getString(12));
                objBeanE.setVARMACAT_DESCORT(rs.getString(13));
                objBeanE.setTIPOENCARGATURA_DESC(rs.getString(14));
                objLista.add(objBeanE);
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
    public Collection listarTipoEncargaturaxUsuario(String interna, String usuario) throws SQLException {
        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_ENCARGATURA(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "C");
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
                BeanEncargatura objBeanE = new BeanEncargatura();
                objBeanE.setCENCARGATURA_TIPO(rs.getString(1));
                objBeanE.setCENCARGATURA_COD_ORG(rs.getString(2));
                objLista.add(objBeanE);
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
    
}