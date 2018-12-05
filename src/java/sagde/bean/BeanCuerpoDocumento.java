package sagde.bean;

import oracle.sql.CLOB;
import sagde.comun.Bean;

public class BeanCuerpoDocumento extends Bean{
	
	private String CCDOCUMENTO_PERIODO;
	private String CCDOCUMENTO_COD_DOC_INT;
	private String LCDOCUMENTO_CUERPO_DOC;
	
	private Object LCDOCUMENTO_CUERPO_DOC10;
	
	private CLOB LCDOCUMENTO_CUERPO_DOC12;
	private String tipo;
	
	
	public String getCCDOCUMENTO_COD_DOC_INT() {
		return CCDOCUMENTO_COD_DOC_INT;
	}
	public void setCCDOCUMENTO_COD_DOC_INT(String ccdocumento_cod_doc_int) {
		CCDOCUMENTO_COD_DOC_INT = ccdocumento_cod_doc_int;
	}
	public String getCCDOCUMENTO_PERIODO() {
		return CCDOCUMENTO_PERIODO;
	}
	public void setCCDOCUMENTO_PERIODO(String ccdocumento_periodo) {
		CCDOCUMENTO_PERIODO = ccdocumento_periodo;
	}
	public String getLCDOCUMENTO_CUERPO_DOC() {
		return LCDOCUMENTO_CUERPO_DOC;
	}
	public void setLCDOCUMENTO_CUERPO_DOC(String lcdocumento_cuerpo_doc) {
		LCDOCUMENTO_CUERPO_DOC = lcdocumento_cuerpo_doc;
	}
	public Object getLCDOCUMENTO_CUERPO_DOC10() {
		return LCDOCUMENTO_CUERPO_DOC10;
	}
	public void setLCDOCUMENTO_CUERPO_DOC10(Object lcdocumento_cuerpo_doc10) {
		LCDOCUMENTO_CUERPO_DOC10 = lcdocumento_cuerpo_doc10;
	}
	public CLOB getLCDOCUMENTO_CUERPO_DOC12() {
		return LCDOCUMENTO_CUERPO_DOC12;
	}
	public void setLCDOCUMENTO_CUERPO_DOC12(CLOB lcdocumento_cuerpo_doc12) {
		LCDOCUMENTO_CUERPO_DOC12 = lcdocumento_cuerpo_doc12;
	}
	public String getTipo() {
		return tipo;
	}
	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

}
