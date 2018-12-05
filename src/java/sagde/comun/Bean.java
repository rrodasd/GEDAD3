package sagde.comun;

public abstract class Bean  implements java.io.Serializable{

public String getReferencia() {
	return getClass().getName();
}
}
    