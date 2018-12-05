package comun;

import java.io.FileInputStream;
import java.sql.SQLException;
import java.util.Collection;
import sagde.bean.BeanDocumento1;
import sagde.bean.BeanRegistroDocumento;

public interface DocumentoDAO {
    
    //--------------------------------------------MODULO REGISTRO DE DOCUMENTO --------------------------------------------------------//
    public abstract Collection obtenerFullDocumento(String usuario,String cod_jefe_unidad,String Tipo) throws Exception;
    
    
    
    
    public abstract Collection traeComboPeriodo() throws SQLException;
    public abstract Collection traeComboEntidadExterna(String codOrganizacion) throws SQLException;
    public abstract Collection obtenerOrganizacionEjercito3() throws Exception;
    public abstract Collection obtenerDependencia(String codigoOrganizacionUsuario) throws SQLException;
    public abstract Collection traeComboClase() throws SQLException;
    public abstract Collection traeComboArchivo() throws SQLException;
    public abstract Collection traeComboClasificacion() throws SQLException;
    public abstract Collection traeComboPrioridad() throws SQLException;   
    //CRUD MESA DE PARTE
    public abstract String insertarDocumentoImg(BeanDocumento1 entidad) throws Exception;
    public abstract void uu_imagen_insertar(String cdocumento_periodo, String codigoInterno, String cod_org_usuario, FileInputStream streamEntrada) throws  Exception;
    public abstract void uu_imagen_anexos(String cdocumento_periodo, String codigoInterno, String filename_anexo1, String filename_anexo2, String filename_anexo3, String filename_anexo4, String filename_anexo5) throws  Exception;
    
    public abstract void eliminarDocumento(String sCodigo, String sPeriodo) throws Exception;
    public abstract void actualizarDocumento(BeanDocumento1 entidad) throws Exception;
    
    //CRUD MESA DE PARTE ACTUAL
    
     public abstract String insertarDocRegistrado_MP(BeanRegistroDocumento entidad) throws Exception;
     public abstract String insertarDocRegistrado_REF(BeanRegistroDocumento entidad) throws Exception;      
     public abstract void eliminarRegistro_MP(String perido, String cod_int,String cod_jefe_unidad) throws Exception;
     
     //--------------------------------------------MESA DE PARTE DE ENVIO --------------------------------------------------------//
     
     
    
}