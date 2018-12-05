package comun;

public class OracleDAOFactory extends DAOFactory {

    //Definicion de interfaces
    @Override
    public RevisaDocumentoDAO getRevisaDocumentoDAO() {
        // TODO Auto-generated method stub
        return new OracleRevisaDocumentoDAO();
    }

    //--------------------------------------------MODULO REGISTRO DE DOCUMENTO --------------------------------------------------------//
    @Override
    public DocumentoDAO getDocumentoDAO() {
        // TODO Auto-generated method stub
        return new OracleDocumentoDAO();
    }

    //--------------------------------------------MODULO FORMULAR DE DOCUMENTO --------------------------------------------------------//
    @Override
    public FormularDocumentoDAO getFormularDocumentoDAO() {
        // TODO Auto-generated method stub
        return new OracleFormularDocumentoDAO();
    }

    @Override
    public DecretarDocumentoDAO getDecretarDocumentoDAO() {
        return new OracleDecretarDocumentoDAO();
    }

    //--------------------------------------------MODULO MANTENIMIENTO --------------------------------------------------------// 
    @Override
    public UsuarioADDAO getUsuarioADDAO() {
        return new OracleUsuarioADDAO();
    }

    @Override
    public EncargaturaDAO getEncargaturaDAO() {
        return new OracleEncargaturaDAO();
    }

    @Override
    public OrganizacionInternaDAO getOrganizacionInternaDAO() {
        return new OracleOrganizacionInternaDAO();
    }

    @Override
    public ComboboxDAO getComboboxDAO() {
        return new OracleComboboxDAO();
    }

    @Override
    public AdjuntarDocumentoDAO getAdjuntarDocumentoDAO() {
        return new OracleAdjuntarDocumentoDAO();

    }

    //--------------------------------------------MODULO FIRMAR DOCUMENTO --------------------------------------------------------// 
    @Override
    public FirmarDocumentoDAO getFirmarDocumentoDAO() {
        return new OracleFirmarDocumentoDAO();
    }

}
