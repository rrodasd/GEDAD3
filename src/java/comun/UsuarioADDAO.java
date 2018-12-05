package comun;

import java.sql.SQLException;
import java.util.Collection;
import sagde.bean.BeanUsuarioAD;

public interface UsuarioADDAO {

    public abstract Collection listarUsuario(String interna) throws SQLException;
    public abstract Collection listarUsuarioxEstado (String interna, String estado) throws SQLException;
    public abstract Collection listarOrganizacionxCodigo (String interna) throws SQLException;
    public abstract BeanUsuarioAD obtenerUsuario(String usuario) throws SQLException;
    public abstract void insertarUsuario(BeanUsuarioAD objBean) throws SQLException;
    public abstract void actualizarUsuario(BeanUsuarioAD objBean) throws SQLException;
    public abstract void actualizarUsuarioSE(BeanUsuarioAD objBean) throws SQLException;
    public abstract Collection busquedaxApellidosyNombres(String paterno, String materno, String nombres) throws SQLException;
    public abstract BeanUsuarioAD obtenerUsuarioxDni(String dni) throws SQLException;
    
}