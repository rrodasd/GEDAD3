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
import sagde.bean.BeanReferencia;
import sagde.bean.BeanRevisarDocumento;

import sagde.comun.OracleDBConn;
import sagde.comun.Parametros;

public class OracleRevisaDocumentoDAO implements RevisaDocumentoDAO {

    BeanRevisarDocumento objBeanRD = null;
    BeanDistribucion objBeanDi = null;
    BeanAnexo objBeanAN = null;
    CallableStatement cs = null;
    Connection conn = null;
    ResultSet rst = null;
    Statement st = null;
    PreparedStatement pr = null;
    BeanReferencia objBeanRef = null;

    private Connection getConnection() {

        OracleDBConn cnx = new OracleDBConn();
        return cnx.getConnection();
    }

    /*
    1. *******************************************REVISAR DOCUMENTO **************************************************************************
     */
    @Override
    public Collection ObtenerListaDocumentosXRevisar(String tipo, String codigoUsuario, String codigoOrganizacion) throws SQLException {

        /**
         * tipo A= Lista de todos los Documentos por Revisar
         */
        Collection xRevisar = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_REVISAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
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
                objBeanRD = new BeanRevisarDocumento();
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
                objBeanRD.setVHDOCUMENTO_COD_USU_REC(rst.getString(13));

                xRevisar.add(objBeanRD);

            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rst.close();
            cs.close();
            conn.close();
        }
        return xRevisar;

    }

    @Override
    public BeanRevisarDocumento obtenerCantidadPendientes(String tipo,
            String codigoUsuario, String subtipo) throws SQLException {
        //System.out.println("ingreso al oracle" + tipo + codigoUsuario + subtipo);
        objBeanRD = new BeanRevisarDocumento();
        try {
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_REVISAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            String genericQuery = "{ call ? := SF_REVISAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?) }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, tipo);
            cs.setString(3, codigoUsuario);
            cs.setString(4, subtipo);
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
                //System.out.println("NROO" + rst.getString(1));
                objBeanRD.setNroPendientes(rst.getString(1));

            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rst.close();
            cs.close();
            conn.close();
        }
        return objBeanRD;
    }

    @Override
    public BeanRevisarDocumento obtenerDocXRevisar(String periodo, String codigoInternoDoc, String usuario) throws SQLException {

        objBeanRD = new BeanRevisarDocumento();
        try {
            conn = getConnection();
            String query = "begin ? := SF_REVISAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
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
                objBeanRD.setUSUARIO_ENVIO_ANTERIOR(rst.getString(31));

            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } catch (IOException ex) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + ex.toString());
        } finally {
            rst.close();
            cs.close();
            conn.close();
        }
        return objBeanRD;

    }

    @Override
    public void EnviarRevisarDocumento(BeanRevisarDocumento beanrevisar, Collection referencias, Collection distribuciones) throws SQLException {

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
            /*
            //Agregar DISTRIBUCION
            if (referencias != null) {
                Iterator iterator = referencias.iterator();
                 int contador = 0;
                while (iterator.hasNext()) {
                    cs.clearParameters();
                    objBeanRef = (BeanReferencia) iterator.next();
                    cs = conn.prepareCall("{call SP_INS_REFERENCIA(?,?,?,?,?,?,?)}");
                    cs.setString(1, objBeanRef.getCREFERENCIA_PERIODO_ORIG());
                    cs.setString(2, objBeanRef.getCREFERENCIA_COD_DOC_ORIG());
                    cs.setString(3, objBeanRef.getCREFERENCIA_PERIODO_REF());
                    cs.setString(4, objBeanRef.getCREFERENCIA_COD_DOC_REF());
                    if (contador > 0) {
                        cs.setString(5, "N");
                    } else {
                        cs.setString(5, "B");
                    }
                    
                    cs.setString(6, "");
                    cs.setString(7, "R");
                     contador++;
                    cs.execute();
                }
            }
             */
            //Agregar distribucion    
           

            Iterator iterator2 = distribuciones.iterator();
           
            int contador2 = 0;
            while (iterator2.hasNext()) {
                cs.clearParameters();
                objBeanDi = (BeanDistribucion) iterator2.next();
                cs = conn.prepareCall("{call SP_INS_DISTRIBUCION(?,?,?,?,?,?,?,?,?,?)}");
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
                cs.setString(10, "");
              
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

    public String FirmaDigitalDocumento(BeanRevisarDocumento beanrevisar, Collection referencias, Collection distribuciones) throws SQLException {

        String NumeroDocXClase = "";

        try {

            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_FIRMA_DIGITAL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?); end;";
            String genericQuery = "{ call ? := SF_FIRMA_DIGITAL(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            conn.setAutoCommit(false);
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.VARCHAR);
            cs.setString(2, beanrevisar.getCDOCUMENTO_PERIODO());
            cs.setString(3, beanrevisar.getCDOCUMENTO_COD_DOC_INT());
            cs.setString(4, beanrevisar.getCDOCUMENTO_CLASE());
            cs.setString(5, beanrevisar.getCDOCUMENTO_CLASIFICACION());
            cs.setString(6, beanrevisar.getVDOCUMENTO_USUARIO_ENV());
            cs.setString(7, beanrevisar.getCHDOCUMENTO_SECUENCIA());
            cs.setString(8, beanrevisar.getVDOCUMENTO_GUARNICION());
            cs.setString(9, beanrevisar.getCDOCUMENTO_COD_ORG_DEP());
            cs.setString(10, beanrevisar.getVDOCUMENTO_CLAVE_INDIC());
            cs.setString(11, beanrevisar.getCDOCUMENTO_ARCHIVO_INDIC());
            cs.setString(12, beanrevisar.getVDOCUMENTO_ASUNTO());
            cs.setString(13, beanrevisar.getLCDOCUMENTO_CUERPO_DOC());
            cs.setString(14, beanrevisar.getCDOCUMENTO_PRIORIDAD());
            cs.setString(15, beanrevisar.getVDOCUMENTO_USUARIO_REVISA());
            cs.setString(16, beanrevisar.getVDOCUMENTO_USUARIO_FIRMA());
            cs.setString(17, beanrevisar.getVHDOCUMENTO_OBSERVACION());
            cs.setString(18, beanrevisar.getTipoAccion());
            cs.setString(19, beanrevisar.getNroUnicoOF());
            cs.executeUpdate();
            NumeroDocXClase = (String) cs.getObject(1);
            cs.clearParameters();
            //Agregar distribucion

            Iterator iterator2 = distribuciones.iterator();
            int contador2 = 0;
            while (iterator2.hasNext()) {
                cs.clearParameters();
                objBeanDi = (BeanDistribucion) iterator2.next();
                cs = conn.prepareCall("{call SP_INS_DISTRIBUCION(?,?,?,?,?,?,?,?,?,?)}");
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

                cs.setString(10, beanrevisar.getTokenOFicio());
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

        return NumeroDocXClase;
    }

    /*
    2. ***************************************DISTRIBUCION *******************************************************************************
     */
    @Override
    public Collection RD_ObtenerDistribucion(String periodo, String codigoDocumentoInterno) throws SQLException {

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
                objBeanDi.setGrado(rst.getString(7));
                objBeanDi.setNombre(rst.getString(8));
                objBeanDi.setCargo(rst.getString(9));
                c.add(objBeanDi);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
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
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
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
                objBeanAN.setVANEXO_TOKEN(rst.getString(5));
                objLista.add(objBeanAN);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
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
            String sql = "SELECT LPAD(NVL(MAX(CANEXO_SECUENCIA),0)+1,5,'0') FROM SAGDE_ANEXOS where CANEXO_PERIODO=" + codperiodo + "AND CANEXO_COD_DOC_INT=" + coddocint;
            conn = getConnection();
            st = conn.createStatement();
            rst = st.executeQuery(sql);
            while (rst.next()) {
                codigo = rst.getString(1);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rst.close();
            st.close();
            conn.close();
        }
        return codigo;

    }

    @Override
    public BeanAnexo obtenerAnexoSinBlob(BeanAnexo domain) throws SQLException {

        String sql = "SELECT VANEXO_TOKEN, VANEXO_NOMBRE "
                + "FROM SAGDE_ANEXOS "
                + "WHERE CANEXO_PERIODO = ? AND "
                + "CANEXO_COD_DOC_INT = ? AND "
                + "CANEXO_SECUENCIA = ? ";

        try {
            validarCoherenciaConsulta(domain);

            conn = getConnection();
            pr = conn.prepareStatement(sql);
            pr.setString(1, domain.getCANEXO_PERIODO());
            pr.setString(2, domain.getCANEXO_COD_DOC_INT());
            pr.setString(3, domain.getCANEXO_SECUENCIA());
            rst = pr.executeQuery();
            rst.next();

            return BeanAnexo.parseToBeanAnexo(rst);

        } catch (Exception e) {
            throw new SQLException(e.getMessage());
        }

    }

    public BeanReferencia obtenerReferenciaSinBlob(BeanReferencia domain) throws SQLException {

        String sql = "SELECT VDISTRIBUCION_TOKEN "
                + "FROM SAGDE_DISTRIBUCION "
                + "WHERE CDISTRIBUCION_PERIODO = ? AND "
                + "CDISTRIBUCION_COD_DOC_INT = ?  ";

        try {

            conn = getConnection();
            pr = conn.prepareStatement(sql);
            pr.setString(1, domain.getCREFERENCIA_PERIODO_REF());
            pr.setString(2, domain.getCREFERENCIA_COD_DOC_REF());

            rst = pr.executeQuery();
            rst.next();

            return BeanReferencia.parseToBeanReferencia(rst);

        } catch (Exception e) {
            throw new SQLException(e.getMessage());
        }

    }

    @Override
    public void eliminarAnexos(String sPeriodo, String sCodigo, String sSecuencia) throws Exception {
        System.out.println("-sPeriodo-->" + sPeriodo + "-sCodigo-->" + sCodigo + "-sSecuencia-->" + sSecuencia);
        try {
            conn = getConnection();
            cs = conn.prepareCall("{call SP_DEL_ANEXOS(?,?,?)}");
            cs.setString(1, sPeriodo);
            cs.setString(2, sCodigo);
            cs.setString(3, sSecuencia);
            cs.executeUpdate();
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            cs.close();
            conn.close();
        }

    }

    private void validarCoherenciaConsulta(BeanAnexo domain) throws Exception {
        if (isEmpty(domain.getCANEXO_PERIODO())) {
            throw new Exception("PERDIODO NO PUEDE SER NULO");
        }

        if (isEmpty(domain.getCANEXO_COD_DOC_INT())) {
            throw new Exception("DOCUMENTO INTERNO NO PUEDE SER NULO");
        }

        if (isEmpty(domain.getCANEXO_SECUENCIA())) {
            throw new Exception("SECUENCIA NO PUEDE SER NULO");
        }
    }

    @Override
    public Collection RD_ObtenerBusqReferencia(String cbo_Tipo_Organizacion, String org, String txtFecDesde,
            String txtFecHasta, String cbx_Clase_Doc, String txt_nro_doc, String txt_Asunto_Ref,
            String cbo_Periodo, String cod_org_usu, String cod_org_jefe) throws SQLException {
        
        Collection c = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_REFERENCIA(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "A");
            cs.setString(3, cbo_Tipo_Organizacion);
            cs.setString(4, org);
            cs.setString(5, txtFecDesde);
            cs.setString(6, txtFecHasta);
            cs.setString(7, cbx_Clase_Doc);
            cs.setString(8, txt_nro_doc);
            cs.setString(9, txt_Asunto_Ref);
            cs.setString(10, cbo_Periodo);
            cs.setString(11, cod_org_usu);
            cs.setString(12, cod_org_jefe);
            cs.execute();
            rst = (ResultSet) cs.getObject(1);
            while (rst.next()) {
                objBeanRef = new BeanReferencia();
                objBeanRef.setCDOCUMENTO_PERIODO(rst.getString(1));
                objBeanRef.setCDOCUMENTO_COD_DOC_INT(rst.getString(2));
                objBeanRef.setCDOCUMENTO_CLASE(rst.getString(3));
                objBeanRef.setVCLASE_NOM_CORTO(rst.getString(4));
                objBeanRef.setCDOCUMENTO_NRO_ORDEN(rst.getString(5));
                objBeanRef.setVDOCUMENTO_ASUNTO(rst.getString(6));
                objBeanRef.setFECHA_DOC_ORIGEN(rst.getString(7));
                objBeanRef.setFEC_ING_SISTEMA(rst.getString(8));
                objBeanRef.setVOINTERNA_NOM_CORTO(rst.getString(9));

                c.add(objBeanRef);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " " + e.toString());
        } finally {
            rst.close();
            cs.close();
            conn.close();
        }
        return c;

    }

    @Override
    public Collection grabareferencia(String perido_ref, String codint_refe, String periodo_orig, String codint_orig) throws SQLException {
        Collection listaRef = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_REFERENCIA(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "B");
            cs.setString(3, periodo_orig);
            cs.setString(4, codint_orig);
            cs.setString(5, perido_ref);
            cs.setString(6, codint_refe);
            cs.setString(7, " ");
            cs.setString(8, " ");
            cs.setString(9, " ");
            cs.setString(10, " ");
            cs.setString(11, " ");
            cs.setString(12, " ");
            cs.execute();
            rst = (ResultSet) cs.getObject(1);
            while (rst.next()) {
                objBeanRef = new BeanReferencia();
                objBeanRef.setORDEN_REF(rst.getString(1));
                objBeanRef.setVCLASE_NOM_CORTO(rst.getString(2));
                objBeanRef.setCDOCUMENTO_NRO_ORDEN(rst.getString(3));
                objBeanRef.setVDOCUMENTO_CLAVE_INDIC(rst.getString(4));
                objBeanRef.setFECHA_DOC_ORIGEN(rst.getString(5));
                objBeanRef.setCREFERENCIA_PERIODO_ORIG(rst.getString(6));
                objBeanRef.setCREFERENCIA_COD_DOC_ORIG(rst.getString(7));
                objBeanRef.setCREFERENCIA_PERIODO_REF(rst.getString(8));
                objBeanRef.setCREFERENCIA_COD_DOC_REF(rst.getString(9));
                listaRef.add(objBeanRef);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " " + e.toString());
        } finally {
            rst.close();
            cs.close();
            conn.close();
        }
        return listaRef;

    }

    @Override
    public Collection Listareferencia(String periodo_orig, String codint_orig) throws SQLException {
        Collection listaRef = new ArrayList();

        try {
            conn = getConnection();
            String query = "begin ? := SF_REFERENCIA(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "C");
            cs.setString(3, periodo_orig);
            cs.setString(4, codint_orig);
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, " ");
            cs.setString(8, "");
            cs.setString(9, " ");
            cs.setString(10, " ");
            cs.setString(11, " ");
            cs.setString(12, " ");
            cs.execute();
            rst = (ResultSet) cs.getObject(1);
            while (rst.next()) {
                objBeanRef = new BeanReferencia();
                objBeanRef.setORDEN_REF(rst.getString(1));
                objBeanRef.setVCLASE_NOM_CORTO(rst.getString(2));
                objBeanRef.setCDOCUMENTO_NRO_ORDEN(rst.getString(3));
                objBeanRef.setVDOCUMENTO_CLAVE_INDIC(rst.getString(4));
                objBeanRef.setFECHA_DOC_ORIGEN(rst.getString(5));
                objBeanRef.setCREFERENCIA_PERIODO_ORIG(rst.getString(6));
                objBeanRef.setCREFERENCIA_COD_DOC_ORIG(rst.getString(7));
                objBeanRef.setCREFERENCIA_PERIODO_REF(rst.getString(8));
                objBeanRef.setCREFERENCIA_COD_DOC_REF(rst.getString(9));

                listaRef.add(objBeanRef);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " " + e.toString());
        } finally {
            rst.close();
            cs.close();
            conn.close();
        }

        return listaRef;

    }

    @Override
    public Collection eliminaReferencia(String periodo_orig, String codint_orig, String perido_ref, String codint_refe) throws SQLException {
        
        Collection listaRef = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_REFERENCIA(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "D");
            cs.setString(3, periodo_orig);
            cs.setString(4, codint_orig);
            cs.setString(5, perido_ref);
            cs.setString(6, codint_refe);
            cs.setString(7, " ");
            cs.setString(8, " ");
            cs.setString(9, " ");
            cs.setString(10, " ");
            cs.setString(11, " ");
            cs.setString(12, " ");
            cs.execute();
            rst = (ResultSet) cs.getObject(1);
            while (rst.next()) {
                objBeanRef = new BeanReferencia();
                objBeanRef.setORDEN_REF(rst.getString(1));
                objBeanRef.setVCLASE_NOM_CORTO(rst.getString(2));
                objBeanRef.setCDOCUMENTO_NRO_ORDEN(rst.getString(3));
                objBeanRef.setVDOCUMENTO_CLAVE_INDIC(rst.getString(4));
                objBeanRef.setFECHA_DOC_ORIGEN(rst.getString(5));
                objBeanRef.setCREFERENCIA_PERIODO_ORIG(rst.getString(6));
                objBeanRef.setCREFERENCIA_COD_DOC_ORIG(rst.getString(7));
                objBeanRef.setCREFERENCIA_PERIODO_REF(rst.getString(8));
                objBeanRef.setCREFERENCIA_COD_DOC_REF(rst.getString(9));
                listaRef.add(objBeanRef);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " " + e.toString());
        } finally {
            rst.close();
            cs.close();
            conn.close();
        }
        return listaRef;
        
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

    @Override
    public BeanRevisarDocumento obtenerDocXBorrador(String periodo, String codigoInternoDoc, String usuario) throws SQLException {
        objBeanRD = new BeanRevisarDocumento();
        try {
            conn = getConnection();
            String query = "begin ? := SF_REVISAR_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "F");
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
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } catch (IOException ex) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + ex.toString());
        } finally {
            rst.close();
            cs.close();
            conn.close();
        }
        return objBeanRD;

    }

}
