package sagde.bean;

import sagde.comun.Bean;

public class BeanRevisarDocumento extends Bean{

    /**
     * @return the TokenOFicio
     */
    public String getTokenOFicio() {
        return TokenOFicio;
    }

    /**
     * @param TokenOFicio the TokenOFicio to set
     */
    public void setTokenOFicio(String TokenOFicio) {
        this.TokenOFicio = TokenOFicio;
    }

    /**
     * @return the NroUnicoOF
     */
    public String getNroUnicoOF() {
        return NroUnicoOF;
    }

    /**
     * @param NroUnicoOF the NroUnicoOF to set
     */
    public void setNroUnicoOF(String NroUnicoOF) {
        this.NroUnicoOF = NroUnicoOF;
    }

    /**
     * @return the NroPendientes
     */
    public String getNroPendientes() {
        return NroPendientes;
    }

    /**
     * @param NroPendientes the NroPendientes to set
     */
    public void setNroPendientes(String NroPendientes) {
        this.NroPendientes = NroPendientes;
    }

    /**
     * @return the VHDOCUMENTO_COD_USU_REC
     */
    public String getVHDOCUMENTO_COD_USU_REC() {
        return VHDOCUMENTO_COD_USU_REC;
    }

    /**
     * @param VHDOCUMENTO_COD_USU_REC the VHDOCUMENTO_COD_USU_REC to set
     */
    public void setVHDOCUMENTO_COD_USU_REC(String VHDOCUMENTO_COD_USU_REC) {
        this.VHDOCUMENTO_COD_USU_REC = VHDOCUMENTO_COD_USU_REC;
    }

    /**
     * @return the TipoAccion
     */
    public String getTipoAccion() {
        return TipoAccion;
    }

    /**
     * @param TipoAccion the TipoAccion to set
     */
    public void setTipoAccion(String TipoAccion) {
        this.TipoAccion = TipoAccion;
    }

    /**
     * @return the VDOCUMENTO_USUARIO_FIRMA
     */
    public String getVDOCUMENTO_USUARIO_FIRMA() {
        return VDOCUMENTO_USUARIO_FIRMA;
    }

    /**
     * @param VDOCUMENTO_USUARIO_FIRMA the VDOCUMENTO_USUARIO_FIRMA to set
     */
    public void setVDOCUMENTO_USUARIO_FIRMA(String VDOCUMENTO_USUARIO_FIRMA) {
        this.VDOCUMENTO_USUARIO_FIRMA = VDOCUMENTO_USUARIO_FIRMA;
    }

    /**
     * @return the CDOCUMENTO_ESTADO
     */
    public String getCDOCUMENTO_ESTADO() {
        return CDOCUMENTO_ESTADO;
    }

    /**
     * @param CDOCUMENTO_ESTADO the CDOCUMENTO_ESTADO to set
     */
    public void setCDOCUMENTO_ESTADO(String CDOCUMENTO_ESTADO) {
        this.CDOCUMENTO_ESTADO = CDOCUMENTO_ESTADO;
    }

    
//Bean LISTAR DOCUMENTOS POR REVISAR
	
	private String CDOCUMENTO_PERIODO;
	private String CDOCUMENTO_COD_DOC_INT;
	private String CDOCUMENTO_CLASE;
	private String VCLASE_NOM_CORTO;
	private String VDOCUMENTO_CLAVE_INDIC;
	private String VDOCUMENTO_ASUNTO;
	private String CHDOCUMENTO_SECUENCIA;
	private String VHDOCUMENTO_OBSERVACION;
	private String VDOCUMENTO_USUARIO_REVISA;
	private String VHDOCUMENTO_COD_USU_ENV;
        private String DHDOCUMENTO_FECH_ESTADO;
        private String DESTINATARIO;
        
             
 //Bean RETORNA EL DOCUMENTO POR REVISAR
         //CDOCUMENTO_CLASE,VDOCUMENTO_CLAVE_INDIC,VDOCUMENTO_ASUNTO,VHDOCUMENTO_OBSERVACION
        private String CDOCUMENTO_TIPO_ORG_ORIG;
        private String CDOCUMENTO_COD_ORG_ORIG;       
        private String CDOCUMENTO_ARCHIVO_INDIC;
        private String CDOCUMENTO_CLASIFICACION;
        private String CDOCUMENTO_PRIORIDAD; 
        private String DDOCUMENTO_FECHA; 
        private String CDOCUMENTO_ESTADO;         
        private String VDOCUMENTO_USUARIO_ENV;
        private String CDOCUMENTO_COD_ORG_DEP;
        private String CDOCUMENTO_COD_ORG_NIV;
        private String VDOCUMENTO_GUARNICION;
        private String VDISTRIBUCION_GRADO;
        private String VDISTRIBUCION_APE_NOM;
        private String VDISTRIBUCION_CARGO;
        private String LCDOCUMENTO_CUERPO_DOC;        
        private String CFIRMA_NRO_SERIE; 
        private String VFIRMA_APE_NOM;
        private String VFIRMA_GRADO;
        private String VFIRMA_CARGO;
        private String VFIRMA_COD_USUARIO;
        private String CUSUARIO_COD_ORG;
        private String CDISTRIBUCION_COD_ORG;
        private String NOMORGNIV;
        private String NOMORGDEP;
        private String NOMORGNIVCOR;
        private String NOMORGDEPCOR;
          
           
            
