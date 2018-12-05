package sagde.bean;

import sagde.comun.Bean;

public class BeanAccion extends Bean {

    //SAGDE_ACCION
    private String CACCION_CODIGO;
    private String VACCION_NOMBRE;

    //GETTERS AND SETTERS
    public String getCACCION_CODIGO() {
        return CACCION_CODIGO;
    }

    public void setCACCION_CODIGO(String CACCION_CODIGO) {
        this.CACCION_CODIGO = CACCION_CODIGO;
    }

    public String getVACCION_NOMBRE() {
        return VACCION_NOMBRE;
    }

    public void setVACCION_NOMBRE(String VACCION_NOMBRE) {
        this.VACCION_NOMBRE = VACCION_NOMBRE;
    }
    
}
