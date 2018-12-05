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

}