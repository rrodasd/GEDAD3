package sagde.bean;

import sagde.comun.Bean;

public class BeanGrupo extends Bean {

    //DATA-LINK
    private String VUSUARIO_CODIGO;
    private String VGRUPO_COD;
    private String VGRUPO_DESC_CORTA;
    private String VGRUPO_IDENTIF;
    private String VGRUPO_FECHA;
    private String VGRUPO_DESC_LARGA;

    //GETTERS AND SETTERS
    public String getVUSUARIO_CODIGO() {
        return VUSUARIO_CODIGO;
    }

    public void setVUSUARIO_CODIGO(String VUSUARIO_CODIGO) {
        this.VUSUARIO_CODIGO = VUSUARIO_CODIGO;
    }

    public String getVGRUPO_COD() {
        return VGRUPO_COD;
    }

    public void setVGRUPO_COD(String VGRUPO_COD) {
        this.VGRUPO_COD = VGRUPO_COD;
    }

    public String getVGRUPO_DESC_CORTA() {
        return VGRUPO_DESC_CORTA;
    }

    public void setVGRUPO_DESC_CORTA(String VGRUPO_DESC_CORTA) {
        this.VGRUPO_DESC_CORTA = VGRUPO_DESC_CORTA;
    }

    public String getVGRUPO_IDENTIF() {
        return VGRUPO_IDENTIF;
    }

    public void setVGRUPO_IDENTIF(String VGRUPO_IDENTIF) {
        this.VGRUPO_IDENTIF = VGRUPO_IDENTIF;
    }

    public String getVGRUPO_FECHA() {
        return VGRUPO_FECHA;
    }

    public void setVGRUPO_FECHA(String VGRUPO_FECHA) {
        this.VGRUPO_FECHA = VGRUPO_FECHA;
    }

    public String getVGRUPO_DESC_LARGA() {
        return VGRUPO_DESC_LARGA;
    }

    public void setVGRUPO_DESC_LARGA(String VGRUPO_DESC_LARGA) {
        this.VGRUPO_DESC_LARGA = VGRUPO_DESC_LARGA;
    }

}
