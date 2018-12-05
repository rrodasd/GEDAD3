package comun;

import java.sql.SQLException;
import java.util.Collection;
import sagde.bean.BeanCuerpoDocumento;
import sagde.bean.BeanDistribucion;
import sagde.bean.BeanDocumento;
import sagde.bean.BeanHistorialDocumento;
import sagde.bean.BeanPeriodo;
import sagde.bean.BeanRegistroDocumento;
import sagde.bean.BeanTemporal;

public interface FormularDocumentoDAO {
    /*MENU DOCUMENTOS*/
    public abstract Collection listaClaseFormular() throws SQLException;
    /*FORMULAR DOCUMENTO*/
    public abstract Collection obtenerOrganizacionInternaNombreLargo(String usuario, String nivel) throws SQLException;
    public abstract Collection obtenerUsuariosxNiveles(String usuario, String rol) throws SQLException;
    public abstract String obtenerClave_IndicativoxUsuario(String interna) throws SQLException;
    public abstract String obtenerOrganizacionLugarxUsuario(String interna) throws SQLException;
    public abstract BeanPeriodo obtenerDefinicionPeriodo(String fecha) throws SQLException;
    public abstract void FormularDocumentoTransaction(BeanDocumento beanDocumento, BeanCuerpoDocumento beanCuerpo, BeanHistorialDocumento beanHistorial, Collection distribuciones, Collection referencias, Collection piezasadjuntas) throws SQLException;
    /*COMBOS CUERPO OFICIO*/
    public abstract Collection obtenerArchivoIndicativo() throws Exception;
    public abstract Collection obtenerClasificacion() throws SQLException;
    public abstract Collection obtenerPrioridades() throws SQLException;
    /*DISTRIBUCION*/
    public abstract Collection obtenerOrganizacionInternas(String interna) throws SQLException;
    public abstract Collection obtenerOrganizacionExterna() throws SQLException;
    public abstract Collection obtenerOrganizacionEjercito(String interna, String dato) throws SQLException;
    public abstract BeanDistribucion obtenerDistribucion(String tipo, String interna) throws Exception;
    public abstract boolean existeElemento(Collection c, BeanDistribucion bean) throws Exception;
    /*ANEXOS*/
    public String generarCodigoAnexo(String periodo, String interno) throws SQLException;
    
    /*TEMPORAL ANEXOS*/
    public abstract String insertarAnexoTemporal(BeanTemporal objBeanT) throws SQLException;
    public abstract void insertarReferenciaTemporal(BeanTemporal objBeanT) throws SQLException;
    public abstract void actualizarOrdenReferenciaTemporal(BeanTemporal objBeanT) throws SQLException;
    public abstract void eliminarAnexoTemporal(BeanTemporal objBeanT) throws SQLException;
    public abstract void eliminarReferenciaTemporal(BeanTemporal objBeanT) throws SQLException;
    public abstract void limpiaTemporales(String usuario, String interna) throws SQLException;
    public abstract Collection listarAnexoTemporal(String usuario, String interna) throws SQLException;
    public abstract Collection listarReferenciaTemporal(String usuario, String interna) throws SQLException;
    public abstract Collection obtenerPeriodo() throws SQLException;
    public abstract Collection obtenerOrganizacionEjercito_MP() throws SQLException;
    public abstract Collection obtenerClaseDocumento() throws SQLException;
    public abstract Collection obtenerReferenciaOrden() throws SQLException;
    public abstract String insertarReferencia(BeanRegistroDocumento objBeanRD) throws SQLException;
    /*REFERENCIA*/
    public abstract Collection obtenerBusqReferencia(String cbo_Tipo_Organizacion,String org,String txtFecDesde,
             String txtFecHasta,String cbx_Clase_Doc,String txt_nro_doc,String txt_Asunto_Ref,String cbo_Periodo,String jefeUnidad)
            throws SQLException;
    /*TEMPORAL REFERENCIA*/
}
