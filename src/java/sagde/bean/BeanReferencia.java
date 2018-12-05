package sagde.bean;

import comun.ResultSetUtil;
import comun.StringUtil;
import java.sql.ResultSet;
import sagde.comun.Bean;

public class BeanReferencia extends Bean{

    /**
     * @return the VDISTRIBUCION_TOKEN
     */
    public String getVDISTRIBUCION_TOKEN() {
        return VDISTRIBUCION_TOKEN;
    }

    /**
     * @param VDISTRIBUCION_TOKEN the VDISTRIBUCION_TOKEN to set
     */
    public void setVDISTRIBUCION_TOKEN(String VDISTRIBUCION_TOKEN) {
        this.VDISTRIBUCION_TOKEN = VDISTRIBUCION_TOKEN;
    }

    /**
     * @return the VANEXO_TOKEN
     */
    public String getVANEXO_TOKEN() {
        return VANEXO_TOKEN;
    }

    /**
     * @param VANEXO_TOKEN the VANEXO_TOKEN to set
     */
    public void setVANEXO_TOKEN(String VANEXO_TOKEN) {
        this.VANEXO_TOKEN = VANEXO_TOKEN;
    }

    /**
     * @return the ORDEN_REF
     */
    public String getORDEN_REF() {
        return ORDEN_REF;
    }

    /**
     * @param ORDEN_REF the ORDEN_REF to set
     */
    public void setORDEN_REF(String ORDEN_REF) {
        this.ORDEN_REF = ORDEN_REF;
    }

    /**
     * @return the VDOCUMENTO_CLAVE_INDIC
     */
    public String getVDOCUMENTO_CLAVE_INDIC() {
        return VDOCUMENTO_CLAVE_INDIC;
    }

    /**
     * @param VDOCUMENTO_CLAVE_INDIC the VDOCUMENTO_CLAVE_INDIC to set
     */
    public void setVDOCUMENTO_CLAVE_INDIC(String VDOCUMENTO_CLAVE_INDIC) {
        this.VDOCUMENTO_CLAVE_INDIC = VDOCUMENTO_CLAVE_INDIC;
    }
    
    
        
	
	private String CREFERENCIA_PERIODO_ORIG;
	private String CREFERENCIA_COD_DOC_ORIG;
	private String CREFERENCIA_PERIODO_REF;
	private String CREFERENCIA_COD_DOC_REF;
	private String CREFENCIA_COD_ESTADO;
        
       //Para ontener la busqueda 
        private String CDOCUMENTO_PERIODO;
	private String CDOCUMENTO_COD_DOC_INT;
	private String CDOCUMENTO_CLASE;
	private String VCLASE_NOM_CORTO;
	private String CDOCUMENTO_NRO_ORDEN;
        private String VDOCUMENTO_ASUNTO;
	private String FECHA_DOC_ORIGEN;
	private String FEC_ING_SISTEMA;
        private String VOINTERNA_NOM_CORTO;
        
         private String ORDEN_REF;
         private String VDOCUMENTO_CLAVE_INDIC;
         
         
        private String VANEXO_TOKEN;
        
        private String  VDISTRIBUCION_TOKEN;
        
       
    /**
     * @return the CREFERENCIA_PERIODO_ORIG
     */
    public String getCREFERENCIA_PERIODO_ORIG() {
        return CREFERENCIA_PERIODO_ORIG;
    }

    /**
     * @param CREFERENCIA_PERIODO_ORIG the CREFERENCIA_PERIODO_ORIG to set
     */
    public void setCREFERENCIA_PERIODO_ORIG(String CREFERENCIA_PERIODO_ORIG) {
        this.CREFERENCIA_PERIODO_ORIG = CREFERENCIA_PERIODO_ORIG;
    }

    /**
     * @return the CREFERENCIA_COD_DOC_ORIG
     */
    public String getCREFERENCIA_COD_DOC_ORIG() {
        return CREFERENCIA_COD_DOC_ORIG;
    }

    /**
     * @param CREFERENCIA_COD_DOC_ORIG the CREFERENCIA_COD_DOC_ORIG to set
     */
    public void setCREFERENCIA_COD_DOC_ORIG(String CREFERENCIA_COD_DOC_ORIG) {
        this.CREFERENCIA_COD_DOC_ORIG = CREFERENCIA_COD_DOC_ORIG;
    }

    /**
     * @return the CREFERENCIA_PERIODO_REF
     */
    public String getCREFERENCIA_PERIODO_REF() {
        return CREFERENCIA_PERIODO_REF;
    }

    /**
     * @param CREFERENCIA_PERIODO_REF the CREFERENCIA_PERIODO_REF to set
     */
    public void setCREFERENCIA_PERIODO_REF(String CREFERENCIA_PERIODO_REF) {
        this.CREFERENCIA_PERIODO_REF = CREFERENCIA_PERIODO_REF;
    }

    /**
     * @return the CREFERENCIA_COD_DOC_REF
     */
    public String getCREFERENCIA_COD_DOC_REF() {
        return CREFERENCIA_COD_DOC_REF;
    }

    /**
     * @param CREFERENCIA_COD_DOC_REF the CREFERENCIA_COD_DOC_REF to set
     */
    public void setCREFERENCIA_COD_DOC_REF(String CREFERENCIA_COD_DOC_REF) {
        this.CREFERENCIA_COD_DOC_REF = CREFERENCIA_COD_DOC_REF;
    }

    /**
     * @return the CREFENCIA_COD_ESTADO
     */
    public String getCREFENCIA_COD_ESTADO() {
        return CREFENCIA_COD_ESTADO;
    }

