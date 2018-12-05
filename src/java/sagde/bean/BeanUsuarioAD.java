package sagde.bean;

public class BeanUsuarioAD {

  

    //TABLA USUARIO_AD
    private String VUSUARIO_CODIGO;
    private String CUSUARIO_COD_ORG;
    private String VUSUARIO_CARGO;
    private String DUSUARIO_FECH_REG;
    private String CUSUARIO_ESTADO;
    private String CUSUARIO_FLAG_JEFE;
    
    //TABLA ORGANIZACION_INTERNA
    private String VOINTERNA_NOM_CORTO;
    
    //CAMPOS DEL DATA LINK    
    private String CPERSONA_NRODOC;
    private String CMILITAR_CIP;
    private String VPERSONA_NOMBRE;
    private String VPERSONA_APETPAT;
    private String VPERSONA_APETMAT;
    private String APENOM;
    private String CMILITAR_GRADOACTUAL;
    private String CGRADO_DESCCORT;
    private String CARMA_COD;
    private String VARMAS_DESCOR;
    private String VPERSONA_CORREOEP;
    private String NICKNAME;
    private String CMILITAR_UUACTUAL;
    private String VUNIDAD_DESCOR;   
    private String JEFE_UNIDAD;    
    
    //GETTERS AND SETTERS
    
    public String getJEFE_UNIDAD() {
        return JEFE_UNIDAD;
    }

    public void setJEFE_UNIDAD(String JEFE_UNIDAD) {
        this.JEFE_UNIDAD = JEFE_UNIDAD;
    }
    public String getVUSUARIO_CODIGO() {
        return VUSUARIO_CODIGO;
    }

    public void setVUSUARIO_CODIGO(String VUSUARIO_CODIGO) {
        this.VUSUARIO_CODIGO = VUSUARIO_CODIGO;
    }

    public String getCUSUARIO_COD_ORG() {
        return CUSUARIO_COD_ORG;
    }

    public void setCUSUARIO_COD_ORG(String CUSUARIO_COD_ORG) {
        this.CUSUARIO_COD_ORG = CUSUARIO_COD_ORG;
    }

    public String getVUSUARIO_CARGO() {
        return VUSUARIO_CARGO;
    }

    public void setVUSUARIO_CARGO(String VUSUARIO_CARGO) {
        this.VUSUARIO_CARGO = VUSUARIO_CARGO;
    }

    public String getDUSUARIO_FECH_REG() {
        return DUSUARIO_FECH_REG;
    }

    public void setDUSUARIO_FECH_REG(String DUSUARIO_FECH_REG) {
        this.DUSUARIO_FECH_REG = DUSUARIO_FECH_REG;
    }

    public String getCUSUARIO_ESTADO() {
        return CUSUARIO_ESTADO;
    }

    public void setCUSUARIO_ESTADO(String CUSUARIO_ESTADO) {
        this.CUSUARIO_ESTADO = CUSUARIO_ESTADO;
    }

    public String getCUSUARIO_FLAG_JEFE() {
        return CUSUARIO_FLAG_JEFE;
    }

    public void setCUSUARIO_FLAG_JEFE(String CUSUARIO_FLAG_JEFE) {
        this.CUSUARIO_FLAG_JEFE = CUSUARIO_FLAG_JEFE;
    }

    public String getAPENOM() {
        return APENOM;
    }

    public void setAPENOM(String APENOM) {
        this.APENOM = APENOM;
    }

    public String getVARMAS_DESCOR() {
        return VARMAS_DESCOR;
    }

    public void setVARMAS_DESCOR(String VARMAS_DESCOR) {
        this.VARMAS_DESCOR = VARMAS_DESCOR;
    }

    public String getNICKNAME() {
        return NICKNAME;
    }

    public void setNICKNAME(String NICKNAME) {
        this.NICKNAME = NICKNAME;
    }

    public String getCPERSONA_NRODOC() {
        return CPERSONA_NRODOC;
    }

    public void setCPERSONA_NRODOC(String CPERSONA_NRODOC) {
        this.CPERSONA_NRODOC = CPERSONA_NRODOC;
    }

    public String getCMILITAR_CIP() {
        return CMILITAR_CIP;
    }

    public void setCMILITAR_CIP(String CMILITAR_CIP) {
        this.CMILITAR_CIP = CMILITAR_CIP;
    }

    public String getVPERSONA_NOMBRE() {
        return VPERSONA_NOMBRE;
    }

    public void setVPERSONA_NOMBRE(String VPERSONA_NOMBRE) {
        this.VPERSONA_NOMBRE = VPERSONA_NOMBRE;
    }

    public String getVPERSONA_APETPAT() {
        return VPERSONA_APETPAT;
    }

    public void setVPERSONA_APETPAT(String VPERSONA_APETPAT) {
        this.VPERSONA_APETPAT = VPERSONA_APETPAT;
    }

    public String getVPERSONA_APETMAT() {
        return VPERSONA_APETMAT;
    }

    public void setVPERSONA_APETMAT(String VPERSONA_APETMAT) {
        this.VPERSONA_APETMAT = VPERSONA_APETMAT;
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

    public String getCARMA_COD() {
        return CARMA_COD;
    }

    public void setCARMA_COD(String CARMA_COD) {
        this.CARMA_COD = CARMA_COD;
    }

    public String getVPERSONA_CORREOEP() {
        return VPERSONA_CORREOEP;
    }

    public void setVPERSONA_CORREOEP(String VPERSONA_CORREOEP) {
        this.VPERSONA_CORREOEP = VPERSONA_CORREOEP;
    }

    public String getCMILITAR_UUACTUAL() {
        return CMILITAR_UUACTUAL;
    }

    public void setCMILITAR_UUACTUAL(String CMILITAR_UUACTUAL) {
        this.CMILITAR_UUACTUAL = CMILITAR_UUACTUAL;
    }

    public String getVUNIDAD_DESCOR() {
        return VUNIDAD_DESCOR;
    }

    public void setVUNIDAD_DESCOR(String VUNIDAD_DESCOR) {
        this.VUNIDAD_DESCOR = VUNIDAD_DESCOR;
    }

    public String getVOINTERNA_NOM_CORTO() {
        return VOINTERNA_NOM_CORTO;
    }

    public void setVOINTERNA_NOM_CORTO(String VOINTERNA_NOM_CORTO) {
        this.VOINTERNA_NOM_CORTO = VOINTERNA_NOM_CORTO;
    }
    
    
    
}