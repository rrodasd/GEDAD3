package comun;

import java.sql.SQLException;
import java.util.Collection;
import sagde.bean.BeanAnexo;
import sagde.bean.BeanDistribucion;
import sagde.bean.BeanReferencia;

import sagde.bean.BeanRevisarDocumento;

public interface RevisaDocumentoDAO {

    
/*
   1. **********************************REVISAR DOCUMENTO ******************************     */    
    public abstract Collection ObtenerListaDocumentosXRevisar(String codigoUsuario,
            String codigoOrganizacion, String tipo) throws SQLException;

     public abstract BeanRevisarDocumento obtenerDocXRevisar(String periodo,
            String codigoInternoDoc, String usuario) throws SQLException;
     public abstract BeanRevisarDocumento obtenerDocXBorrador(String periodo,
            String codigoInternoDoc, String usuario) throws SQLException;
    
    public abstract void EnviarRevisarDocumento(BeanRevisarDocumento beanrevisar,
            Collection referencias, Collection distribuciones)
            throws SQLException;
    
    public abstract String FirmaDigitalDocumento(BeanRevisarDocumento beanrevisar,
            Collection referencias, Collection distribuciones)
            throws SQLException;
     
    public abstract BeanRevisarDocumento obtenerCantidadPendientes(String tipo,
            String codigoUsuario, String subtipo) throws SQLException;
/*
  2. **********************************DISTRIBUCION ****************************** 
    */ 
    public abstract Collection RD_ObtenerDistribucion(String periodo,
            String codigoDocumentoInterno) throws SQLException;
    
   public abstract BeanDistribucion AddDistribucion(String tiporganizacion, String organizacion) throws Exception;
   public abstract boolean ExisteDistribucion(Collection c, BeanDistribucion bean);
   
 /*
   3.**********************************ANEXOS ****************************** 
  */
   
    public abstract Collection obtenerFullAnexosXDocumento(String periodo, String cod_docinterno) throws Exception;
    public abstract String generaSecAnexo(String codperiodo, String coddocint) throws Exception;
    BeanAnexo obtenerAnexoSinBlob(BeanAnexo domain) throws SQLException;
    public abstract void eliminarAnexos(String sCodigo, String sPeriodo,String sSecuencia) throws Exception;
    
   /*
   4.**********************************REFERENCIA ****************************** 
  */ 
    
                    
                    
     public abstract Collection RD_ObtenerBusqReferencia(String cbo_Tipo_Organizacion,String org,String txtFecDesde,
             String txtFecHasta,String cbx_Clase_Doc,String txt_nro_doc,String txt_Asunto_Ref,String cbo_Periodo,String usuario,String cod_org_usu)
            throws SQLException;     
    public abstract Collection grabareferencia(String perido_ref,String codint_refe,String periodo_orig,String codint_orig)throws SQLException;
    public abstract Collection eliminaReferencia(String periodo_orig,String codint_orig,String perido_ref,String codint_refe)throws SQLException;
     
    public abstract Collection Listareferencia(String periodo_orig,String codint_orig)throws SQLException;
     
    BeanReferencia obtenerReferenciaSinBlob(BeanReferencia domain) throws SQLException;
    
    public abstract String obtenerNroUnicoDoc(String codperiodo, String clase) throws Exception;
}
