package sagde.bean;

import java.io.File;
import java.io.InputStream;

import sagde.comun.Bean;

public class BeanRegistroDocumento extends Bean {

    /**
     * @return the CDOCUMENTO_PERIODO_ORIG
     */
    public String getCDOCUMENTO_PERIODO_ORIG() {
        return CDOCUMENTO_PERIODO_ORIG;
    }

    /**
     * @param CDOCUMENTO_PERIODO_ORIG the CDOCUMENTO_PERIODO_ORIG to set
     */
    public void setCDOCUMENTO_PERIODO_ORIG(String CDOCUMENTO_PERIODO_ORIG) {
        this.CDOCUMENTO_PERIODO_ORIG = CDOCUMENTO_PERIODO_ORIG;
    }

    /**
     * @return the CDOCUMENTO_COD_DOC_INT_ORIG
     */
    public String getCDOCUMENTO_COD_DOC_INT_ORIG() {
        return CDOCUMENTO_COD_DOC_INT_ORIG;
    }

    /**
     * @param CDOCUMENTO_COD_DOC_INT_ORIG the CDOCUMENTO_COD_DOC_INT_ORIG to set
     */
    public void setCDOCUMENTO_COD_DOC_INT_ORIG(String CDOCUMENTO_COD_DOC_INT_ORIG) {
        this.CDOCUMENTO_COD_DOC_INT_ORIG = CDOCUMENTO_COD_DOC_INT_ORIG;
    }
	private String CDOCUMENTO_PERIODO;
	private String CDOCUMENTO_COD_DOC_INT;
	private String CDOCUMENTO_TIPO_ORG_ORIG;
	private String CDOCUMENTO_COD_ORG_ORIG;
	private String CDOCUMENTO_CLASE;
	private String CDOCUMENTO_NRO_ORDEN;
	private String VDOCUMENTO_CLAVE_INDIC;
	private String CDOCUMENTO_ARCHIVO_INDIC;
	private String CDOCUMENTO_CLASIFICACION;
	private String CDOCUMENTO_PRIORIDAD;
	private String DDOCUMENTO_FECHA;
	private String VDOCUMENTO_ASUNTO;
	private String CDOCUMENTO_ESTADO;
	private String VDOCUMENTO_USUARIO;
	private String CDOCUMENTO_COD_ORG_DEP;
	private String CDOCUMENTO_COD_ORG_NIV;
	private String VDOCUMENTO_GUARNICION;
	private InputStream BDISTRIBUCION_IMAGEN_DOC;
	
	private String VDISTRIBUCION_NOM_FILE;
	
	private File BDIS_IMG_DOC_FILE;
	
	private String DDOCUMENTO_FEC_ACT;
	
	
	//referencia a sagde_clase
	private String CCLASE_CODIGO;
	//referencia a sagde_archivo
	private String CARCHIVO_CODIGO;
	//referencia a sagde_clasificacion
	private String CCLASIF_CODIGO;
    //referencia a sagde_prioridad
	private String CPRIORIDAD_CODIGO;
	//referencia a codigo de la Organizacion (Org. Interna, Entidad Externa)
	private String COD_ORG;
	// referencia del Codigo de la Organizacion Interna del Usuario Logeado
	private String COD_ORG_USUARIO;	
	
	private String VANEXO_NOMBRE;	
	private String CARGO;	
	
	private String CDISTRIBUCION_COD_ORG;
        private String codigo;
	private String nombre ;
	
        
        private String CDOCUMENTO_PERIODO_ORIG;
	private String CDOCUMENTO_COD_DOC_INT_ORIG;
        
         private String JEFE_UNIDAD;
        
	private String VOINTERNA_USU_JEFE;
        private String CDISTRIBUCION_TIPO_DISTRIB;
        
        
        
        
        
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
        
