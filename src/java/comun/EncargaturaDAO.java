package comun;

import java.sql.SQLException;
import java.util.Collection;
import sagde.bean.BeanEncargatura;

/**
 *
 * @author rbermudezf
 */
public interface EncargaturaDAO {
    
    public abstract String obtenerCodigoEncargaturaxTipo (BeanEncargatura objBeanE) throws Exception;
    public abstract Collection listarEncargaturaxTipo (String interna, String tipo) throws SQLException;
    public abstract Collection listarTipoEncargaturaxUsuario (String interna, String usuario) throws SQLException;
    
}