        private String VHDOCUMENTO_COD_USU_REC; 
        private String VDOCUMENTO_USUARIO_FIRMA;      
        private String TipoAccion;  
        private String NroPendientes; 
        
        private String NroUnicoOF; 
        private String TokenOFicio; 
        
        private String JEFE_UNIDAD;

        

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
     * @return the CHDOCUMENTO_SECUENCIA
     */
    public String getCHDOCUMENTO_SECUENCIA() {
        return CHDOCUMENTO_SECUENCIA;
    }

    /**
     * @param CHDOCUMENTO_SECUENCIA the CHDOCUMENTO_SECUENCIA to set
     */
    public void setCHDOCUMENTO_SECUENCIA(String CHDOCUMENTO_SECUENCIA) {
        this.CHDOCUMENTO_SECUENCIA = CHDOCUMENTO_SECUENCIA;
    }

    /**
     * @return the VHDOCUMENTO_OBSERVACION
     */
    public String getVHDOCUMENTO_OBSERVACION() {
        return VHDOCUMENTO_OBSERVACION;
    }

    /**
     * @param VHDOCUMENTO_OBSERVACION the VHDOCUMENTO_OBSERVACION to set
     */
    public void setVHDOCUMENTO_OBSERVACION(String VHDOCUMENTO_OBSERVACION) {
        this.VHDOCUMENTO_OBSERVACION = VHDOCUMENTO_OBSERVACION;
    }

    /**
     * @return the VDOCUMENTO_USUARIO_REVISA
     */
    public String getVDOCUMENTO_USUARIO_REVISA() {
        return VDOCUMENTO_USUARIO_REVISA;
    }

    /**
     * @param VDOCUMENTO_USUARIO_REVISA the VDOCUMENTO_USUARIO_REVISA to set
     */
    public void setVDOCUMENTO_USUARIO_REVISA(String VDOCUMENTO_USUARIO_REVISA) {
        this.VDOCUMENTO_USUARIO_REVISA = VDOCUMENTO_USUARIO_REVISA;
    }

    /**
     * @return the VHDOCUMENTO_COD_USU_ENV
     */
    public String getVHDOCUMENTO_COD_USU_ENV() {
        return VHDOCUMENTO_COD_USU_ENV;
    }

    /**
     * @param VHDOCUMENTO_COD_USU_ENV the VHDOCUMENTO_COD_USU_ENV to set
     */
    public void setVHDOCUMENTO_COD_USU_ENV(String VHDOCUMENTO_COD_USU_ENV) {
        this.VHDOCUMENTO_COD_USU_ENV = VHDOCUMENTO_COD_USU_ENV;
    }

    /**
     * @return the DHDOCUMENTO_FECH_ESTADO
     */
    public String getDHDOCUMENTO_FECH_ESTADO() {
        return DHDOCUMENTO_FECH_ESTADO;
    }

    /**
     * @param DHDOCUMENTO_FECH_ESTADO the DHDOCUMENTO_FECH_ESTADO to set
     */
    public void setDHDOCUMENTO_FECH_ESTADO(String DHDOCUMENTO_FECH_ESTADO) {
        this.DHDOCUMENTO_FECH_ESTADO = DHDOCUMENTO_FECH_ESTADO;
    }

    /**
     * @return the DESTINATARIO
     */
    public String getDESTINATARIO() {
        return DESTINATARIO;
    }

