package sagde.bean;
import comun.ResultSetUtil;
import comun.StringUtil;
import java.io.*;
import java.sql.Blob;
import java.sql.ResultSet;

import sagde.comun.Bean;

public class BeanAnexo extends Bean{
	
	private String CANEXO_PERIODO;
	private String CANEXO_COD_DOC_INT;
	private String CANEXO_SECUENCIA;
	
	private InputStream  BANEXO_IMAGEN_ARCHIVO;//campo de la imagen 
	
	private String VANEXO_NOMBRE;
        
        private String VANEXO_TOKEN;
	
	
	
	
	public String getVANEXO_NOMBRE() {
		return VANEXO_NOMBRE;
	}
	public void setVANEXO_NOMBRE(String vanexo_nombre) {
		VANEXO_NOMBRE = vanexo_nombre;
	}
	public String getCANEXO_COD_DOC_INT() {
		return CANEXO_COD_DOC_INT;
	}
	public void setCANEXO_COD_DOC_INT(String canexo_cod_doc_int) {
		CANEXO_COD_DOC_INT = canexo_cod_doc_int;
	}
	public String getCANEXO_PERIODO() {
		return CANEXO_PERIODO;
	}
	public void setCANEXO_PERIODO(String canexo_periodo) {
		CANEXO_PERIODO = canexo_periodo;
	}
	public String getCANEXO_SECUENCIA() {
		return CANEXO_SECUENCIA;
	}
	public void setCANEXO_SECUENCIA(String canexo_secuencia) {
		CANEXO_SECUENCIA = canexo_secuencia;
	}
	public InputStream getBANEXO_IMAGEN_ARCHIVO() {
		return BANEXO_IMAGEN_ARCHIVO;
	}
	public void setBANEXO_IMAGEN_ARCHIVO(InputStream banexo_imagen_archivo) {
		BANEXO_IMAGEN_ARCHIVO = banexo_imagen_archivo;
	}
	
	
	/**
         * Métodos de tratamiento de ResultSet
         */
        
        
        /**
         * Permite convertir un resultSet a un objeto de tipo BeanAnexo
         * @param rs
         * @return 
         */
        public static BeanAnexo parseToBeanAnexo( ResultSet rs ){
            if( StringUtil.isEmpty(rs) ){
                return null;
            }
            
            ResultSetUtil rsu = new ResultSetUtil( rs );
            BeanAnexo ba = new BeanAnexo();
            
            ba.setVANEXO_TOKEN( rsu.getStr("VANEXO_TOKEN", null) );
            ba.setVANEXO_NOMBRE( rsu.getStr("VANEXO_NOMBRE", null) );
            
            return ba;
        }

    /**
     * @return the VANEXO_TOKEN
     */
    public String getVANEXO_TOKEN() {
        return VANEXO_TOKEN;
    }

    /**
     * @param VANEXO_TOKEN the VANEXO_TOKEN to set
     */
    public void setVANEXO_TOKEN(String VANEXO_TOKEN) {
        this.VANEXO_TOKEN = VANEXO_TOKEN;
    }
	

}
