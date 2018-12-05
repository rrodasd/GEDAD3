package sagde.bean;

import sagde.comun.Bean;

public class BeanRevisarDocumento1 extends Bean{

    /**
     * @return the NroPendienteRev
     */
    public String getNroPendienteRev() {
        return NroPendienteRev;
    }

    /**
     * @param NroPendienteRev the NroPendienteRev to set
     */
    public void setNroPendienteRev(String NroPendienteRev) {
        this.NroPendienteRev = NroPendienteRev;
    }
	//Bean auxiliar para la revision de documentos
	
	private String periodo;
	private String codigoDocumentoInterno;
	private String codigoClaseDocumento;
	private String nombreClaseDocumento;
	private String nOrdenDocumento;
	private String claveIndicativo;
	private String asunto;
	private String secuencia;
	private String observacion;
	private String usuarioRevision;
	
	private String tipoOrganizacion;
	private String codigoOrganizacion;
	private String clase;
	private String clave;
	private String archivo;
	private String clasificacion;
	private String prioridad;
	private String fecha;
	private String estado;
	private String usuario;
	private String codigoOrganizacionDep;
	private String nombreOrganizacionFax;
	private String gradocargofax;
	private String codigoOrganizacionNiv;
	private String guarnicion;
	private String tipoAccion;
	private String usuarioDestino;
	private String usuarioEnvia;
	private String fechaEstado;
	private String destino;
	
	
	//para revisar acta
	private String actas;
	private String vocal;
	private String secretario;

	
	//para revisar las referencias
	private String referencia_periodo;
	private String referencia_codigoDocumento;
	private String clase_nombreCorto;
	
	
	
	
	
	//cuerpo de documento
	private String cuerpo;
	//destino
	private String grado;
	private String don;
	private String cargo;
	
	//para revisar las distribucion destino
	private String distribucion_grado;
	private String distribucion_nombre;
	private String distribucion_cargo;
	
	private String CDISTRIBUCION_COD_ORG;
	
	
	//atributos para la firma
	private String cfirma_nro_serie;
	private String vfirma_ape_nom;
	private String vfirma_grado;
	private String vfirma_cargo;
	private String vfirma_cod_usuario;
	private String cusuario_cod_org;
	
	//atributos para la firma ACTA
	private String VFIRACT_USU_PRESIDENTE;
	private String VFIRACT_USU_VOCAL;
	private String VFIRACT_USU_SECRETARIO;
	private String VFIRACT_TIPO_ACTA;
	
	private String VFIRMA_COD_USU2;
	private String CFIRMA_COD_ORG2;
	private String VFIRMA_COD_USU3;
	private String CFIRMA_COD_ORG3;
	private String VFIRMA_COD_USU4;
	private String CFIRMA_COD_ORG4;
	
	
	private String CFIRMA_NRO_SERIE2;
	private String VFIRMA_APE_NOM2;
	private String VFIRMA_GRADO2;
	private String VFIRMA_CARGO2;
	private String CFIRMA_NRO_SERIE3;
	private String VFIRMA_APE_NOM3;
	private String VFIRMA_GRADO3;
	private String VFIRMA_CARGO3;
	private String CFIRMA_NRO_SERIE4;
	private String VFIRMA_APE_NOM4;
	private String VFIRMA_GRADO4;
	private String VFIRMA_CARGO4;
	private String VFIRACT_USU_CGE;
	
	
	
	//ATRIBUTOS PARA MEMBRETE
	
	private String desOrganizacionDep;
	private String desOrganizacionNiv;
	private String desOrgDepCorto;
	private String desOrgNivCorto;
	private String desGradoCargoFax;
	
