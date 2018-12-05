package comun;

import java.sql.SQLException;
import java.util.Collection;
import sagde.bean.BeanDecreto;
import sagde.bean.BeanDistribucion;

public interface DecretarDocumentoDAO {
    /*DECRETAR DOCUMENTO*/
    public abstract Collection obtenerDocumentos_X_Decretar(String interna, String usuario) throws SQLException;
    public abstract Collection obtenerDocumentos_X_DecretarconFiltro(String interna, String interna_encargada) throws SQLException;
    public abstract Collection obtenerOrganizacionEncargatura(String interna, String usuario) throws SQLException;
    public abstract Collection obtenerOrganizacionSubordinada(String interna, String internaSesion) throws SQLException;
    public abstract Collection obtenerAccion() throws SQLException;
    public abstract Collection obtenerPrioridades() throws SQLException;
    public abstract void insertarDecreto(BeanDecreto objBean, String interna, String encargada) throws SQLException;
    public abstract void elevarDecreto(BeanDecreto objBean) throws SQLException;
    public abstract void archivarDecreto(BeanDecreto objBean) throws SQLException;
    public abstract Collection obtenerAccionesDecretadas(BeanDecreto objBean) throws SQLException;
    public abstract Collection obtenerDecretos(String periodo, String interna) throws SQLException;
    public abstract Collection listaAnexo(String periodo, String interna) throws SQLException;
    public abstract void acuseReciboDistribucion(BeanDistribucion objBeanD) throws SQLException;
}