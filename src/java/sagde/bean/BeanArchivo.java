package sagde.bean;

import sagde.comun.Bean;

public class BeanArchivo extends Bean {

    private String CARCHIVO_CODIGO;
    private String VARCHIVO_NOMBRE;

    public String getCARCHIVO_CODIGO() {
        return CARCHIVO_CODIGO;
    }

    public void setCARCHIVO_CODIGO(String carchivo_codigo) {
        CARCHIVO_CODIGO = carchivo_codigo;
    }

    public String getVARCHIVO_NOMBRE() {
        return VARCHIVO_NOMBRE;
    }

    public void setVARCHIVO_NOMBRE(String varchivo_nombre) {
        VARCHIVO_NOMBRE = varchivo_nombre;
    }

}
