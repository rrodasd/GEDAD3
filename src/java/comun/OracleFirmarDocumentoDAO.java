package comun;

import static comun.StringUtil.isEmpty;
import java.io.BufferedReader;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.SQLException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import oracle.jdbc.OracleTypes;
import oracle.sql.CLOB;
import sagde.bean.BeanAnexo;
import sagde.bean.BeanDistribucion;
import sagde.bean.BeanFirmarDocumento;



import sagde.comun.OracleDBConn;
import sagde.comun.Parametros;

public class OracleFirmarDocumentoDAO implements FirmarDocumentoDAO {
    
    BeanFirmarDocumento objBeanRD = null;
    BeanDistribucion objBeanDi = null;
    BeanAnexo objBeanAN = null;
    CallableStatement cs = null;
    Connection conn = null;
    ResultSet rst = null;
    Statement st = null;
    PreparedStatement pr = null;
    
    private Connection getConnection() {

        OracleDBConn cnx = new OracleDBConn();
        return cnx.getConnection();
    }

  
 /*
    1. *******************************************REVISAR DOCUMENTO **************************************************************************
    */   
  @Override
    public Collection ObtenerListaDocumentosXFirmar(String tipo,String codigoUsuario, String codigoOrganizacion) throws SQLException {
        
        /**
         * tipo A= Lista de todos los Documentos por Revisar
         */
        Collection xRevisar = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FIRMAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, tipo);
            cs.setString(3, codigoUsuario);
            cs.setString(4, codigoOrganizacion);
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute(); 
            rst = (ResultSet) cs.getObject(1);
            while (rst.next()) {
                objBeanRD = new BeanFirmarDocumento();
                objBeanRD.setCDOCUMENTO_PERIODO(rst.getString(1));
                objBeanRD.setCDOCUMENTO_COD_DOC_INT(rst.getString(2));
                objBeanRD.setCDOCUMENTO_CLASE(rst.getString(3));
                objBeanRD.setVCLASE_NOM_CORTO(rst.getString(4));              
                objBeanRD.setVDOCUMENTO_CLAVE_INDIC(rst.getString(5));
                objBeanRD.setVDOCUMENTO_ASUNTO(rst.getString(6));
                objBeanRD.setCHDOCUMENTO_SECUENCIA(rst.getString(7));
                objBeanRD.setVHDOCUMENTO_OBSERVACION(rst.getString(8));              
                objBeanRD.setVDOCUMENTO_USUARIO_REVISA(rst.getString(9));
                objBeanRD.setVHDOCUMENTO_COD_USU_ENV(rst.getString(10));
                objBeanRD.setDHDOCUMENTO_FECH_ESTADO(rst.getString(11));
                objBeanRD.setDESTINATARIO(rst.getString(12));                
                xRevisar.add(objBeanRD);            
             
                
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            rst.close();
            cs.close();
            conn.close();
        }
        return xRevisar;

    }
   /**
    @Override
    public BeanRevisarDocumento1 ObtenerNroDocXRevisar(String codigoUsuario,
            String codigoOrganizacion, String tipo) throws SQLException {
        
        objBeanRD = new BeanRevisarDocumento1();
        try {
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_GET_DOC_X_REVISAR(?,?,?); end;";
            String genericQuery = "{ call ? := SF_GET_DOC_X_REVISAR(?,?,?) }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, codigoUsuario);
            cs.setString(3, codigoOrganizacion);
            cs.setString(4, tipo);
            cs.execute();
            rst = (ResultSet) cs.getObject(1);
             if (rst.next()) {
                objBeanRD.setNroPendienteRev(rst.getString(1));
               
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        }finally{
            rst.close();
            cs.close();
            conn.close();
        }
        return objBeanRD;
    }
*/
      
    @Override
    public BeanFirmarDocumento obtenerDocXFirmar(String periodo, String codigoInternoDoc, String usuario) throws SQLException {
        
       
        objBeanRD = new BeanFirmarDocumento();
        try {
            conn = getConnection();
            String query = "begin ? := SF_FIRMAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "B");
            cs.setString(3, periodo);
            cs.setString(4, codigoInternoDoc);
            cs.setString(5, usuario);
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rst = (ResultSet) cs.getObject(1);
            if (rst.next()) {
                objBeanRD.setCDOCUMENTO_PERIODO(periodo);
                objBeanRD.setCDOCUMENTO_COD_DOC_INT(codigoInternoDoc);
                objBeanRD.setCDOCUMENTO_TIPO_ORG_ORIG(rst.getString(1));
                objBeanRD.setCDOCUMENTO_COD_ORG_ORIG(rst.getString(2));
                objBeanRD.setCDOCUMENTO_CLASE(rst.getString(3));
                objBeanRD.setVDOCUMENTO_CLAVE_INDIC(rst.getString(4));
                objBeanRD.setCDOCUMENTO_ARCHIVO_INDIC(rst.getString(5));
                objBeanRD.setCDOCUMENTO_CLASIFICACION(rst.getString(6));
                objBeanRD.setCDOCUMENTO_PRIORIDAD(rst.getString(7));
                objBeanRD.setDDOCUMENTO_FECHA(rst.getString(8));
                objBeanRD.setVDOCUMENTO_ASUNTO(rst.getString(9));
                objBeanRD.setCDOCUMENTO_ESTADO(rst.getString(10));
                objBeanRD.setVDOCUMENTO_USUARIO_ENV(rst.getString(11));
                objBeanRD.setCDOCUMENTO_COD_ORG_DEP(rst.getString(12));
                objBeanRD.setCDOCUMENTO_COD_ORG_NIV(rst.getString(13));
                objBeanRD.setVDOCUMENTO_GUARNICION(rst.getString(14));
                objBeanRD.setVDISTRIBUCION_GRADO(rst.getString(15));
                objBeanRD.setVDISTRIBUCION_APE_NOM(rst.getString(16));
                objBeanRD.setVDISTRIBUCION_CARGO(rst.getString(17));
                
                String cuerpoDocumento = "";
                //para cuerpo de documento
                CLOB cuerpo = (CLOB) rst.getClob(18);
                BufferedReader buffReader = new BufferedReader(cuerpo.getCharacterStream());
                String strData = " ";
                while ((strData = buffReader.readLine()) != null) {
                    cuerpoDocumento += strData;
                }
                objBeanRD.setLCDOCUMENTO_CUERPO_DOC(cuerpoDocumento);
                objBeanRD.setVHDOCUMENTO_OBSERVACION(rst.getString(19));               
                objBeanRD.setVFIRMA_APE_NOM(rst.getString(20));
                objBeanRD.setVFIRMA_GRADO(rst.getString(21));
                objBeanRD.setVFIRMA_CARGO(rst.getString(22));
                objBeanRD.setVFIRMA_COD_USUARIO(rst.getString(23));
                objBeanRD.setCUSUARIO_COD_ORG(rst.getString(24));
                objBeanRD.setCDISTRIBUCION_COD_ORG(rst.getString(25));
                objBeanRD.setNOMORGNIV(rst.getString(26));
                objBeanRD.setNOMORGDEP(rst.getString(27));
                objBeanRD.setNOMORGNIVCOR(rst.getString(28));
                objBeanRD.setNOMORGDEPCOR(rst.getString(29));
                 objBeanRD.setCHDOCUMENTO_SECUENCIA(rst.getString(30));
                
             
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } catch (IOException ex) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + ex.toString());
        } finally {
            rst.close();
            cs.close();
            conn.close();
        }
        return objBeanRD;
        
    }
    
    
     @Override
    public void EnviarRevisarDocumento(BeanFirmarDocumento beanrevisar, Collection referencias, Collection distribuciones) throws SQLException {

                   
        try {
            conn = getConnection();
            conn.setAutoCommit(false);
            cs = conn.prepareCall("{call SP_UPD_REVISAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            cs.setString(1, beanrevisar.getCDOCUMENTO_PERIODO());
            cs.setString(2, beanrevisar.getCDOCUMENTO_COD_DOC_INT());
            cs.setString(3, beanrevisar.getCDOCUMENTO_CLASE());
            cs.setString(4, beanrevisar.getCDOCUMENTO_CLASIFICACION());
            cs.setString(5, beanrevisar.getVDOCUMENTO_USUARIO_ENV());
            cs.setString(6, beanrevisar.getCHDOCUMENTO_SECUENCIA());
            cs.setString(7, beanrevisar.getVDOCUMENTO_GUARNICION());
            cs.setString(8, beanrevisar.getCDOCUMENTO_COD_ORG_DEP());
            cs.setString(9, beanrevisar.getVDOCUMENTO_CLAVE_INDIC());
            cs.setString(10, beanrevisar.getCDOCUMENTO_ARCHIVO_INDIC());
            cs.setString(11, beanrevisar.getVDOCUMENTO_ASUNTO());
            cs.setString(12, beanrevisar.getLCDOCUMENTO_CUERPO_DOC());
            cs.setString(13, beanrevisar.getCDOCUMENTO_PRIORIDAD());
            cs.setString(14, beanrevisar.getVDOCUMENTO_USUARIO_REVISA());
            cs.setString(15, beanrevisar.getVDOCUMENTO_USUARIO_FIRMA());
            cs.setString(16, beanrevisar.getVHDOCUMENTO_OBSERVACION());
            cs.setString(17, beanrevisar.getTipoAccion());
            cs.executeUpdate();
            cs.clearParameters();
            //Agregar distribucion
            
             Iterator iterator2 = distribuciones.iterator();
            int contador2 = 0;
            while (iterator2.hasNext()) {
                cs.clearParameters();
                objBeanDi = (BeanDistribucion) iterator2.next();
                cs = conn.prepareCall("{call SP_INS_DISTRIBUCION(?,?,?,?,?,?,?,?,?)}");
                cs.setString(1, beanrevisar.getCDOCUMENTO_PERIODO());
                cs.setString(2, beanrevisar.getCDOCUMENTO_COD_DOC_INT());
                cs.setString(3, objBeanDi.getTipoOrganizacion());
                cs.setString(4, objBeanDi.getCodigoOrganizacion());
                cs.setString(5, objBeanDi.getGrado());
                cs.setString(6, objBeanDi.getNombre());
                cs.setString(7, objBeanDi.getCargo());
                cs.setString(8, objBeanDi.getTipo());
                if (contador2 > 0) {
                    cs.setString(9, "N");
                } else {
                    cs.setString(9, "B");
                }
                contador2++;
                cs.execute();
            }
            
            
            conn.commit();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            conn.rollback();
            System.out.println(Parametros.S_APP_NOMBRE + " " + e.toString());
        } finally {
            conn.setAutoCommit(true);
            cs.close();
            conn.close();
        }

    }

    
    
    
/*
    2. ***************************************DISTRIBUCION *******************************************************************************
    */
    @Override
    public Collection FD_ObtenerDistribucion(String periodo, String codigoDocumentoInterno) throws SQLException {
        
        Collection c = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_DISTRIBUCION(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "A");
            cs.setString(3, periodo);
            cs.setString(4, codigoDocumentoInterno);
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rst = (ResultSet) cs.getObject(1);
            while (rst.next()) {
                objBeanDi = new BeanDistribucion();
                objBeanDi.setPeriodo(rst.getString(1));
                objBeanDi.setCodigoDocumento(rst.getString(2));
                objBeanDi.setTipoOrganizacion(rst.getString(3));
                objBeanDi.setCodigoOrganizacion(rst.getString(4));
                objBeanDi.setDescOrganizacion(rst.getString(5));
                objBeanDi.setTipo(rst.getString(6));
                objBeanDi.setCopias(rst.getInt(7));
                objBeanDi.setGrado(rst.getString(8));
                objBeanDi.setNombre(rst.getString(9));
                objBeanDi.setCargo(rst.getString(10));
                c.add(objBeanDi);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            rst.close();
            cs.close();
            conn.close();
        }
        return c;
        
    }
    
     @Override
    public BeanDistribucion AddDistribucion(String tiporganizacion, String organizacion) throws Exception {
        
        objBeanDi = new BeanDistribucion();
        try {
            conn = getConnection();
            String query = "begin ? := SF_DISTRIBUCION(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "B");
            cs.setString(3, tiporganizacion);
            cs.setString(4, organizacion);
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rst = (ResultSet) cs.getObject(1);
            if (rst.next()) {
                objBeanDi = new BeanDistribucion();
                objBeanDi.setTipoOrganizacion(tiporganizacion);
                objBeanDi.setCodigoOrganizacion(rst.getString(1));
                objBeanDi.setDescOrganizacion(rst.getString(2));
                objBeanDi.setGrado(rst.getString(3));
                objBeanDi.setNombre(rst.getString(4));
                objBeanDi.setCargo(rst.getString(5));
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            rst.close();
            cs.close();
            conn.close();
        }
        return objBeanDi;
        
    }

 @Override
    public boolean ExisteDistribucion(Collection c, BeanDistribucion bean) {
        
        Iterator iterator = c.iterator();
        while (iterator.hasNext()) {
            objBeanDi = (BeanDistribucion) iterator.next();
            if (objBeanDi.getCodigoOrganizacion().equals(bean.getCodigoOrganizacion())) {
                return true;
            }
        }
        return false;
        
    }

 /*
    3.******************************************ANEXOS*****************************************************************************
    */
    
    @Override
    public Collection obtenerFullAnexosXDocumento(String periodo, String cod_docinterno) throws Exception {
        System.out.println("periodo--"+periodo+"---cod_docinterno"+cod_docinterno+"--");
        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_ANEXOS(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "A");
            cs.setString(3, periodo);
            cs.setString(4, cod_docinterno);
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rst = (ResultSet) cs.getObject(1);
            while (rst.next()) {
                objBeanAN = new BeanAnexo();
                objBeanAN.setCANEXO_PERIODO(rst.getString(1));
                objBeanAN.setCANEXO_COD_DOC_INT(rst.getString(2));
                objBeanAN.setCANEXO_SECUENCIA(rst.getString(3));
                objBeanAN.setVANEXO_NOMBRE(rst.getString(4));
                objLista.add(objBeanAN);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally{
            rst.close();
            cs.close();
            conn.close();
        }
        return objLista;
        
    } 
    
    @Override
    public String generaSecAnexo(String codperiodo, String coddocint) throws Exception {
        
        String codigo = "";
        try {
            String sql = "SELECT LPAD(NVL(MAX(CANEXO_SECUENCIA),0)+1,5,'0') FROM SAGDE_ANEXOS where 	CANEXO_PERIODO=" + codperiodo + "AND CANEXO_COD_DOC_INT=" + coddocint;
            conn = getConnection();
            st = conn.createStatement();
            rst = st.executeQuery(sql);
            while (rst.next()) {
                codigo = rst.getString(1);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            rst.close();
            st.close();
            conn.close();
        }
        return codigo;
        
    }
    
    @Override
    public BeanAnexo obtenerAnexoSinBlob(BeanAnexo domain) throws SQLException{
        
        String sql = "SELECT VANEXO_TOKEN, VANEXO_NOMBRE "
                + "FROM SAGDE_ANEXOS "
                + "WHERE CANEXO_PERIODO = ? AND "
                + "CANEXO_COD_DOC_INT = ? AND "
                + "CANEXO_SECUENCIA = ? ";
        
        try{
            validarCoherenciaConsulta( domain );
            
            conn = getConnection();
            pr = conn.prepareStatement(sql);
            pr.setString(1, domain.getCANEXO_PERIODO());
            pr.setString(2, domain.getCANEXO_COD_DOC_INT());
            pr.setString(3, domain.getCANEXO_SECUENCIA());
            rst = pr.executeQuery();
            rst.next();
            
            return BeanAnexo.parseToBeanAnexo(rst);
            
        }catch(Exception e){
            throw new SQLException( e.getMessage() );
        }
        
    }
    
    private void validarCoherenciaConsulta( BeanAnexo domain ) throws Exception{
        if( isEmpty(domain.getCANEXO_PERIODO()) ){
            throw new Exception("PERDIODO NO PUEDE SER NULO");
        }
        
        if( isEmpty(domain.getCANEXO_COD_DOC_INT()) ){
            throw new Exception("DOCUMENTO INTERNO NO PUEDE SER NULO");
        }
        
        if( isEmpty(domain.getCANEXO_SECUENCIA()) ){
            throw new Exception("SECUENCIA NO PUEDE SER NULO");
        }
    }
    
    
   
    @Override
    public String obtenerNroUnicoDoc(String codperiodo, String clase) throws SQLException {
        
        
        
        String NroUnicoDoc = "";
       
        
        try {
           
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_OBTENER_NRO_UNICO(?,?); end;";
            String genericQuery = "{ call ? := SF_OBTENER_NRO_UNICO(?,?) }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            conn.setAutoCommit(false);
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.VARCHAR);            
            cs.setString(2, codperiodo);
            cs.setString(3, clase);           
            cs.executeUpdate();
            NroUnicoDoc = (String) cs.getObject(1);
            cs.clearParameters();
            
           
        
        conn.commit();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            conn.rollback();
            System.out.println(Parametros.S_APP_NOMBRE + " " + e.toString());
        } finally {
            conn.setAutoCommit(true);
            cs.close();
            conn.close();
        }
        return NroUnicoDoc;
        
    }
   
    
}