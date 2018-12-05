package sagde.bean;

import java.util.Collection;
import sagde.comun.Bean;

public class BeanDecreto extends Bean {
    
    //SAGDE_DECRETO
    private String CDECRETO_COD_ORG;
    private String DDECRETO_FECH_DEC;
    private String DDECRETO_FECH_EJEC;
    private String CDECRETO_NRO_DECRETO;
    private String CDECRETO_PRIORIDAD;
    private String VDECRETO_OBSERVACION;
    private String CDECRETO_ESTADO;  
    private String VDECRETO_COD_USUARIO;
    private String CDECRETO_SITUACION;
    private String CDECRETO_COD_ORG_ENC;
    
    //SAGDE_DOCUMENTO
    private String CDOCUMENTO_PERIODO;
    private String CDOCUMENTO_COD_DOC_INT;
    private String CDOCUMENTO_CLASE;
    private String CDOCUMENTO_NRO_ORDEN;
    private String VDOCUMENTO_CLAVE_INDIC;
    private String DDOCUMENTO_FECHA;
    private String VDOCUMENTO_ASUNTO;
    private String CDOCUMENTO_COD_ORG_DEP;
    private String CDOCUMENTO_TIPO_ORG_ORIG;
    
    //SAGDE_CLASE
    private String VCLASE_NOM_CORTO;
    
    //SAGDE_ORGANIZACIONINTERNA
    private String VOINTERNA_NOM_CORTO;
        
    //SAGDE_DISTRIBUCION
    private String CDISTRIBUCION_COD_ORG;    
    private String CDISTRIBUCION_TIPO_DISTRIB;
    private String VDISTRIBUCION_TOKEN;
    private String VDISTRIBUCION_NOM_FILE;
    
    //SAGDE_PRIORIDAD
    private String VPRIORIDAD_NOMBRE;
    
    //ADICIONAL
    private String FECH_DEC;
    private String TIPO_DECRETO;
    private Collection LISTA_ACCION;
    private Collection LISTA_INTERNA;

    //GETTERS AND SETTERS
    public Collection getLISTA_ACCION() {
        return LISTA_ACCION;
    }

    public void setLISTA_ACCION(Collection LISTA_ACCION) {
        this.LISTA_ACCION = LISTA_ACCION;
    }
    
    public String getTIPO_DECRETO() {
        return TIPO_DECRETO;
    }

    public Collection getLISTA_INTERNA() {
        return LISTA_INTERNA;
    }

    public String getCDECRETO_COD_ORG_ENC() {
        return CDECRETO_COD_ORG_ENC;
    }

    public void setCDECRETO_COD_ORG_ENC(String CDECRETO_COD_ORG_ENC) {
        this.CDECRETO_COD_ORG_ENC = CDECRETO_COD_ORG_ENC;
    }

    public void setLISTA_INTERNA(Collection LISTA_INTERNA) {
        this.LISTA_INTERNA = LISTA_INTERNA;
    }

    public String getCDECRETO_NRO_DECRETO() {
        return CDECRETO_NRO_DECRETO;
    }

    public void setCDECRETO_NRO_DECRETO(String CDECRETO_NRO_DECRETO) {
        this.CDECRETO_NRO_DECRETO = CDECRETO_NRO_DECRETO;
    }

    public String getCDECRETO_PRIORIDAD() {
        return CDECRETO_PRIORIDAD;
    }

    public void setCDECRETO_PRIORIDAD(String CDECRETO_PRIORIDAD) {
        this.CDECRETO_PRIORIDAD = CDECRETO_PRIORIDAD;
    }

    public String getVDECRETO_OBSERVACION() {
        return VDECRETO_OBSERVACION;
    }

    public void setVDECRETO_OBSERVACION(String VDECRETO_OBSERVACION) {
        this.VDECRETO_OBSERVACION = VDECRETO_OBSERVACION;
    }

    public String getCDECRETO_ESTADO() {
        return CDECRETO_ESTADO;
    }

    public void setCDECRETO_ESTADO(String CDECRETO_ESTADO) {
        this.CDECRETO_ESTADO = CDECRETO_ESTADO;
    }

    public String getVDECRETO_COD_USUARIO() {
        return VDECRETO_COD_USUARIO;
    }

    public void setVDECRETO_COD_USUARIO(String VDECRETO_COD_USUARIO) {
        this.VDECRETO_COD_USUARIO = VDECRETO_COD_USUARIO;
    }

    public String getCDECRETO_SITUACION() {
        return CDECRETO_SITUACION;
    }

    public void setCDECRETO_SITUACION(String CDECRETO_SITUACION) {
        this.CDECRETO_SITUACION = CDECRETO_SITUACION;
    }
    
    public void setTIPO_DECRETO(String TIPO_DECRETO) {
        this.TIPO_DECRETO = TIPO_DECRETO;
    }

    public String getCDECRETO_COD_ORG() {
        return CDECRETO_COD_ORG;
    }

    public void setCDECRETO_COD_ORG(String CDECRETO_COD_ORG) {
        this.CDECRETO_COD_ORG = CDECRETO_COD_ORG;
    }

    public String getDDECRETO_FECH_DEC() {
        return DDECRETO_FECH_DEC;
    }

    public void setDDECRETO_FECH_DEC(String DDECRETO_FECH_DEC) {
        this.DDECRETO_FECH_DEC = DDECRETO_FECH_DEC;
    }

    public String getDDECRETO_FECH_EJEC() {
        return DDECRETO_FECH_EJEC;
    }

    public String getVDISTRIBUCION_TOKEN() {
        return VDISTRIBUCION_TOKEN;
    }

