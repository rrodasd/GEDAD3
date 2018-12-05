package comun;

import java.sql.Blob;
import java.sql.SQLException;
import sagde.bean.BeanAnexo;
import sagde.bean.BeanDistribucion;

public interface PDFDAO {

    public abstract Blob ObtenerPDF(String periodo, String tiporganizacion, String organizacion) throws SQLException;

    public abstract Blob ObtenerPDFReferencia(String periodo, String tiporganizacion) throws SQLException;

    public abstract Blob ObtenerPDF() throws SQLException;

    public abstract Blob ObtenerPDFAnexo(String periodo, String codigoInterno, String secuencia) throws SQLException;
    
    public byte [] obtenerAdjunto(BeanDistribucion objBean) throws Exception;
            
    public BeanDistribucion obtenerGestion (BeanDistribucion objBean) throws Exception;  
    public byte [] obtenerAnexos(BeanAnexo objBean) throws Exception;
    
    
    
    /**
     * Rutinas para el tratamiento de Alfresco, asociado a PDF
     */
    
    /**
     * Obtiene el objeto BeanAnexo sin asociar tipo de datos Blob de la BD
     * @param domain
     * @return
     * @throws SQLException 
     */
    BeanAnexo obtenerAnexoSinBlob(BeanAnexo domain) throws SQLException;
    
    
    

}