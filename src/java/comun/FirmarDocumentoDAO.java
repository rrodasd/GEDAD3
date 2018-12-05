package comun;

import java.sql.SQLException;
import java.util.Collection;
import sagde.bean.BeanAnexo;
import sagde.bean.BeanDistribucion;

import sagde.bean.BeanFirmarDocumento;

public interface FirmarDocumentoDAO {

    
/*
   1. **********************************FIRMAR DOCUMENTO ******************************     */    
    public abstract Collection ObtenerListaDocumentosXFirmar(String codigoUsuario,
            String codigoOrganizacion, String tipo) throws SQLException;

     public abstract BeanFirmarDocumento obtenerDocXFirmar(String periodo,
            String codigoInternoDoc, String usuario) throws SQLException;
    
    public abstract void EnviarRevisarDocumento(BeanFirmarDocumento beanrevisar,
            Collection referencias, Collection distribuciones)
            throws SQLException;
     
/*
  2. **********************************DISTRIBUCION ****************************** 
    */ 
    public abstract Collection FD_ObtenerDistribucion(String periodo,
            String codigoDocumentoInterno) throws SQLException;
    
   public abstract BeanDistribucion AddDistribucion(String tiporganizacion, String organizacion) throws Exception;
   public abstract boolean ExisteDistribucion(Collection c, BeanDistribucion bean);
   
 /*
   3.**********************************ANEXOS ****************************** 
  */
   
    public abstract Collection obtenerFullAnexosXDocumento(String periodo, String cod_docinterno) throws Exception;
    public abstract String generaSecAnexo(String codperiodo, String coddocint) throws Exception;
    BeanAnexo obtenerAnexoSinBlob(BeanAnexo domain) throws SQLException;
   
    
/*
    4.*****************************REPORTE***************************************
    */
    public abstract String obtenerNroUnicoDoc(String codperiodo, String clase) throws Exception;
}
