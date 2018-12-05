/*
 *
 *
 *Creacion de la factoria DAO
 */
package comun;

/**
 *
 * Se definen Window - Preferences - Java - Code Style - Code Templates
 */
public abstract class DAOFactory {

    public static final int MYSQL = 1;
    public static final int ORACLE = 2;
    public static final int DB2 = 3;
    public static final int SQLSERVER = 4;
    public static final int XML = 5;

    public abstract RevisaDocumentoDAO getRevisaDocumentoDAO();
    public abstract DocumentoDAO getDocumentoDAO();
    //public abstract PDFDAO getPDFDAO();
    public abstract AdjuntarDocumentoDAO getAdjuntarDocumentoDAO();
    public abstract FormularDocumentoDAO getFormularDocumentoDAO();
    public abstract DecretarDocumentoDAO getDecretarDocumentoDAO();     
    public abstract UsuarioADDAO getUsuarioADDAO();
    public abstract OrganizacionInternaDAO getOrganizacionInternaDAO();
    public abstract ComboboxDAO getComboboxDAO();
    public abstract EncargaturaDAO getEncargaturaDAO();
    public abstract FirmarDocumentoDAO getFirmarDocumentoDAO();

    public static DAOFactory getDAOFactory(int whichFactory) {
        switch (whichFactory) {
            case MYSQL:
                return null;
            case ORACLE:
                //Retorna la Fatoria Oracle
                return new OracleDAOFactory();
            default:
                return null;
        }
    }

}