    /**
     * @param DESTINATARIO the DESTINATARIO to set
     */
    public void setDESTINATARIO(String DESTINATARIO) {
        this.DESTINATARIO = DESTINATARIO;
    }

    /**
     * @return the CDOCUMENTO_TIPO_ORG_ORIG
     */
    public String getCDOCUMENTO_TIPO_ORG_ORIG() {
        return CDOCUMENTO_TIPO_ORG_ORIG;
    }

    /**
     * @param CDOCUMENTO_TIPO_ORG_ORIG the CDOCUMENTO_TIPO_ORG_ORIG to set
     */
    public void setCDOCUMENTO_TIPO_ORG_ORIG(String CDOCUMENTO_TIPO_ORG_ORIG) {
        this.CDOCUMENTO_TIPO_ORG_ORIG = CDOCUMENTO_TIPO_ORG_ORIG;
    }

    /**
     * @return the CDOCUMENTO_COD_ORG_ORIG
     */
    public String getCDOCUMENTO_COD_ORG_ORIG() {
        return CDOCUMENTO_COD_ORG_ORIG;
    }

    /**
     * @param CDOCUMENTO_COD_ORG_ORIG the CDOCUMENTO_COD_ORG_ORIG to set
     */
    public void setCDOCUMENTO_COD_ORG_ORIG(String CDOCUMENTO_COD_ORG_ORIG) {
        this.CDOCUMENTO_COD_ORG_ORIG = CDOCUMENTO_COD_ORG_ORIG;
    }

    /**
     * @return the CDOCUMENTO_ARCHIVO_INDIC
     */
    public String getCDOCUMENTO_ARCHIVO_INDIC() {
        return CDOCUMENTO_ARCHIVO_INDIC;
    }

    /**
     * @param CDOCUMENTO_ARCHIVO_INDIC the CDOCUMENTO_ARCHIVO_INDIC to set
     */
    public void setCDOCUMENTO_ARCHIVO_INDIC(String CDOCUMENTO_ARCHIVO_INDIC) {
        this.CDOCUMENTO_ARCHIVO_INDIC = CDOCUMENTO_ARCHIVO_INDIC;
    }

    /**
     * @return the CDOCUMENTO_CLASIFICACION
     */
    public String getCDOCUMENTO_CLASIFICACION() {
        return CDOCUMENTO_CLASIFICACION;
    }

    /**
     * @param CDOCUMENTO_CLASIFICACION the CDOCUMENTO_CLASIFICACION to set
     */
    public void setCDOCUMENTO_CLASIFICACION(String CDOCUMENTO_CLASIFICACION) {
        this.CDOCUMENTO_CLASIFICACION = CDOCUMENTO_CLASIFICACION;
    }

    /**
     * @return the CDOCUMENTO_PRIORIDAD
     */
    public String getCDOCUMENTO_PRIORIDAD() {
        return CDOCUMENTO_PRIORIDAD;
    }

    /**
     * @param CDOCUMENTO_PRIORIDAD the CDOCUMENTO_PRIORIDAD to set
     */
    public void setCDOCUMENTO_PRIORIDAD(String CDOCUMENTO_PRIORIDAD) {
        this.CDOCUMENTO_PRIORIDAD = CDOCUMENTO_PRIORIDAD;
    }

    /**
     * @return the DDOCUMENTO_FECHA
     */
    public String getDDOCUMENTO_FECHA() {
        return DDOCUMENTO_FECHA;
    }

    /**
     * @param DDOCUMENTO_FECHA the DDOCUMENTO_FECHA to set
     */
    public void setDDOCUMENTO_FECHA(String DDOCUMENTO_FECHA) {
        this.DDOCUMENTO_FECHA = DDOCUMENTO_FECHA;
    }

    /**
     * @return the VDOCUMENTO_USUARIO_ENV
     */
    public String getVDOCUMENTO_USUARIO_ENV() {
        return VDOCUMENTO_USUARIO_ENV;
    }

    /**
     * @param VDOCUMENTO_USUARIO_ENV the VDOCUMENTO_USUARIO_ENV to set
     */
    public void setVDOCUMENTO_USUARIO_ENV(String VDOCUMENTO_USUARIO_ENV) {
        this.VDOCUMENTO_USUARIO_ENV = VDOCUMENTO_USUARIO_ENV;
    }

    /**
     * @return the CDOCUMENTO_COD_ORG_DEP
     */
    public String getCDOCUMENTO_COD_ORG_DEP() {
        return CDOCUMENTO_COD_ORG_DEP;
    }

