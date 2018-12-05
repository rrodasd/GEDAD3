package sagde.bean;

import sagde.comun.Bean;

public class BeanHistorialDocumento extends Bean{
	
	private String CHDOCUMENTO_PERIODO;                  
	private String CHDOCUMENTO_COD_DOC_INT;                 
	private String CHDOCUMENTO_SECUENCIA;                   
	private String CHDOCUMENTO_COD_ESTADO;                 
	private String DHDOCUMENTO_FECH_ESTADO;                  
	private String VHDOCUMENTO_COD_USUARIO;                  
	private String CHDOCUMENTO_TIPO_ACCION;                 
	private String VHDOCUMENTO_OBERVACION;
	
	public String getCHDOCUMENTO_COD_DOC_INT() {
		return CHDOCUMENTO_COD_DOC_INT;
	}
	public void setCHDOCUMENTO_COD_DOC_INT(String chdocumento_cod_doc_int) {
		CHDOCUMENTO_COD_DOC_INT = chdocumento_cod_doc_int;
	}
	public String getCHDOCUMENTO_COD_ESTADO() {
		return CHDOCUMENTO_COD_ESTADO;
	}
	public void setCHDOCUMENTO_COD_ESTADO(String chdocumento_cod_estado) {
		CHDOCUMENTO_COD_ESTADO = chdocumento_cod_estado;
	}
	public String getCHDOCUMENTO_PERIODO() {
		return CHDOCUMENTO_PERIODO;
	}
	public void setCHDOCUMENTO_PERIODO(String chdocumento_periodo) {
		CHDOCUMENTO_PERIODO = chdocumento_periodo;
	}
	public String getCHDOCUMENTO_SECUENCIA() {
		return CHDOCUMENTO_SECUENCIA;
	}
	public void setCHDOCUMENTO_SECUENCIA(String chdocumento_secuencia) {
		CHDOCUMENTO_SECUENCIA = chdocumento_secuencia;
	}
	public String getCHDOCUMENTO_TIPO_ACCION() {
		return CHDOCUMENTO_TIPO_ACCION;
	}
	public void setCHDOCUMENTO_TIPO_ACCION(String chdocumento_tipo_accion) {
		CHDOCUMENTO_TIPO_ACCION = chdocumento_tipo_accion;
	}
	public String getDHDOCUMENTO_FECH_ESTADO() {
		return DHDOCUMENTO_FECH_ESTADO;
	}
	public void setDHDOCUMENTO_FECH_ESTADO(String dhdocumento_fech_estado) {
		DHDOCUMENTO_FECH_ESTADO = dhdocumento_fech_estado;
	}
	public String getVHDOCUMENTO_COD_USUARIO() {
		return VHDOCUMENTO_COD_USUARIO;
	}
	public void setVHDOCUMENTO_COD_USUARIO(String vhdocumento_cod_usuario) {
		VHDOCUMENTO_COD_USUARIO = vhdocumento_cod_usuario;
	}
	public String getVHDOCUMENTO_OBERVACION() {
		return VHDOCUMENTO_OBERVACION;
	}
	public void setVHDOCUMENTO_OBERVACION(String vhdocumento_obervacion) {
		VHDOCUMENTO_OBERVACION = vhdocumento_obervacion;
	}                          

	
	
	

}
