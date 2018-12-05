package sagde.bean;

import sagde.comun.Bean;

public class BeanDocumento extends Bean {

    private String periodo;
    private String tipoOrganizacion;
    private String codigoOrganizacion;
    private String clase;
    private String numero;
    private String codigo;
    private String clave;
    private String archivo;
    private String clasificacion;
    private String prioridad;
    private String fecha;
    private String asunto;
    private String estado_ref;

    private String cuerpo;
    private String usuario;
    private String codigoOrganizacionDep;
    private String nombreOrganizacionFax;
    private String gradocargofax;
    private String codigoOrganizacionNiv;
    private String guarnicion;

    private String codigoDocumentoInterno;

//	para revisar las referencias
    private String referencia_periodo;
    private String referencia_codigoDocumento;

    private String clase_nombreCorto;

    //para distribuion
    private String cdistribucion_tipo_org;
    private String cdistribucion_cod_org;

    //para firma
    private String v_firma_usuario;

    //PARA LA LETRAS DE LAS REFERENCIAS
    private String letras = "";

    //PARA LA DESCRIPCION ORG DE DEPENDENCIA
    private String desorgdep = "";

    //PARA EL DOCUMENTO ACTA 
    private String acta;
    private String vocal;
    private String secretario;
    private String presidente;
    private String cge;

    //para el estado me indica si va a arhivo 
    private String estado;

    private String tiporegistro;

    private String DDOCUMENTO_FEC_ACT;

//	atributos para la firma
    private String cfirma_nro_serie;
    private String vfirma_ape_nom;
    private String vfirma_grado;
    private String vfirma_cargo;
    private String vfirma_cod_usuario;
    private String cusuario_cod_org;

//	atributos para la firma ACTA
    private String VFIRACT_USU_PRESIDENTE;
    private String VFIRACT_USU_VOCAL;
    private String VFIRACT_USU_SECRETARIO;
    private String VFIRACT_TIPO_ACTA;

    private String CFIRMA_NRO_SERIE2;
    private String VFIRMA_APE_NOM2;
    private String VFIRMA_GRADO2;
    private String VFIRMA_CARGO2;
    private String CFIRMA_NRO_SERIE3;
    private String VFIRMA_APE_NOM3;
    private String VFIRMA_GRADO3;
    private String VFIRMA_CARGO3;

//ATRIBUTOS PARA MEMBRETE
    private String desOrganizacionDep;
    private String desOrganizacionNiv;
    private String desOrgDepCorto;
    private String desOrgNivCorto;
    private String desGradoCargoFax;

//	para revisar las distribucion destino
    private String distribucion_grado;
    private String distribucion_nombre;
    private String distribucion_cargo;

    private String V_tipo_accion;

    public String getTiporegistro() {
        return tiporegistro;
    }

    public void setTiporegistro(String tiporegistro) {
        this.tiporegistro = tiporegistro;
    }

    public String getArchivo() {
        return archivo;
    }

    public void setArchivo(String archivo) {
        this.archivo = archivo;
    }

    public String getAsunto() {
        return asunto;
    }

    public void setAsunto(String asunto) {
        this.asunto = asunto;
    }

    public String getClase() {
        return clase;
    }

    public void setClase(String clase) {
        this.clase = clase;
    }

    public String getClasificacion() {
        return clasificacion;
    }

