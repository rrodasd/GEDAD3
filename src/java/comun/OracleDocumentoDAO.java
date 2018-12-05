package comun;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

import oracle.jdbc.OracleTypes;
import sagde.bean.BeanAnexo;
import sagde.bean.BeanArchivo;
import sagde.bean.BeanClaseDocumento;
import sagde.bean.BeanClasificacionDocumento;
import sagde.bean.BeanDistribucion;
import sagde.bean.BeanDocumento;

import sagde.bean.BeanDocumento1;
import sagde.bean.BeanOrganizacionExterna;
import sagde.bean.BeanOrganizacionInterna;
import sagde.bean.BeanPeriodo;
import sagde.bean.BeanPrioridadDocumento;
import sagde.bean.BeanRegistroDocumento;
import sagde.bean.BeanRevisarDocumento1;
import sagde.bean.BeanSello;

import sagde.comun.OracleDBConn;
import sagde.comun.Parametros;

public class OracleDocumentoDAO implements DocumentoDAO {

    Connection conn = null;
    CallableStatement cs = null;
    PreparedStatement pcs = null;
    ResultSet rs = null;
    Statement st = null;
    BeanDocumento1 objBeanD1 = null;
    BeanDocumento objBeanD = null;
    BeanArchivo objBeanA = null;
    BeanPrioridadDocumento objBeanPD = null;
    BeanOrganizacionInterna objBeanOI = null;
    BeanClasificacionDocumento objBeanCFD = null;
    BeanPeriodo objBeanP = null;
    BeanOrganizacionExterna objBeanOE = null;
    BeanDistribucion objBeanDI = null;
    BeanClaseDocumento objBeanCD = null;
    BeanAnexo objBeanAN = null;
    BeanRevisarDocumento1 objBeanRD = null;
    BeanSello objBeanS = null;

    private Connection getConnection() {
        OracleDBConn cnx = new OracleDBConn();
        return cnx.getConnection();
    }

//--------------------------------------------MODULO REGISTRO DE DOCUMENTO --------------------------------------------------------//
  
