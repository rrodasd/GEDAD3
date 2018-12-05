package sagde.bean;

import sagde.comun.Bean;

public class BeanEncargatura extends Bean {

    //SAGDE_ENCARGATURA
    private String CENCARGATURA_COD_ORG;
    private String CENCARGATURA_COD_ORG_ENC;
    private String CENCARGATURA_TIPO;
    private String DENCARGATURA_DESDE;
    private String DENCARGATURA_HASTA;
    private String VENCARGATURA_USUARIO;
    
    //SAGDE_ORGANIZACION_INTERNA
    private String VOINTERNA_NOM_CORTO;
    
    //DATALINK COPERE
    private String APENOM;
    private String CMILITAR_GRADOACTUAL;
    private String CGRADO_DESCCORT;
    private String VARMA_CATEG;
    private String VARMACAT_DESCORT;
    
    //Adicional
    private String VOINTERNA_NOM_CORTO_2;
    private String TIPOENCARGATURA_DESC;

    //GETTERS AND SETTERS
    public String getCENCARGATURA_COD_ORG() {
        return CENCARGATURA_COD_ORG;
    }

    public void setCENCARGATURA_COD_ORG(String CENCARGATURA_COD_ORG) {
        this.CENCARGATURA_COD_ORG = CENCARGATURA_COD_ORG;
    }

    public String getCENCARGATURA_COD_ORG_ENC() {
        return CENCARGATURA_COD_ORG_ENC;
    }

    public void setCENCARGATURA_COD_ORG_ENC(String CENCARGATURA_COD_ORG_ENC) {
        this.CENCARGATURA_COD_ORG_ENC = CENCARGATURA_COD_ORG_ENC;
    }

    public String getCENCARGATURA_TIPO() {
        return CENCARGATURA_TIPO;
    }

    public void setCENCARGATURA_TIPO(String CENCARGATURA_TIPO) {
        this.CENCARGATURA_TIPO = CENCARGATURA_TIPO;
    }

    public String getDENCARGATURA_DESDE() {
        return DENCARGATURA_DESDE;
    }

    public void setDENCARGATURA_DESDE(String DENCARGATURA_DESDE) {
        this.DENCARGATURA_DESDE = DENCARGATURA_DESDE;
    }

    public String getDENCARGATURA_HASTA() {
        return DENCARGATURA_HASTA;
    }

    public void setDENCARGATURA_HASTA(String DENCARGATURA_HASTA) {
        this.DENCARGATURA_HASTA = DENCARGATURA_HASTA;
    }

    public String getVENCARGATURA_USUARIO() {
        return VENCARGATURA_USUARIO;
    }

    public void setVENCARGATURA_USUARIO(String VENCARGATURA_USUARIO) {
        this.VENCARGATURA_USUARIO = VENCARGATURA_USUARIO;
    }

    public String getVOINTERNA_NOM_CORTO() {
        return VOINTERNA_NOM_CORTO;
    }

    public void setVOINTERNA_NOM_CORTO(String VOINTERNA_NOM_CORTO) {
        this.VOINTERNA_NOM_CORTO = VOINTERNA_NOM_CORTO;
    }

    public String getVOINTERNA_NOM_CORTO_2() {
        return VOINTERNA_NOM_CORTO_2;
    }

    public void setVOINTERNA_NOM_CORTO_2(String VOINTERNA_NOM_CORTO_2) {
        this.VOINTERNA_NOM_CORTO_2 = VOINTERNA_NOM_CORTO_2;
    }

    public String getAPENOM() {
        return APENOM;
    }

    public void setAPENOM(String APENOM) {
        this.APENOM = APENOM;
    }

    public String getCMILITAR_GRADOACTUAL() {
        return CMILITAR_GRADOACTUAL;
    }

    public void setCMILITAR_GRADOACTUAL(String CMILITAR_GRADOACTUAL) {
        this.CMILITAR_GRADOACTUAL = CMILITAR_GRADOACTUAL;
    }

    public String getCGRADO_DESCCORT() {
        return CGRADO_DESCCORT;
    }

    public void setCGRADO_DESCCORT(String CGRADO_DESCCORT) {
        this.CGRADO_DESCCORT = CGRADO_DESCCORT;
    }

    public String getVARMA_CATEG() {
        return VARMA_CATEG;
    }

    public void setVARMA_CATEG(String VARMA_CATEG) {
        this.VARMA_CATEG = VARMA_CATEG;
    }

    public String getVARMACAT_DESCORT() {
        return VARMACAT_DESCORT;
    }

    public void setVARMACAT_DESCORT(String VARMACAT_DESCORT) {
        this.VARMACAT_DESCORT = VARMACAT_DESCORT;
    }

    public String getTIPOENCARGATURA_DESC() {
        return TIPOENCARGATURA_DESC;
    }

    public void setTIPOENCARGATURA_DESC(String TIPOENCARGATURA_DESC) {
        this.TIPOENCARGATURA_DESC = TIPOENCARGATURA_DESC;
    }

}