    public void setVDISTRIBUCION_TOKEN(String VDISTRIBUCION_TOKEN) {
        this.VDISTRIBUCION_TOKEN = VDISTRIBUCION_TOKEN;
    }

    public void setDDECRETO_FECH_EJEC(String DDECRETO_FECH_EJEC) {
        this.DDECRETO_FECH_EJEC = DDECRETO_FECH_EJEC;
    }

    public String getCDOCUMENTO_PERIODO() {
        return CDOCUMENTO_PERIODO;
    }

    public void setCDOCUMENTO_PERIODO(String CDOCUMENTO_PERIODO) {
        this.CDOCUMENTO_PERIODO = CDOCUMENTO_PERIODO;
    }

    public String getCDOCUMENTO_COD_DOC_INT() {
        return CDOCUMENTO_COD_DOC_INT;
    }

    public void setCDOCUMENTO_COD_DOC_INT(String CDOCUMENTO_COD_DOC_INT) {
        this.CDOCUMENTO_COD_DOC_INT = CDOCUMENTO_COD_DOC_INT;
    }

    public String getCDOCUMENTO_CLASE() {
        return CDOCUMENTO_CLASE;
    }

    public void setCDOCUMENTO_CLASE(String CDOCUMENTO_CLASE) {
        this.CDOCUMENTO_CLASE = CDOCUMENTO_CLASE;
    }

    public String getCDOCUMENTO_NRO_ORDEN() {
        return CDOCUMENTO_NRO_ORDEN;
    }

    public void setCDOCUMENTO_NRO_ORDEN(String CDOCUMENTO_NRO_ORDEN) {
        this.CDOCUMENTO_NRO_ORDEN = CDOCUMENTO_NRO_ORDEN;
    }

    public String getVDOCUMENTO_CLAVE_INDIC() {
        return VDOCUMENTO_CLAVE_INDIC;
    }

    public void setVDOCUMENTO_CLAVE_INDIC(String VDOCUMENTO_CLAVE_INDIC) {
        this.VDOCUMENTO_CLAVE_INDIC = VDOCUMENTO_CLAVE_INDIC;
    }

    public String getDDOCUMENTO_FECHA() {
        return DDOCUMENTO_FECHA;
    }

    public void setDDOCUMENTO_FECHA(String DDOCUMENTO_FECHA) {
        this.DDOCUMENTO_FECHA = DDOCUMENTO_FECHA;
    }

    public String getVDOCUMENTO_ASUNTO() {
        return VDOCUMENTO_ASUNTO;
    }

    public void setVDOCUMENTO_ASUNTO(String VDOCUMENTO_ASUNTO) {
        this.VDOCUMENTO_ASUNTO = VDOCUMENTO_ASUNTO;
    }

    public String getVCLASE_NOM_CORTO() {
        return VCLASE_NOM_CORTO;
    }

    public void setVCLASE_NOM_CORTO(String VCLASE_NOM_CORTO) {
        this.VCLASE_NOM_CORTO = VCLASE_NOM_CORTO;
    }

    public String getVOINTERNA_NOM_CORTO() {
        return VOINTERNA_NOM_CORTO;
    }

    public void setVOINTERNA_NOM_CORTO(String VOINTERNA_NOM_CORTO) {
        this.VOINTERNA_NOM_CORTO = VOINTERNA_NOM_CORTO;
    }

    public String getCDISTRIBUCION_COD_ORG() {
        return CDISTRIBUCION_COD_ORG;
    }

    public void setCDISTRIBUCION_COD_ORG(String CDISTRIBUCION_COD_ORG) {
        this.CDISTRIBUCION_COD_ORG = CDISTRIBUCION_COD_ORG;
    }

    public String getCDISTRIBUCION_TIPO_DISTRIB() {
        return CDISTRIBUCION_TIPO_DISTRIB;
    }

    public void setCDISTRIBUCION_TIPO_DISTRIB(String CDISTRIBUCION_TIPO_DISTRIB) {
        this.CDISTRIBUCION_TIPO_DISTRIB = CDISTRIBUCION_TIPO_DISTRIB;
    }

    public String getFECH_DEC() {
        return FECH_DEC;
    }

    public void setFECH_DEC(String FECH_DEC) {
        this.FECH_DEC = FECH_DEC;
    }

    public String getCDOCUMENTO_COD_ORG_DEP() {
        return CDOCUMENTO_COD_ORG_DEP;
    }

    public void setCDOCUMENTO_COD_ORG_DEP(String CDOCUMENTO_COD_ORG_DEP) {
        this.CDOCUMENTO_COD_ORG_DEP = CDOCUMENTO_COD_ORG_DEP;
    }

    public String getCDOCUMENTO_TIPO_ORG_ORIG() {
        return CDOCUMENTO_TIPO_ORG_ORIG;
    }

    public void setCDOCUMENTO_TIPO_ORG_ORIG(String CDOCUMENTO_TIPO_ORG_ORIG) {
        this.CDOCUMENTO_TIPO_ORG_ORIG = CDOCUMENTO_TIPO_ORG_ORIG;
    }

    public String getVPRIORIDAD_NOMBRE() {
        return VPRIORIDAD_NOMBRE;
    }

    public void setVPRIORIDAD_NOMBRE(String VPRIORIDAD_NOMBRE) {
        this.VPRIORIDAD_NOMBRE = VPRIORIDAD_NOMBRE;
    }

    public String getVDISTRIBUCION_NOM_FILE() {
        return VDISTRIBUCION_NOM_FILE;
    }

    public void setVDISTRIBUCION_NOM_FILE(String VDISTRIBUCION_NOM_FILE) {
        this.VDISTRIBUCION_NOM_FILE = VDISTRIBUCION_NOM_FILE;
    }
    
}