     @Override
    public String insertarDocRegistrado_MP(BeanRegistroDocumento entidad) throws Exception {

        String cod_documento_int = "";
        try {
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_REGISTRO_DOC_MP(?,?,?,?,?,?,?,?,?,?,?,?,?,?); end;";
            String genericQuery = "{ call ? := SF_REGISTRO_DOC_MP(?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            conn.setAutoCommit(false);
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.VARCHAR);
            cs.setString(2, entidad.getCDOCUMENTO_PERIODO());
            System.out.println("PERIDOD-"+entidad.getCDOCUMENTO_PERIODO()+"-");
            cs.setString(3, entidad.getCDOCUMENTO_TIPO_ORG_ORIG());
             System.out.println("TIPO ORG_ORIG-"+entidad.getCDOCUMENTO_TIPO_ORG_ORIG()+"-");
            cs.setString(4, entidad.getCDOCUMENTO_COD_ORG_ORIG());
            System.out.println(" ORG_ORIG"+entidad.getCDOCUMENTO_COD_ORG_ORIG()+"-");
            cs.setString(5, entidad.getCDOCUMENTO_CLASE());
            System.out.println(" CLASE-"+entidad.getCDOCUMENTO_CLASE()+"-");
            cs.setString(6, entidad.getCDOCUMENTO_NRO_ORDEN());
             System.out.println(" NRO ORDEN-"+entidad.getCDOCUMENTO_NRO_ORDEN()+"-");
            cs.setString(7, entidad.getVDOCUMENTO_CLAVE_INDIC());  
            System.out.println(" CLAVE IND-"+entidad.getVDOCUMENTO_CLAVE_INDIC()+"-");
            cs.setString(8, entidad.getDDOCUMENTO_FECHA());
            System.out.println(" FECHA-"+entidad.getDDOCUMENTO_FECHA()+"-");
            cs.setString(9, entidad.getVDOCUMENTO_ASUNTO());
             System.out.println(" ASUNTO-"+entidad.getVDOCUMENTO_ASUNTO()+"-");
            cs.setString(10, entidad.getCDISTRIBUCION_TIPO_DISTRIB());
             System.out.println(" TIPO DISTRI-"+entidad.getCDISTRIBUCION_TIPO_DISTRIB()+"-");
            cs.setString(11, entidad.getCDOCUMENTO_PRIORIDAD()); 
            System.out.println(" PRIORIDAD-"+entidad.getCDOCUMENTO_PRIORIDAD()+"-");
            cs.setString(12, entidad.getVDOCUMENTO_GUARNICION()); 
              System.out.println(" GUARNICION-"+entidad.getVDOCUMENTO_GUARNICION()+"-");
            cs.setString(13, entidad.getVDOCUMENTO_USUARIO()); 
             System.out.println(" USUARIO-"+entidad.getVDOCUMENTO_USUARIO()+"-");
            cs.setString(14, entidad.getCOD_ORG_USUARIO()); 
             System.out.println(" COD ORGA USUARIO-"+entidad.getCOD_ORG_USUARIO()+"-");
            cs.setString(15, entidad.getJEFE_UNIDAD()); 
            System.out.println("Jefe de la unidad"+entidad.getJEFE_UNIDAD()+"-");
         
            
          
            cs.executeUpdate();
            cod_documento_int = (String) cs.getObject(1);
            conn.commit();
        } catch (SQLException e) {
            conn.rollback();
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            cs.close();
            conn.close();
        }
        return cod_documento_int;
    }

    @Override
    public String insertarDocRegistrado_REF(BeanRegistroDocumento entidad) throws Exception {

        String cod_documento_int = "";
        try {
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_REGISTRO_DOC_REFERENCIA(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?); end;";
            String genericQuery = "{ call ? := SF_REGISTRO_DOC_REFERENCIA(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            conn.setAutoCommit(false);
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.VARCHAR);
            cs.setString(2, entidad.getCDOCUMENTO_PERIODO());
            cs.setString(3, entidad.getCDOCUMENTO_TIPO_ORG_ORIG());
            cs.setString(4, entidad.getCDOCUMENTO_COD_ORG_ORIG());
            cs.setString(5, entidad.getCDOCUMENTO_CLASE());
            cs.setString(6, entidad.getCDOCUMENTO_NRO_ORDEN());
            cs.setString(7, entidad.getVDOCUMENTO_CLAVE_INDIC());   
            cs.setString(8, entidad.getDDOCUMENTO_FECHA());
            cs.setString(9, entidad.getVDOCUMENTO_ASUNTO());
            cs.setString(10, entidad.getCDOCUMENTO_CLASIFICACION());
            cs.setString(11, entidad.getCDOCUMENTO_PRIORIDAD()); 
            cs.setString(12, entidad.getVDOCUMENTO_GUARNICION()); 
            cs.setString(13, entidad.getVDOCUMENTO_USUARIO()); 
            cs.setString(14, entidad.getCOD_ORG_USUARIO()); 
            cs.setString(15, entidad.getCDOCUMENTO_PERIODO_ORIG()); 
            cs.setString(16, entidad.getCDOCUMENTO_COD_DOC_INT_ORIG());              
          
            cs.executeUpdate();
            cod_documento_int = (String) cs.getObject(1);
            conn.commit();
        } catch (SQLException e) {
            conn.rollback();
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            cs.close();
            conn.close();
        }
        return cod_documento_int;
    }
    
    @Override
    public Collection obtenerFullDocumento(String cod_org_usuario,String cod_jefe_unidad,String Tipo) throws Exception {

        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_MESA_PARTES(?,?,?,?,?,?,?,?,?,?,?); end;";
            String genericQuery = "{ call ? := SF_MESA_PARTES(?,?,?,?,?,?,?,?,?,?,?) }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "A");
            cs.setString(3, cod_org_usuario);
            cs.setString(4, cod_jefe_unidad);
            cs.setString(5, Tipo);
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanD1 = new BeanDocumento1();
                objBeanD1.setNRO(rs.getString(1));
                System.out.println("perido--"+rs.getString(2)+"--");
                objBeanD1.setCDOCUMENTO_PERIODO(rs.getString(2));
                objBeanD1.setCDOCUMENTO_COD_DOC_INT(rs.getString(3));
                objBeanD1.setCDOCUMENTO_TIPO_ORG_ORIG(rs.getString(4));
                objBeanD1.setCDOCUMENTO_COD_ORG_ORIG(rs.getString(5));
                objBeanD1.setCDOCUMENTO_CLASE(rs.getString(6));
                objBeanD1.setCDOCUMENTO_NRO_ORDEN(rs.getString(7));
                objBeanD1.setVDOCUMENTO_CLAVE_INDIC(rs.getString(8));
                objBeanD1.setCDOCUMENTO_ARCHIVO_INDIC(rs.getString(9));
                objBeanD1.setCDOCUMENTO_CLASIFICACION(rs.getString(10));
                objBeanD1.setCDOCUMENTO_PRIORIDAD(rs.getString(11));
                objBeanD1.setDDOCUMENTO_FECHA(rs.getString(12));
                objBeanD1.setVDOCUMENTO_ASUNTO(rs.getString(13));
                objBeanD1.setCDOCUMENTO_ESTADO(rs.getString(14));
                objBeanD1.setVDOCUMENTO_USUARIO(rs.getString(15));
                objBeanD1.setCDOCUMENTO_COD_ORG_DEP(rs.getString(16));
                objBeanD1.setCDOCUMENTO_COD_ORG_NIV(rs.getString(17));
                objBeanD1.setVDOCUMENTO_GUARNICION(rs.getString(18));
                objBeanD1.setCCLASE_CODIGO(rs.getString(19));
                objBeanD1.setCARCHIVO_CODIGO(rs.getString(20));
                objBeanD1.setCCLASIF_CODIGO(rs.getString(21));
                objBeanD1.setCPRIORIDAD_CODIGO(rs.getString(22));
                objBeanD1.setDDOCUMENTO_FEC_ACT(rs.getString(24));
                objBeanD1.setVOINTERNA_USU_JEFE(rs.getString(25));
                objBeanD1.setCDISTRIBUCION_COD_ORG(rs.getString(26));
                objBeanD1.setVDISTRIBUCION_TOKEN(rs.getString(27));
                objBeanD1.setCDISTRIBUCION_TIPO_DISTRIB(rs.getString(28));
                 
                
                
                objLista.add(objBeanD1);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objLista;

    }

    @Override
    public Collection traeComboPeriodo() throws SQLException {
        Collection c = new ArrayList();
        try {
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_GET_COMBO_PERIODO(); end;";
            String genericQuery = "{ call ? := SF_GET_COMBO_PERIODO() }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanD1 = new BeanDocumento1();
                objBeanD1.setCodigo(rs.getString(1));
                objBeanD1.setNombre(rs.getString(2));
                c.add(objBeanD1);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return c;

    }

    @Override
    public Collection traeComboEntidadExterna(String codOrganizacion) throws SQLException {

        Collection c = new ArrayList();
        try {
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_GET_ENTIDADEXTERNA(?); end;";
            String genericQuery = "{ call ? := SF_GET_ENTIDADEXTERNA(?) }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, codOrganizacion);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanD1 = new BeanDocumento1();
                objBeanD1.setCodigo(rs.getString(1));
                objBeanD1.setNombre(rs.getString(2));
                c.add(objBeanD1);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return c;

    }

    @Override
    public Collection obtenerOrganizacionEjercito3() throws Exception {

        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_GET_ORG_INT_1NIV(); end;";
            String genericQuery = "{ call ? := SF_GET_ORG_INT_1NIV() }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanOI = new BeanOrganizacionInterna();
                objBeanOI.setNOINTERNA_NIVEL(rs.getString(1));
                objBeanOI.setVOINTERNA_NOM_CORTO(rs.getString(2));
                objBeanOI.setCOINTERNA_CODIGO(rs.getString(3));
                objLista.add(objBeanOI);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objLista;

    }

    @Override
    public Collection obtenerDependencia(String codigoOrganizacionUsuario) throws SQLException {
        //System.out.println("codigo "+codigoOrganizacionUsuario);
        Collection dependencias = new ArrayList();
        try {
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_GET_ORG_NIV_2_INF(?); end;";
            String genericQuery = "{ call ? := SF_GET_ORG_NIV_2_INF(?) }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, codigoOrganizacionUsuario);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanOI = new BeanOrganizacionInterna();
                objBeanOI.setCOINTERNA_CODIGO(rs.getString(1));
                objBeanOI.setVOINTERNA_NOM_CORTO(rs.getString(2));
                objBeanOI.setVOINTERNA_CLAVE_INDIC(rs.getString(3));
                dependencias.add(objBeanOI);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return dependencias;

    }

    @Override
    public Collection traeComboArchivo() throws SQLException {

        Collection c = new ArrayList();
        try {
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_GET_COMBO_ARCHIVO(); end;";
            String genericQuery = "{ call ? := SF_GET_COMBO_ARCHIVO() }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanD1 = new BeanDocumento1();
                objBeanD1.setCodigo(rs.getString(1));
                objBeanD1.setNombre(rs.getString(2));
                c.add(objBeanD1);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return c;

    }

    @Override
    public Collection traeComboClase() throws SQLException {

        Collection c = new ArrayList();
        try {
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_GET_CLASE(); end;";
            String genericQuery = "{ call ? := SF_GET_CLASE() }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanD1 = new BeanDocumento1();
                objBeanD1.setCodigo(rs.getString(1));
                objBeanD1.setNombre(rs.getString(2));
                c.add(objBeanD1);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return c;

    }

    @Override
    public Collection traeComboClasificacion() throws SQLException {

        Collection c = new ArrayList();
        try {
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_GET_CLASIFICACION(); end;";
            String genericQuery = "{ call ? := SF_GET_CLASIFICACION() }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanD1 = new BeanDocumento1();
                objBeanD1.setCodigo(rs.getString(1));
                objBeanD1.setNombre(rs.getString(2));
                c.add(objBeanD1);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return c;

    }

    @Override
    public Collection traeComboPrioridad() throws SQLException {

        Collection c = new ArrayList();
        try {
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_GET_COMBO_PRIORIDAD(); end;";
            String genericQuery = "{ call ? := SF_GET_COMBO_PRIORIDAD() }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanD1 = new BeanDocumento1();
                objBeanD1.setCodigo(rs.getString(1));
                objBeanD1.setNombre(rs.getString(2));
                c.add(objBeanD1);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return c;

    }

    @Override
    public String insertarDocumentoImg(BeanDocumento1 entidad) throws Exception {

        String cod_documento_int = "";
        try {
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_INS_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?); end;";
            String genericQuery = "{ call ? := SF_INS_DOCUMENTO(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?) }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            conn.setAutoCommit(false);
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.VARCHAR);
            cs.setString(2, entidad.getCDOCUMENTO_PERIODO());
            cs.setString(3, entidad.getCDOCUMENTO_TIPO_ORG_ORIG());
            cs.setString(4, entidad.getCDOCUMENTO_COD_ORG_ORIG());
            cs.setString(5, entidad.getCDOCUMENTO_CLASE());
            cs.setString(6, entidad.getCDOCUMENTO_NRO_ORDEN());
            cs.setString(7, entidad.getVDOCUMENTO_CLAVE_INDIC());
            cs.setString(8, entidad.getCDOCUMENTO_ARCHIVO_INDIC());
            cs.setString(9, entidad.getCDOCUMENTO_CLASIFICACION());
            cs.setString(10, entidad.getCDOCUMENTO_PRIORIDAD());
            cs.setString(11, entidad.getDDOCUMENTO_FECHA());
            cs.setString(12, entidad.getVDOCUMENTO_ASUNTO());
            cs.setString(13, entidad.getVDOCUMENTO_USUARIO());
            cs.setString(14, entidad.getVDOCUMENTO_GUARNICION());
            cs.setString(15, entidad.getCOD_ORG_USUARIO());
            cs.setString(16, entidad.getVDISTRIBUCION_NOM_FILE());
            cs.executeUpdate();
            cod_documento_int = (String) cs.getObject(1);
            conn.commit();
        } catch (SQLException e) {
            conn.rollback();
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            cs.close();
            conn.close();
        }
        return cod_documento_int;
    }

    @Override
    public void uu_imagen_insertar(String cdocumento_periodo, String codigoInterno, String cod_org_usuario, FileInputStream streamEntrada) throws Exception {
        
        conn = getConnection();
        try {
            pcs = conn.prepareStatement("UPDATE SAGDE_DISTRIBUCION SET BDISTRIBUCION_IMAGEN_DOC = ? WHERE CDISTRIBUCION_PERIODO = ? AND CDISTRIBUCION_COD_DOC_INT = ? AND CDISTRIBUCION_TIPO_ORG = ? AND CDISTRIBUCION_COD_ORG = ? ");
            pcs.setBinaryStream(1, streamEntrada, streamEntrada.available());
            pcs.setString(2, cdocumento_periodo);
            pcs.setString(3, codigoInterno);
            pcs.setString(4, "I");
            pcs.setString(5, String.format("%1$-30s", cod_org_usuario));
            pcs.executeUpdate();
            conn.commit();
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            conn.close();
            pcs.close();
        }

    }

    @Override
    @SuppressWarnings("empty-statement")
    public void uu_imagen_anexos(String cdocumento_periodo, String codigoInterno, String filename_anexo1, String filename_anexo2, String filename_anexo3, String filename_anexo4, String filename_anexo5) throws IOException {

        conn = getConnection();
        String codigoanex;

        try {
            //--CREAMOS LA COLECCION 
            Collection anexos = new ArrayList();

            String so = System.getProperty("os.name");
            String rutaRaiz = "/tmp/";

            if (so.contains("Windows")) {
                rutaRaiz = "c:\\tmp\\";
            } else {
                rutaRaiz = "/tmp/";
            }

            if ("".equals(filename_anexo1)) {
                System.out.println("No exiten imagen a insertar en el Oracle para  al tabla anexos 1");
            } else {
                File archivo1 = new File(rutaRaiz + filename_anexo1);
                archivo1 = new File(rutaRaiz + filename_anexo1);
                FileInputStream streamEntrada1 = new FileInputStream(archivo1);
                BeanAnexo objBeanAnexo1 = new BeanAnexo();
                objBeanAnexo1.setVANEXO_NOMBRE(filename_anexo1);
                objBeanAnexo1.setBANEXO_IMAGEN_ARCHIVO(streamEntrada1);
                anexos.add(objBeanAnexo1);
            }

            if ("".equals(filename_anexo2)) {
                System.out.println("No exiten imagen a insertar en el Oracle para  al tabla anexos 2");
            } else {
                File archivo2 = new File(rutaRaiz + filename_anexo2);
                archivo2 = new File(rutaRaiz + filename_anexo2);
                FileInputStream streamEntrada2 = new FileInputStream(archivo2);
                BeanAnexo objBeanAnexo2 = new BeanAnexo();
                objBeanAnexo2.setVANEXO_NOMBRE(filename_anexo2);
                objBeanAnexo2.setBANEXO_IMAGEN_ARCHIVO(streamEntrada2);
                anexos.add(objBeanAnexo2);
            }
            
            if ("".equals(filename_anexo3)) {
                System.out.println("No exiten imagen a insertar en el Oracle para  al tabla anexos 3");
            } else {
                File archivo3 = new File(rutaRaiz + filename_anexo3);
                archivo3 = new File(rutaRaiz + filename_anexo3);
                FileInputStream streamEntrada3 = new FileInputStream(archivo3);
                BeanAnexo objBeanAnexo3 = new BeanAnexo();
                objBeanAnexo3.setVANEXO_NOMBRE(filename_anexo3);
                objBeanAnexo3.setBANEXO_IMAGEN_ARCHIVO(streamEntrada3);
                anexos.add(objBeanAnexo3);
            }

            if ("".equals(filename_anexo4)) {
                System.out.println("No exiten imagen a insertar en el Oracle para  al tabla anexos 4");
            } else {
                File archivo4 = new File(rutaRaiz + filename_anexo4);
                archivo4 = new File(rutaRaiz + filename_anexo4);
                FileInputStream streamEntrada4 = new FileInputStream(archivo4);
                BeanAnexo objBeanAnexo4 = new BeanAnexo();
                objBeanAnexo4.setVANEXO_NOMBRE(filename_anexo4);
                objBeanAnexo4.setBANEXO_IMAGEN_ARCHIVO(streamEntrada4);
                anexos.add(objBeanAnexo4);
            }
            if ("".equals(filename_anexo5)) {
                System.out.println("No exiten imagen a insertar en el Oracle para  al tabla anexos 5");
            } else {                
                File archivo5 = new File(rutaRaiz + filename_anexo5);
                archivo5 = new File(rutaRaiz + filename_anexo5);
                FileInputStream streamEntrada5 = new FileInputStream(archivo5);
                BeanAnexo objBeanAnexo5 = new BeanAnexo();
                objBeanAnexo5.setVANEXO_NOMBRE(filename_anexo5);
                objBeanAnexo5.setBANEXO_IMAGEN_ARCHIVO(streamEntrada5);
                anexos.add(objBeanAnexo5);
            }

            Iterator iterator3 = anexos.iterator();
            
            DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
            FormularDocumentoDAO objFD = objDAOFactory.getFormularDocumentoDAO();

            while (iterator3.hasNext()) {
                codigoanex = objFD.generarCodigoAnexo(cdocumento_periodo, codigoInterno);
                BeanAnexo beanAnexo6 = (BeanAnexo) iterator3.next();
                pcs = conn.prepareStatement("insert into SAGDE_ANEXOS  VALUES(?,?,?,?,?) ");
                pcs.setString(1, cdocumento_periodo);
                pcs.setString(2, codigoInterno);
                pcs.setString(3, codigoanex);
                try {
                    pcs.setBinaryStream(4, beanAnexo6.getBANEXO_IMAGEN_ARCHIVO(), beanAnexo6.getBANEXO_IMAGEN_ARCHIVO().available());
                }catch (IOException e) {
                    System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
                }
                pcs.setString(5, beanAnexo6.getVANEXO_NOMBRE());
                pcs.executeUpdate();
                conn.commit();
                pcs.close();
                conn.close();
            }
            if (!"".equals(filename_anexo1)) {
                File archivo1 = new File(rutaRaiz + filename_anexo1);
                archivo1 = new File(rutaRaiz + filename_anexo1);
                archivo1.delete();
            }
            if (!"".equals(filename_anexo2)) {

                File archivo2 = new File(rutaRaiz + filename_anexo2);
                archivo2 = new File(rutaRaiz + filename_anexo2);
                archivo2.delete();
            }
            if (!"".equals(filename_anexo3)) {
                File archivo3 = new File(rutaRaiz + filename_anexo3);
                archivo3 = new File(rutaRaiz + filename_anexo3);
                archivo3.delete();
            }
            if (!"".equals(filename_anexo4)) {
                File archivo4 = new File(rutaRaiz + filename_anexo4);
                archivo4 = new File(rutaRaiz + filename_anexo4);;
                archivo4.delete();
            }
            if (!"".equals(filename_anexo5)) {
                File archivo5 = new File(rutaRaiz + filename_anexo5);
                archivo5 = new File(rutaRaiz + filename_anexo5);
                archivo5.delete();
            }
        } catch (Exception e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        }
    }

    @Override
    public void eliminarDocumento(String sPeriodo, String sCodigo) throws Exception {

        try {
            conn = getConnection();
            cs = conn.prepareCall("{call SP_DEL_REG_DOCUMENTO(?,?)}");
            cs.setString(1, sPeriodo);
            cs.setString(2, sCodigo);
            cs.executeUpdate();
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            cs.close();
            conn.close();
        }

    }

    @Override
    public void actualizarDocumento(BeanDocumento1 entidad) throws Exception {

        try {
            conn = getConnection();
            cs = conn.prepareCall("{call sp_upd_reg_documento(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}");
            cs.setString(1, entidad.getCDOCUMENTO_PERIODO());
            cs.setString(2, entidad.getCDOCUMENTO_COD_DOC_INT());
            cs.setString(3, entidad.getCDOCUMENTO_TIPO_ORG_ORIG());
            cs.setString(4, entidad.getCDOCUMENTO_COD_ORG_ORIG());
            cs.setString(5, entidad.getCDOCUMENTO_CLASE());
            cs.setString(6, entidad.getCDOCUMENTO_NRO_ORDEN());
            cs.setString(7, entidad.getVDOCUMENTO_CLAVE_INDIC());
            cs.setString(8, entidad.getCDOCUMENTO_ARCHIVO_INDIC());
            cs.setString(9, entidad.getCDOCUMENTO_CLASIFICACION());
            cs.setString(10, entidad.getCDOCUMENTO_PRIORIDAD());
            cs.setString(11, entidad.getDDOCUMENTO_FECHA());
            cs.setString(12, entidad.getVDOCUMENTO_ASUNTO());
            cs.setString(13, entidad.getVDOCUMENTO_USUARIO()); // de la sesion
            cs.setString(14, entidad.getVDOCUMENTO_GUARNICION());
            cs.setString(15, entidad.getCOD_ORG_USUARIO());
            cs.executeUpdate();
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            cs.close();
            conn.close();
        }

    }
    
     
  
    public void eliminarRegistro_MP(String perido, String cod_int,String cod_jefe_unidad) throws Exception {
          System.out.println("-sPeriodo-->"+perido+"-sCodigo-->"+cod_int+"-sSecuencia-->"+cod_jefe_unidad);
        try {
            conn = getConnection();
            cs = conn.prepareCall("{call SP_DEL_REGISTRO_MP(?,?,?)}");
            cs.setString(1, perido);
            cs.setString(2, cod_int);         
            cs.setString(3, cod_jefe_unidad);
            cs.executeUpdate();
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            cs.close();
            conn.close();
        }

    }

}