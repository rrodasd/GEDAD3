package sagde.comun;

/*
** Clase que permite la conexi�n a una BD
 */
import java.sql.*;

public class OracleDBConn {

    static {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");

        } catch (ClassNotFoundException e) {
            System.out.println(
                    "Proyecto: "
                    + Parametros.S_APP_NOMBRE
                    + "; Clase: "
                    + "sagde.comun.OracleDBConn"
                    + "; Mensaje:"
                    + e);

        }
    }

    /**
     * Obtiene una conexi�n a la Base de Datos.
     *
     * @return
     */
    public Connection getConnection() {

        Connection connection = null;
        try {

            connection = DriverManager.getConnection(
                    //PRODUCCION
                   // "jdbc:oracle:thin:@10.64.3.25:1522:BDEP",
                   // "SAGADM", "mNBVCXZAq");||||
                    
                    //DESARROLLO
                    "jdbc:oracle:thin:@10.64.3.24:1522:BDEP",
                    "EP_GEDAD", "M8474BGSG");
        } catch (SQLException e) {
            System.out.println(
                    "Proyecto: "
                    + Parametros.S_APP_NOMBRE
                    + "; Clase: "
                    + getClass().getName()
                    + "; Mensaje:"
                    + e);

        }
        return connection;
    }
}