    /**
     * @param CDOCUMENTO_COD_ORG_DEP the CDOCUMENTO_COD_ORG_DEP to set
     */
    public void setCDOCUMENTO_COD_ORG_DEP(String CDOCUMENTO_COD_ORG_DEP) {
        this.CDOCUMENTO_COD_ORG_DEP = CDOCUMENTO_COD_ORG_DEP;
    }

    /**
     * @return the CDOCUMENTO_COD_ORG_NIV
     */
    public String getCDOCUMENTO_COD_ORG_NIV() {
        return CDOCUMENTO_COD_ORG_NIV;
    }

    /**
     * @param CDOCUMENTO_COD_ORG_NIV the CDOCUMENTO_COD_ORG_NIV to set
     */
    public void setCDOCUMENTO_COD_ORG_NIV(String CDOCUMENTO_COD_ORG_NIV) {
        this.CDOCUMENTO_COD_ORG_NIV = CDOCUMENTO_COD_ORG_NIV;
    }

    /**
     * @return the VDOCUMENTO_GUARNICION
     */
    public String getVDOCUMENTO_GUARNICION() {
        return VDOCUMENTO_GUARNICION;
    }

    /**
     * @param VDOCUMENTO_GUARNICION the VDOCUMENTO_GUARNICION to set
     */
    public void setVDOCUMENTO_GUARNICION(String VDOCUMENTO_GUARNICION) {
        this.VDOCUMENTO_GUARNICION = VDOCUMENTO_GUARNICION;
    }

    /**
     * @return the VDISTRIBUCION_GRADO
     */
    public String getVDISTRIBUCION_GRADO() {
        return VDISTRIBUCION_GRADO;
    }

    /**
     * @param VDISTRIBUCION_GRADO the VDISTRIBUCION_GRADO to set
     */
    public void setVDISTRIBUCION_GRADO(String VDISTRIBUCION_GRADO) {
        this.VDISTRIBUCION_GRADO = VDISTRIBUCION_GRADO;
    }

    /**
     * @return the VDISTRIBUCION_APE_NOM
     */
    public String getVDISTRIBUCION_APE_NOM() {
        return VDISTRIBUCION_APE_NOM;
    }

    /**
     * @param VDISTRIBUCION_APE_NOM the VDISTRIBUCION_APE_NOM to set
     */
    public void setVDISTRIBUCION_APE_NOM(String VDISTRIBUCION_APE_NOM) {
        this.VDISTRIBUCION_APE_NOM = VDISTRIBUCION_APE_NOM;
    }

    /**
     * @return the VDISTRIBUCION_CARGO
     */
    public String getVDISTRIBUCION_CARGO() {
        return VDISTRIBUCION_CARGO;
    }

    /**
     * @param VDISTRIBUCION_CARGO the VDISTRIBUCION_CARGO to set
     */
    public void setVDISTRIBUCION_CARGO(String VDISTRIBUCION_CARGO) {
        this.VDISTRIBUCION_CARGO = VDISTRIBUCION_CARGO;
    }

    /**
     * @return the LCDOCUMENTO_CUERPO_DOC
     */
    public String getLCDOCUMENTO_CUERPO_DOC() {
        return LCDOCUMENTO_CUERPO_DOC;
    }

    /**
     * @param LCDOCUMENTO_CUERPO_DOC the LCDOCUMENTO_CUERPO_DOC to set
     */
    public void setLCDOCUMENTO_CUERPO_DOC(String LCDOCUMENTO_CUERPO_DOC) {
        this.LCDOCUMENTO_CUERPO_DOC = LCDOCUMENTO_CUERPO_DOC;
    }

    /**
     * @return the CFIRMA_NRO_SERIE
     */
    public String getCFIRMA_NRO_SERIE() {
        return CFIRMA_NRO_SERIE;
    }

    /**
     * @param CFIRMA_NRO_SERIE the CFIRMA_NRO_SERIE to set
     */
    public void setCFIRMA_NRO_SERIE(String CFIRMA_NRO_SERIE) {
        this.CFIRMA_NRO_SERIE = CFIRMA_NRO_SERIE;
    }

    /**
     * @return the VFIRMA_APE_NOM
     */
    public String getVFIRMA_APE_NOM() {
        return VFIRMA_APE_NOM;
    }