    public void setClasificacion(String clasificacion) {
        this.clasificacion = clasificacion;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getCodigoOrganizacion() {
        return codigoOrganizacion;
    }

    public void setCodigoOrganizacion(String codigoOrganizacion) {
        this.codigoOrganizacion = codigoOrganizacion;
    }

    public String getCuerpo() {
        return cuerpo;
    }

    public void setCuerpo(String cuerpo) {
        this.cuerpo = cuerpo;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getFecha() {
        return fecha;
    }

    public void setFecha(String fecha) {
        this.fecha = fecha;
    }

    public String getNumero() {
        return numero;
    }

    public void setNumero(String numero) {
        this.numero = numero;
    }

    public String getPeriodo() {
        return periodo;
    }

    public void setPeriodo(String periodo) {
        this.periodo = periodo;
    }

    public String getPrioridad() {
        return prioridad;
    }

    public void setPrioridad(String prioridad) {
        this.prioridad = prioridad;
    }

    public String getTipoOrganizacion() {
        return tipoOrganizacion;
    }

    public void setTipoOrganizacion(String tipoOrganizacion) {
        this.tipoOrganizacion = tipoOrganizacion;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public String getCodigoOrganizacionDep() {
        return codigoOrganizacionDep;
    }

    public void setCodigoOrganizacionDep(String codigoOrganizacionDep) {
        this.codigoOrganizacionDep = codigoOrganizacionDep;
    }

    public String getCodigoOrganizacionNiv() {
        return codigoOrganizacionNiv;
    }

    public void setCodigoOrganizacionNiv(String codigoOrganizacionNiv) {
        this.codigoOrganizacionNiv = codigoOrganizacionNiv;
    }

    public String getGuarnicion() {
        return guarnicion;
    }

    public void setGuarnicion(String guarnicion) {
        this.guarnicion = guarnicion;
    }

    public String getCodigoDocumentoInterno() {
        return codigoDocumentoInterno;
    }

    public void setCodigoDocumentoInterno(String codigoDocumentoInterno) {
        this.codigoDocumentoInterno = codigoDocumentoInterno;
    }

    public String getClase_nombreCorto() {
        return clase_nombreCorto;
    }

    public void setClase_nombreCorto(String clase_nombreCorto) {
        this.clase_nombreCorto = clase_nombreCorto;
    }

    public String getReferencia_codigoDocumento() {
        return referencia_codigoDocumento;
    }

    public void setReferencia_codigoDocumento(String referencia_codigoDocumento) {
        this.referencia_codigoDocumento = referencia_codigoDocumento;
    }

    public String getReferencia_periodo() {
        return referencia_periodo;
    }

    public void setReferencia_periodo(String referencia_periodo) {
        this.referencia_periodo = referencia_periodo;
    }

    public String getCdistribucion_cod_org() {
        return cdistribucion_cod_org;
    }

    public void setCdistribucion_cod_org(String cdistribucion_cod_org) {
        this.cdistribucion_cod_org = cdistribucion_cod_org;
    }

    public String getCdistribucion_tipo_org() {
        return cdistribucion_tipo_org;
    }

    public void setCdistribucion_tipo_org(String cdistribucion_tipo_org) {
        this.cdistribucion_tipo_org = cdistribucion_tipo_org;
    }

    public String getV_firma_usuario() {
        return v_firma_usuario;
    }

    public void setV_firma_usuario(String v_firma_usuario) {
        this.v_firma_usuario = v_firma_usuario;
    }

    public String getLetras() {
        return letras;
    }

    public void setLetras(String letras) {
        this.letras = letras;
    }

    public String getDesorgdep() {
        return desorgdep;
    }

    public void setDesorgdep(String desorgdep) {
        this.desorgdep = desorgdep;
    }

    public String getActa() {
        return acta;
    }

    public void setActa(String acta) {
        this.acta = acta;
    }

    public String getSecretario() {
        return secretario;
    }

    public void setSecretario(String secretario) {
        this.secretario = secretario;
    }

    public String getVocal() {
        return vocal;
    }

    public void setVocal(String vocal) {
        this.vocal = vocal;
    }

    public String getEstado_ref() {
        return estado_ref;
    }

    public void setEstado_ref(String estado_ref) {
        this.estado_ref = estado_ref;
    }

    public String getDDOCUMENTO_FEC_ACT() {
        return DDOCUMENTO_FEC_ACT;
    }

    public void setDDOCUMENTO_FEC_ACT(String ddocumento_fec_act) {
        DDOCUMENTO_FEC_ACT = ddocumento_fec_act;
    }

    public String getCfirma_nro_serie() {
        return cfirma_nro_serie;
    }

    public void setCfirma_nro_serie(String cfirma_nro_serie) {
        this.cfirma_nro_serie = cfirma_nro_serie;
    }

    public String getCFIRMA_NRO_SERIE2() {
        return CFIRMA_NRO_SERIE2;
    }

    public void setCFIRMA_NRO_SERIE2(String cfirma_nro_serie2) {
        CFIRMA_NRO_SERIE2 = cfirma_nro_serie2;
    }

    public String getCFIRMA_NRO_SERIE3() {
        return CFIRMA_NRO_SERIE3;
    }

    public void setCFIRMA_NRO_SERIE3(String cfirma_nro_serie3) {
        CFIRMA_NRO_SERIE3 = cfirma_nro_serie3;
    }

    public String getCusuario_cod_org() {
        return cusuario_cod_org;
    }

    public void setCusuario_cod_org(String cusuario_cod_org) {
        this.cusuario_cod_org = cusuario_cod_org;
    }

    public String getDesOrganizacionDep() {
        return desOrganizacionDep;
    }

    public void setDesOrganizacionDep(String desOrganizacionDep) {
        this.desOrganizacionDep = desOrganizacionDep;
    }

    public String getDesOrganizacionNiv() {
        return desOrganizacionNiv;
    }

    public void setDesOrganizacionNiv(String desOrganizacionNiv) {
        this.desOrganizacionNiv = desOrganizacionNiv;
    }

    public String getDesOrgDepCorto() {
        return desOrgDepCorto;
    }

    public void setDesOrgDepCorto(String desOrgDepCorto) {
        this.desOrgDepCorto = desOrgDepCorto;
    }

    public String getDesOrgNivCorto() {
        return desOrgNivCorto;
    }

    public void setDesOrgNivCorto(String desOrgNivCorto) {
        this.desOrgNivCorto = desOrgNivCorto;
    }

    public String getDistribucion_cargo() {
        return distribucion_cargo;
    }

    public void setDistribucion_cargo(String distribucion_cargo) {
        this.distribucion_cargo = distribucion_cargo;
    }

    public String getDistribucion_grado() {
        return distribucion_grado;
    }

    public void setDistribucion_grado(String distribucion_grado) {
        this.distribucion_grado = distribucion_grado;
    }

    public String getDistribucion_nombre() {
        return distribucion_nombre;
    }

    public void setDistribucion_nombre(String distribucion_nombre) {
        this.distribucion_nombre = distribucion_nombre;
    }

    public String getVFIRACT_TIPO_ACTA() {
        return VFIRACT_TIPO_ACTA;
    }

    public void setVFIRACT_TIPO_ACTA(String vfiract_tipo_acta) {
        VFIRACT_TIPO_ACTA = vfiract_tipo_acta;
    }

    public String getVFIRACT_USU_PRESIDENTE() {
        return VFIRACT_USU_PRESIDENTE;
    }

    public void setVFIRACT_USU_PRESIDENTE(String vfiract_usu_presidente) {
        VFIRACT_USU_PRESIDENTE = vfiract_usu_presidente;
    }

    public String getVFIRACT_USU_SECRETARIO() {
        return VFIRACT_USU_SECRETARIO;
    }

    public void setVFIRACT_USU_SECRETARIO(String vfiract_usu_secretario) {
        VFIRACT_USU_SECRETARIO = vfiract_usu_secretario;
    }

    public String getVFIRACT_USU_VOCAL() {
        return VFIRACT_USU_VOCAL;
    }

    public void setVFIRACT_USU_VOCAL(String vfiract_usu_vocal) {
        VFIRACT_USU_VOCAL = vfiract_usu_vocal;
    }

    public String getVfirma_ape_nom() {
        return vfirma_ape_nom;
    }

    public void setVfirma_ape_nom(String vfirma_ape_nom) {
        this.vfirma_ape_nom = vfirma_ape_nom;
    }

    public String getVFIRMA_APE_NOM2() {
        return VFIRMA_APE_NOM2;
    }

    public void setVFIRMA_APE_NOM2(String vfirma_ape_nom2) {
        VFIRMA_APE_NOM2 = vfirma_ape_nom2;
    }

    public String getVFIRMA_APE_NOM3() {
        return VFIRMA_APE_NOM3;
    }

    public void setVFIRMA_APE_NOM3(String vfirma_ape_nom3) {
        VFIRMA_APE_NOM3 = vfirma_ape_nom3;
    }

    public String getVfirma_cargo() {
        return vfirma_cargo;
    }

    public void setVfirma_cargo(String vfirma_cargo) {
        this.vfirma_cargo = vfirma_cargo;
    }

    public String getVFIRMA_CARGO2() {
        return VFIRMA_CARGO2;
    }

    public void setVFIRMA_CARGO2(String vfirma_cargo2) {
        VFIRMA_CARGO2 = vfirma_cargo2;
    }

    public String getVFIRMA_CARGO3() {
        return VFIRMA_CARGO3;
    }

    public void setVFIRMA_CARGO3(String vfirma_cargo3) {
        VFIRMA_CARGO3 = vfirma_cargo3;
    }

    public String getVfirma_cod_usuario() {
        return vfirma_cod_usuario;
    }

    public void setVfirma_cod_usuario(String vfirma_cod_usuario) {
        this.vfirma_cod_usuario = vfirma_cod_usuario;
    }

    public String getVfirma_grado() {
        return vfirma_grado;
    }

    public void setVfirma_grado(String vfirma_grado) {
        this.vfirma_grado = vfirma_grado;
    }

    public String getVFIRMA_GRADO2() {
        return VFIRMA_GRADO2;
    }

    public void setVFIRMA_GRADO2(String vfirma_grado2) {
        VFIRMA_GRADO2 = vfirma_grado2;
    }

    public String getVFIRMA_GRADO3() {
        return VFIRMA_GRADO3;
    }

    public void setVFIRMA_GRADO3(String vfirma_grado3) {
        VFIRMA_GRADO3 = vfirma_grado3;
    }

    public String getCge() {
        return cge;
    }

    public void setCge(String cge) {
        this.cge = cge;
    }

    public String getPresidente() {
        return presidente;
    }

    public void setPresidente(String presidente) {
        this.presidente = presidente;
    }

    public String getV_tipo_accion() {
        return V_tipo_accion;
    }

    public void setV_tipo_accion(String v_tipo_accion) {
        V_tipo_accion = v_tipo_accion;
    }

    public String getNombreOrganizacionFax() {
        return nombreOrganizacionFax;
    }

    public void setNombreOrganizacionFax(String nombreOrganizacionFax) {
        this.nombreOrganizacionFax = nombreOrganizacionFax;
    }

    public String getGradocargofax() {
        return gradocargofax;
    }

    public void setGradocargofax(String gradocargofax) {
        this.gradocargofax = gradocargofax;
    }

    public String getDesGradoCargoFax() {
        return desGradoCargoFax;
    }

    public void setDesGradoCargoFax(String desGradoCargoFax) {
        this.desGradoCargoFax = desGradoCargoFax;
    }

}
