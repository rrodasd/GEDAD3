package comun;

import java.sql.SQLException;
import java.util.Collection;
import sagde.bean.BeanPeriodo;

public interface ComboboxDAO {
    
    public abstract Collection obtenerUsuarioNivelInf(String codOrganizacion)throws SQLException;
    public abstract Collection obtenerOrganizacionInternaNombreLargo(String codigoUsuario, String nivel) throws Exception;
    public abstract BeanPeriodo obtenerDefinicionPeriodo(String anio) throws Exception;
    public abstract String obtenerGuarnicionUsuario(String codigoOrganizacionUsuario) throws Exception;
    public abstract Collection obtenerArchivoIndicativo() throws Exception;
    public abstract Collection obtenerListaOrganizacionInterna(String codigo_org) throws Exception;
    public abstract Collection obtenerListaOrganizacionExterna() throws Exception;
    public abstract Collection obtenerListaOrganizacionEjercito(String codigo_org, String dato) throws Exception;
    public abstract Collection obtenerPrioridades() throws Exception;
    public abstract Collection obtenerfirmadoPor(String nombreUsuario) throws Exception;
    public abstract Collection obtenerRevisadorPor(String nombreUsuario) throws Exception;
    public abstract Collection obtenerRevisadorPor_mismo(String nombreUsuario) throws Exception;
    //Mesa de Parte
    public abstract Collection obtenerPeriodo() throws Exception;
    public abstract Collection obtenerOrganizacionEjercito_MP() throws Exception;
    public abstract Collection obtenerClaseDocumento() throws Exception;
    public abstract Collection obtenerClasificacion() throws Exception;
    public abstract Collection obtenerdDestinariosEP() throws Exception;
    public abstract Collection obtenerGrupo(String usuario) throws Exception;
    
}