package comun;

import sagde.bean.BeanEncargatura;

/**
 *
 * @author rbermudezf
 */
public interface EncargaturaDAO {
    
    public abstract String obtenerCodigoEncargaturaxTipo (BeanEncargatura objBeanE) throws Exception;
    
}