	public String getCOD_ORG_USUARIO() {
		return COD_ORG_USUARIO;
	}
	public void setCOD_ORG_USUARIO(String cod_org_usuario) {
		COD_ORG_USUARIO = cod_org_usuario;
	}
	public String getCDOCUMENTO_ARCHIVO_INDIC() {
		return CDOCUMENTO_ARCHIVO_INDIC;
	}
	public void setCDOCUMENTO_ARCHIVO_INDIC(String cdocumento_archivo_indic) {
		CDOCUMENTO_ARCHIVO_INDIC = cdocumento_archivo_indic;
	}
	public String getCDOCUMENTO_CLASE() {
		return CDOCUMENTO_CLASE;
	}
	public void setCDOCUMENTO_CLASE(String cdocumento_clase) {
		CDOCUMENTO_CLASE = cdocumento_clase;
	}
	public String getCDOCUMENTO_CLASIFICACION() {
		return CDOCUMENTO_CLASIFICACION;
	}
	public void setCDOCUMENTO_CLASIFICACION(String cdocumento_clasificacion) {
		CDOCUMENTO_CLASIFICACION = cdocumento_clasificacion;
	}
	public String getCDOCUMENTO_COD_DOC_INT() {
		return CDOCUMENTO_COD_DOC_INT;
	}
	public void setCDOCUMENTO_COD_DOC_INT(String cdocumento_cod_doc_int) {
		CDOCUMENTO_COD_DOC_INT = cdocumento_cod_doc_int;
	}
	public String getCDOCUMENTO_COD_ORG_DEP() {
		return CDOCUMENTO_COD_ORG_DEP;
	}
	public void setCDOCUMENTO_COD_ORG_DEP(String cdocumento_cod_org_dep) {
		CDOCUMENTO_COD_ORG_DEP = cdocumento_cod_org_dep;
	}
	public String getCDOCUMENTO_COD_ORG_NIV() {
		return CDOCUMENTO_COD_ORG_NIV;
	}
	public void setCDOCUMENTO_COD_ORG_NIV(String cdocumento_cod_org_niv) {
		CDOCUMENTO_COD_ORG_NIV = cdocumento_cod_org_niv;
	}
	public String getCDOCUMENTO_COD_ORG_ORIG() {
		return CDOCUMENTO_COD_ORG_ORIG;
	}
	public void setCDOCUMENTO_COD_ORG_ORIG(String cdocumento_cod_org_orig) {
		CDOCUMENTO_COD_ORG_ORIG = cdocumento_cod_org_orig;
	}
	public String getCDOCUMENTO_ESTADO() {
		return CDOCUMENTO_ESTADO;
	}
	public void setCDOCUMENTO_ESTADO(String cdocumento_estado) {
		CDOCUMENTO_ESTADO = cdocumento_estado;
	}
	public String getCDOCUMENTO_NRO_ORDEN() {
		return CDOCUMENTO_NRO_ORDEN;
	}
	public void setCDOCUMENTO_NRO_ORDEN(String cdocumento_nro_orden) {
		CDOCUMENTO_NRO_ORDEN = cdocumento_nro_orden;
	}
	public String getCDOCUMENTO_PERIODO() {
		return CDOCUMENTO_PERIODO;
	}
	public void setCDOCUMENTO_PERIODO(String cdocumento_periodo) {
		CDOCUMENTO_PERIODO = cdocumento_periodo;
	}
	public String getCDOCUMENTO_PRIORIDAD() {
		return CDOCUMENTO_PRIORIDAD;
	}
	public void setCDOCUMENTO_PRIORIDAD(String cdocumento_prioridad) {
		CDOCUMENTO_PRIORIDAD = cdocumento_prioridad;
	}
	public String getCDOCUMENTO_TIPO_ORG_ORIG() {
		return CDOCUMENTO_TIPO_ORG_ORIG;
	}
	public void setCDOCUMENTO_TIPO_ORG_ORIG(String cdocumento_tipo_org_orig) {
		CDOCUMENTO_TIPO_ORG_ORIG = cdocumento_tipo_org_orig;
	}
	public String getDDOCUMENTO_FECHA() {
		return DDOCUMENTO_FECHA;
	}
	public void setDDOCUMENTO_FECHA(String ddocumento_fecha) {
		DDOCUMENTO_FECHA = ddocumento_fecha;
	}
	public String getVDOCUMENTO_ASUNTO() {
		return VDOCUMENTO_ASUNTO;
	}
	public void setVDOCUMENTO_ASUNTO(String vdocumento_asunto) {
		VDOCUMENTO_ASUNTO = vdocumento_asunto;
	}
	public String getVDOCUMENTO_CLAVE_INDIC() {
		return VDOCUMENTO_CLAVE_INDIC;
	}
	public void setVDOCUMENTO_CLAVE_INDIC(String vdocumento_clave_indic) {
		VDOCUMENTO_CLAVE_INDIC = vdocumento_clave_indic;
	}
	public String getVDOCUMENTO_GUARNICION() {
		return VDOCUMENTO_GUARNICION;
	}
	public void setVDOCUMENTO_GUARNICION(String vdocumento_guarnicion) {
		VDOCUMENTO_GUARNICION = vdocumento_guarnicion;
	}
	public String getVDOCUMENTO_USUARIO() {
		return VDOCUMENTO_USUARIO;
	}
	public void setVDOCUMENTO_USUARIO(String vdocumento_usuario) {
		VDOCUMENTO_USUARIO = vdocumento_usuario;
	}
	public String getCCLASE_CODIGO() {
		return CCLASE_CODIGO;
	}
	public void setCCLASE_CODIGO(String cclase_codigo) {
		CCLASE_CODIGO = cclase_codigo;
	}
	public String getCARCHIVO_CODIGO() {
		return CARCHIVO_CODIGO;
	}
	public void setCARCHIVO_CODIGO(String carchivo_codigo) {
		CARCHIVO_CODIGO = carchivo_codigo;
	}
	public String getCCLASIF_CODIGO() {
		return CCLASIF_CODIGO;
	}
	public void setCCLASIF_CODIGO(String cclasif_codigo) {
		CCLASIF_CODIGO = cclasif_codigo;
	}
	public String getCPRIORIDAD_CODIGO() {
		return CPRIORIDAD_CODIGO;
	}
	public void setCPRIORIDAD_CODIGO(String cprioridad_codigo) {
		CPRIORIDAD_CODIGO = cprioridad_codigo;
	}
	public String getCOD_ORG() {
		return COD_ORG;
	}
	public void setCOD_ORG(String cod_org) {
		COD_ORG = cod_org;
	}
	public InputStream getBDISTRIBUCION_IMAGEN_DOC() {
		return BDISTRIBUCION_IMAGEN_DOC;
	}
	public void setBDISTRIBUCION_IMAGEN_DOC(InputStream bdistribucion_imagen_doc) {
		BDISTRIBUCION_IMAGEN_DOC = bdistribucion_imagen_doc;
	}
	public File getBDIS_IMG_DOC_FILE() {
		return BDIS_IMG_DOC_FILE;
	}
	public void setBDIS_IMG_DOC_FILE(File bdis_img_doc_file) {
		BDIS_IMG_DOC_FILE = bdis_img_doc_file;
	}
	public String getVDISTRIBUCION_NOM_FILE() {
		return VDISTRIBUCION_NOM_FILE;
	}
	public void setVDISTRIBUCION_NOM_FILE(String vdistribucion_nom_file) {
		VDISTRIBUCION_NOM_FILE = vdistribucion_nom_file;
	}
	public String getDDOCUMENTO_FEC_ACT() {
		return DDOCUMENTO_FEC_ACT;
	}
	public void setDDOCUMENTO_FEC_ACT(String ddocumento_fec_act) {
		DDOCUMENTO_FEC_ACT = ddocumento_fec_act;
	}
	public String getVANEXO_NOMBRE() {
		return VANEXO_NOMBRE;
	}
	public void setVANEXO_NOMBRE(String vanexo_nombre) {
		VANEXO_NOMBRE = vanexo_nombre;
	}
	public String getCARGO() {
		return CARGO;
	}
	public void setCARGO(String cargo) {
		CARGO = cargo;
	}
	public String getCDISTRIBUCION_COD_ORG() {
		return CDISTRIBUCION_COD_ORG;
	}
	public void setCDISTRIBUCION_COD_ORG(String cdistribucion_cod_org) {
		CDISTRIBUCION_COD_ORG = cdistribucion_cod_org;
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

    /**
     * @return the VOINTERNA_USU_JEFE
     */
    public String getVOINTERNA_USU_JEFE() {
        return VOINTERNA_USU_JEFE;
    }

    /**
     * @param VOINTERNA_USU_JEFE the VOINTERNA_USU_JEFE to set
     */
    public void setVOINTERNA_USU_JEFE(String VOINTERNA_USU_JEFE) {
        this.VOINTERNA_USU_JEFE = VOINTERNA_USU_JEFE;
    }

    /**
     * @return the CDISTRIBUCION_TIPO_DISTRIB
     */
    public String getCDISTRIBUCION_TIPO_DISTRIB() {
        return CDISTRIBUCION_TIPO_DISTRIB;
    }

    /**
     * @param CDISTRIBUCION_TIPO_DISTRIB the CDISTRIBUCION_TIPO_DISTRIB to set
     */
    public void setCDISTRIBUCION_TIPO_DISTRIB(String CDISTRIBUCION_TIPO_DISTRIB) {
        this.CDISTRIBUCION_TIPO_DISTRIB = CDISTRIBUCION_TIPO_DISTRIB;
    }

}