    /**
     * @param VFIRMA_APE_NOM the VFIRMA_APE_NOM to set
     */
    public void setVFIRMA_APE_NOM(String VFIRMA_APE_NOM) {
        this.VFIRMA_APE_NOM = VFIRMA_APE_NOM;
    }

    /**
     * @return the VFIRMA_GRADO
     */
    public String getVFIRMA_GRADO() {
        return VFIRMA_GRADO;
    }

    /**
     * @param VFIRMA_GRADO the VFIRMA_GRADO to set
     */
    public void setVFIRMA_GRADO(String VFIRMA_GRADO) {
        this.VFIRMA_GRADO = VFIRMA_GRADO;
    }

    /**
     * @return the VFIRMA_CARGO
     */
    public String getVFIRMA_CARGO() {
        return VFIRMA_CARGO;
    }

    /**
     * @param VFIRMA_CARGO the VFIRMA_CARGO to set
     */
    public void setVFIRMA_CARGO(String VFIRMA_CARGO) {
        this.VFIRMA_CARGO = VFIRMA_CARGO;
    }

    /**
     * @return the VFIRMA_COD_USUARIO
     */
    public String getVFIRMA_COD_USUARIO() {
        return VFIRMA_COD_USUARIO;
    }

    /**
     * @param VFIRMA_COD_USUARIO the VFIRMA_COD_USUARIO to set
     */
    public void setVFIRMA_COD_USUARIO(String VFIRMA_COD_USUARIO) {
        this.VFIRMA_COD_USUARIO = VFIRMA_COD_USUARIO;
    }

    /**
     * @return the CUSUARIO_COD_ORG
     */
    public String getCUSUARIO_COD_ORG() {
        return CUSUARIO_COD_ORG;
    }

    /**
     * @param CUSUARIO_COD_ORG the CUSUARIO_COD_ORG to set
     */
    public void setCUSUARIO_COD_ORG(String CUSUARIO_COD_ORG) {
        this.CUSUARIO_COD_ORG = CUSUARIO_COD_ORG;
    }

    /**
     * @return the CDISTRIBUCION_COD_ORG
     */
    public String getCDISTRIBUCION_COD_ORG() {
        return CDISTRIBUCION_COD_ORG;
    }

    /**
     * @param CDISTRIBUCION_COD_ORG the CDISTRIBUCION_COD_ORG to set
     */
    public void setCDISTRIBUCION_COD_ORG(String CDISTRIBUCION_COD_ORG) {
        this.CDISTRIBUCION_COD_ORG = CDISTRIBUCION_COD_ORG;
    }

    /**
     * @return the NOMORGNIV
     */
    public String getNOMORGNIV() {
        return NOMORGNIV;
    }

    /**
     * @param NOMORGNIV the NOMORGNIV to set
     */
    public void setNOMORGNIV(String NOMORGNIV) {
        this.NOMORGNIV = NOMORGNIV;
    }

    /**
     * @return the NOMORGDEP
     */
    public String getNOMORGDEP() {
        return NOMORGDEP;
    }

    /**
     * @param NOMORGDEP the NOMORGDEP to set
     */
    public void setNOMORGDEP(String NOMORGDEP) {
        this.NOMORGDEP = NOMORGDEP;
    }

    /**
     * @return the NOMORGNIVCOR
     */
    public String getNOMORGNIVCOR() {
        return NOMORGNIVCOR;
    }

    /**
     * @param NOMORGNIVCOR the NOMORGNIVCOR to set
     */
    public void setNOMORGNIVCOR(String NOMORGNIVCOR) {
        this.NOMORGNIVCOR = NOMORGNIVCOR;
    }

    /**
     * @return the NOMORGDEPCOR
     */
    public String getNOMORGDEPCOR() {
        return NOMORGDEPCOR;
    }

    /**
     * @param NOMORGDEPCOR the NOMORGDEPCOR to set
     */
    public void setNOMORGDEPCOR(String NOMORGDEPCOR) {
        this.NOMORGDEPCOR = NOMORGDEPCOR;
    }

    /**
     * @return the JEFE_UNIDAD
     */
    public String getJEFE_UNIDAD() {
        return JEFE_UNIDAD;
    }

    /**
     * @param JEFE_UNIDAD the JEFE_UNIDAD to set
     */
    public void setJEFE_UNIDAD(String JEFE_UNIDAD) {
        this.JEFE_UNIDAD = JEFE_UNIDAD;
    }
        
        
        
        
	
}