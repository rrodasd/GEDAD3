package comun;

import java.io.FileInputStream;
import java.sql.SQLException;
import java.util.Collection;
import sagde.bean.BeanOrganizacionInterna;

public interface OrganizacionInternaDAO {
    
    public Collection obtenerFullOrgani(String codorg) throws Exception;
    

    public abstract void insertarOrganizacionInterna(BeanOrganizacionInterna entidad) throws Exception;

    public abstract void insertarUsuarioImg(String codigo, FileInputStream file) throws Exception;

    public abstract void actualizarOrganizacionInterna(BeanOrganizacionInterna entidad) throws Exception;

    public abstract void eliminarOrganizacionInterna(String sCodigo) throws Exception;

    public abstract Collection obtenerOrganizacionInterna() throws SQLException;

    public BeanOrganizacionInterna obtenerOrganizacionInternaPK(String sCodigo) throws Exception;

    public String verificarOrganizacionInternaPK(String sCodigo) throws Exception;

    public Collection obtenerFullOrganif() throws Exception;    

    public Collection obtenerUsuariosxNivelInf(String codOrganizacion) throws Exception;

    public void uu_imagen_insertar(String lm, FileInputStream streamEntrada) throws Exception;

    public abstract boolean existeElemento(Collection c, BeanOrganizacionInterna bean);

    public BeanOrganizacionInterna obtener_Tit_Org_Consulta(String codOrganizacion) throws Exception;

}