    /**
     * @param CREFENCIA_COD_ESTADO the CREFENCIA_COD_ESTADO to set
     */
    public void setCREFENCIA_COD_ESTADO(String CREFENCIA_COD_ESTADO) {
        this.CREFENCIA_COD_ESTADO = CREFENCIA_COD_ESTADO;
    }

    /**
     * @return the CDOCUMENTO_PERIODO
     */
    public String getCDOCUMENTO_PERIODO() {
        return CDOCUMENTO_PERIODO;
    }

    /**
     * @param CDOCUMENTO_PERIODO the CDOCUMENTO_PERIODO to set
     */
    public void setCDOCUMENTO_PERIODO(String CDOCUMENTO_PERIODO) {
        this.CDOCUMENTO_PERIODO = CDOCUMENTO_PERIODO;
    }

    /**
     * @return the CDOCUMENTO_COD_DOC_INT
     */
    public String getCDOCUMENTO_COD_DOC_INT() {
        return CDOCUMENTO_COD_DOC_INT;
    }

    /**
     * @param CDOCUMENTO_COD_DOC_INT the CDOCUMENTO_COD_DOC_INT to set
     */
    public void setCDOCUMENTO_COD_DOC_INT(String CDOCUMENTO_COD_DOC_INT) {
        this.CDOCUMENTO_COD_DOC_INT = CDOCUMENTO_COD_DOC_INT;
    }

    /**
     * @return the CDOCUMENTO_CLASE
     */
    public String getCDOCUMENTO_CLASE() {
        return CDOCUMENTO_CLASE;
    }

    /**
     * @param CDOCUMENTO_CLASE the CDOCUMENTO_CLASE to set
     */
    public void setCDOCUMENTO_CLASE(String CDOCUMENTO_CLASE) {
        this.CDOCUMENTO_CLASE = CDOCUMENTO_CLASE;
    }

    /**
     * @return the VCLASE_NOM_CORTO
     */
    public String getVCLASE_NOM_CORTO() {
        return VCLASE_NOM_CORTO;
    }

    /**
     * @param VCLASE_NOM_CORTO the VCLASE_NOM_CORTO to set
     */
    public void setVCLASE_NOM_CORTO(String VCLASE_NOM_CORTO) {
        this.VCLASE_NOM_CORTO = VCLASE_NOM_CORTO;
    }

    /**
     * @return the CDOCUMENTO_NRO_ORDEN
     */
    public String getCDOCUMENTO_NRO_ORDEN() {
        return CDOCUMENTO_NRO_ORDEN;
    }

    /**
     * @param CDOCUMENTO_NRO_ORDEN the CDOCUMENTO_NRO_ORDEN to set
     */
    public void setCDOCUMENTO_NRO_ORDEN(String CDOCUMENTO_NRO_ORDEN) {
        this.CDOCUMENTO_NRO_ORDEN = CDOCUMENTO_NRO_ORDEN;
    }

    /**
     * @return the VDOCUMENTO_ASUNTO
     */
    public String getVDOCUMENTO_ASUNTO() {
        return VDOCUMENTO_ASUNTO;
    }

    /**
     * @param VDOCUMENTO_ASUNTO the VDOCUMENTO_ASUNTO to set
     */
    public void setVDOCUMENTO_ASUNTO(String VDOCUMENTO_ASUNTO) {
        this.VDOCUMENTO_ASUNTO = VDOCUMENTO_ASUNTO;
    }

    /**
     * @return the FECHA_DOC_ORIGEN
     */
    public String getFECHA_DOC_ORIGEN() {
        return FECHA_DOC_ORIGEN;
    }

    /**
     * @param FECHA_DOC_ORIGEN the FECHA_DOC_ORIGEN to set
     */
    public void setFECHA_DOC_ORIGEN(String FECHA_DOC_ORIGEN) {
        this.FECHA_DOC_ORIGEN = FECHA_DOC_ORIGEN;
    }

    /**
     * @return the FEC_ING_SISTEMA
     */
    public String getFEC_ING_SISTEMA() {
        return FEC_ING_SISTEMA;
    }

    /**
     * @param FEC_ING_SISTEMA the FEC_ING_SISTEMA to set
     */
    public void setFEC_ING_SISTEMA(String FEC_ING_SISTEMA) {
        this.FEC_ING_SISTEMA = FEC_ING_SISTEMA;
    }

    /**
     * @return the VOINTERNA_NOM_CORTO
     */
    public String getVOINTERNA_NOM_CORTO() {
        return VOINTERNA_NOM_CORTO;
    }

    /**
     * @param VOINTERNA_NOM_CORTO the VOINTERNA_NOM_CORTO to set
     */
    public void setVOINTERNA_NOM_CORTO(String VOINTERNA_NOM_CORTO) {
        this.VOINTERNA_NOM_CORTO = VOINTERNA_NOM_CORTO;
    }
	
	
    
        /**
         * Permite convertir un resultSet a un objeto de tipo BeanAnexo
         * @param rs
         * @return 
         */
        public static BeanReferencia parseToBeanReferencia( ResultSet rs ){
            if( StringUtil.isEmpty(rs) ){
                return null;
            }
            
            ResultSetUtil rsu = new ResultSetUtil( rs );
            BeanReferencia ba = new BeanReferencia();
            
            ba.setVDISTRIBUCION_TOKEN( rsu.getStr("VDISTRIBUCION_TOKEN", null) );
           
            
            return ba;
        }

    
    
}
