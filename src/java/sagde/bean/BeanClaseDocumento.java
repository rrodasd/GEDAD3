package sagde.bean;

import sagde.comun.Bean;

public class BeanClaseDocumento extends Bean{
	
	private String codigo;
	private String nombreClase;
	private int numeroClase;
	private String rutaArchivo;
	
	
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getNombreClase() {
		return nombreClase;
	}
	public void setNombreClase(String nombreClase) {
		this.nombreClase = nombreClase;
	}
	public int getNumeroClase() {
		return numeroClase;
	}
	public void setNumeroClase(int numeroClase) {
		this.numeroClase = numeroClase;
	}
	public String getRutaArchivo() {
		return rutaArchivo;
	}
	public void setRutaArchivo(String rutaArchivo) {
		this.rutaArchivo = rutaArchivo;
	}
	

}
