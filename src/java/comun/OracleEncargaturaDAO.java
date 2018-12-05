package comun;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
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
    
}