	private String NroPendienteRev;
	
	
	
	
	public String getCusuario_cod_org() {
		return cusuario_cod_org;
	}
	public void setCusuario_cod_org(String cusuario_cod_org) {
		this.cusuario_cod_org = cusuario_cod_org;
	}
	public String getAsunto() {
		return asunto;
	}
	public void setAsunto(String asunto) {
		this.asunto = asunto;
	}
	public String getClaveIndicativo() {
		return claveIndicativo;
	}
	public void setClaveIndicativo(String claveIndicativo) {
		this.claveIndicativo = claveIndicativo;
	}
	public String getCodigoClaseDocumento() {
		return codigoClaseDocumento;
	}
	public void setCodigoClaseDocumento(String codigoClaseDocumento) {
		this.codigoClaseDocumento = codigoClaseDocumento;
	}
	public String getCodigoDocumentoInterno() {
		return codigoDocumentoInterno;
	}
	public void setCodigoDocumentoInterno(String codigoDocumentoInterno) {
		this.codigoDocumentoInterno = codigoDocumentoInterno;
	}
	public String getNombreClaseDocumento() {
		return nombreClaseDocumento;
	}
	public void setNombreClaseDocumento(String nombreClaseDocumento) {
		this.nombreClaseDocumento = nombreClaseDocumento;
	}
	public String getNOrdenDocumento() {
		return nOrdenDocumento;
	}
	public void setNOrdenDocumento(String ordenDocumento) {
		nOrdenDocumento = ordenDocumento;
	}
	public String getPeriodo() {
		return periodo;
	}
	public void setPeriodo(String periodo) {
		this.periodo = periodo;
	}
	public String getObservacion() {
		return observacion;
	}
	public void setObservacion(String observacion) {
		this.observacion = observacion;
	}
	public String getSecuencia() {
		return secuencia;
	}
	public void setSecuencia(String secuencia) {
		this.secuencia = secuencia;
	}
	public String getArchivo() {
		return archivo;
	}
	public void setArchivo(String archivo) {
		this.archivo = archivo;
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
	public String getCodigoOrganizacion() {
		return codigoOrganizacion;
	}
	public void setCodigoOrganizacion(String codigoOrganizacion) {
		this.codigoOrganizacion = codigoOrganizacion;
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
	public String getGuarnicion() {
		return guarnicion;
	}
	public void setGuarnicion(String guarnicion) {
		this.guarnicion = guarnicion;
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
	public String getCuerpo() {
		return cuerpo;
	}
	public void setCuerpo(String cuerpo) {
		this.cuerpo = cuerpo;
	}
	public String getUsuarioRevision() {
		return usuarioRevision;
	}
	public void setUsuarioRevision(String usuarioRevision) {
		this.usuarioRevision = usuarioRevision;
	}
	public String getTipoAccion() {
		return tipoAccion;
	}
	public void setTipoAccion(String tipoAccion) {
		this.tipoAccion = tipoAccion;
	}
	public String getUsuarioDestino() {
		return usuarioDestino;
	}
	public void setUsuarioDestino(String usuarioDestino) {
		this.usuarioDestino = usuarioDestino;
	}
	public String getCfirma_nro_serie() {
		return cfirma_nro_serie;
	}
	public void setCfirma_nro_serie(String cfirma_nro_serie) {
		this.cfirma_nro_serie = cfirma_nro_serie;
	}
	public String getVfirma_ape_nom() {
		return vfirma_ape_nom;
	}
	public void setVfirma_ape_nom(String vfirma_ape_nom) {
		this.vfirma_ape_nom = vfirma_ape_nom;
	}
	public String getVfirma_cargo() {
		return vfirma_cargo;
	}
	public void setVfirma_cargo(String vfirma_cargo) {
		this.vfirma_cargo = vfirma_cargo;
	}
	public String getVfirma_grado() {
		return vfirma_grado;
	}
	public void setVfirma_grado(String vfirma_grado) {
		this.vfirma_grado = vfirma_grado;
	}
	public String getVfirma_cod_usuario() {
		return vfirma_cod_usuario;
	}
	public void setVfirma_cod_usuario(String vfirma_cod_usuario) {
		this.vfirma_cod_usuario = vfirma_cod_usuario;
	}
	public String getCDISTRIBUCION_COD_ORG() {
		return CDISTRIBUCION_COD_ORG;
	}
	public void setCDISTRIBUCION_COD_ORG(String cdistribucion_cod_org) {
		CDISTRIBUCION_COD_ORG = cdistribucion_cod_org;
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
	public String getFechaEstado() {
		return fechaEstado;
	}
	public void setFechaEstado(String fechaEstado) {
		this.fechaEstado = fechaEstado;
	}
	public String getUsuarioEnvia() {
		return usuarioEnvia;
	}
	public void setUsuarioEnvia(String usuarioEnvia) {
		this.usuarioEnvia = usuarioEnvia;
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
	public String getActas() {
		return actas;
	}
	public void setActas(String actas) {
		this.actas = actas;
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
	public String getCFIRMA_NRO_SERIE4() {
		return CFIRMA_NRO_SERIE4;
	}
	public void setCFIRMA_NRO_SERIE4(String cfirma_nro_serie4) {
		CFIRMA_NRO_SERIE4 = cfirma_nro_serie4;
	}
	public String getVFIRACT_USU_CGE() {
		return VFIRACT_USU_CGE;
	}
	public void setVFIRACT_USU_CGE(String vfiract_usu_cge) {
		VFIRACT_USU_CGE = vfiract_usu_cge;
	}
	public String getVFIRMA_APE_NOM4() {
		return VFIRMA_APE_NOM4;
	}
	public void setVFIRMA_APE_NOM4(String vfirma_ape_nom4) {
		VFIRMA_APE_NOM4 = vfirma_ape_nom4;
	}
	public String getVFIRMA_CARGO4() {
		return VFIRMA_CARGO4;
	}
	public void setVFIRMA_CARGO4(String vfirma_cargo4) {
		VFIRMA_CARGO4 = vfirma_cargo4;
	}
	public String getVFIRMA_GRADO4() {
		return VFIRMA_GRADO4;
	}
	public void setVFIRMA_GRADO4(String vfirma_grado4) {
		VFIRMA_GRADO4 = vfirma_grado4;
	}
	public String getCFIRMA_COD_ORG2() {
		return CFIRMA_COD_ORG2;
	}
	public void setCFIRMA_COD_ORG2(String cfirma_cod_org2) {
		CFIRMA_COD_ORG2 = cfirma_cod_org2;
	}
	public String getCFIRMA_COD_ORG3() {
		return CFIRMA_COD_ORG3;
	}
	public void setCFIRMA_COD_ORG3(String cfirma_cod_org3) {
		CFIRMA_COD_ORG3 = cfirma_cod_org3;
	}
	public String getCFIRMA_COD_ORG4() {
		return CFIRMA_COD_ORG4;
	}
	public void setCFIRMA_COD_ORG4(String cfirma_cod_org4) {
		CFIRMA_COD_ORG4 = cfirma_cod_org4;
	}
	public String getVFIRMA_COD_USU2() {
		return VFIRMA_COD_USU2;
	}
	public void setVFIRMA_COD_USU2(String vfirma_cod_usu2) {
		VFIRMA_COD_USU2 = vfirma_cod_usu2;
	}
	public String getVFIRMA_COD_USU3() {
		return VFIRMA_COD_USU3;
	}
	public void setVFIRMA_COD_USU3(String vfirma_cod_usu3) {
		VFIRMA_COD_USU3 = vfirma_cod_usu3;
	}
	public String getVFIRMA_COD_USU4() {
		return VFIRMA_COD_USU4;
	}
	public void setVFIRMA_COD_USU4(String vfirma_cod_usu4) {
		VFIRMA_COD_USU4 = vfirma_cod_usu4;
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
	public String getDestino() {
		return destino;
	}
	public void setDestino(String destino) {
		this.destino = destino;
	}
	public String getCargo() {
		return cargo;
	}
	public void setCargo(String cargo) {
		this.cargo = cargo;
	}
	public String getDon() {
		return don;
	}
	public void setDon(String don) {
		this.don = don;
	}
	public String getGrado() {
		return grado;
	}
	public void setGrado(String grado) {
		this.grado = grado;
	} 
	
	

}
