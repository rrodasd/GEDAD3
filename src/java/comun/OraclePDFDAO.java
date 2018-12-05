package comun;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Blob;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import oracle.jdbc.OracleTypes;
import sagde.bean.BeanAnexo;
import sagde.bean.BeanDistribucion;
import sagde.comun.OracleDBConn;
import sagde.comun.Parametros;

import static comun.StringUtil.*;

public class OraclePDFDAO implements PDFDAO {

    Connection conn = null;
    Statement stm = null;
    ResultSet rst = null;
    PreparedStatement pr = null;
    CallableStatement cst = null;

    private Connection getConnection() {
        OracleDBConn cnx = new OracleDBConn();
        return cnx.getConnection();
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
    
     public byte[] obtenerAnexos(BeanAnexo objBean) throws Exception {
                
    System.out.println("Ingreso al ORACLE PDF --->>>>>>>>"); 
   System.out.println("Manda al Oracle Periodo imagen-->"+objBean.getCANEXO_PERIODO()+"-->");
         System.out.println("Manda al Oracle Codigo Interno imagen-->"+objBean.getCANEXO_COD_DOC_INT()+"-->");
          System.out.println("Manda al Oracle Codigo organizacion imagen-->"+objBean.getCANEXO_SECUENCIA()+"-->");
    System.out.println("Manda al Oracle Codigo organizacion imagen-->"+objBean.getVANEXO_NOMBRE()+"-->");
    
         
           
        String sql = "SELECT BANEXO_IMAGEN_ARCHIVO "
                + "FROM SAGDE_ANEXOS "
                + "WHERE CANEXO_PERIODO = ? AND "
                + "CANEXO_COD_DOC_INT = ? AND "
                + "CANEXO_SECUENCIA = ? ";
               
        byte[] buffer = null;
        try {
            conn = getConnection();
            pr = conn.prepareStatement(sql);
            pr.setString(1, objBean.getCANEXO_PERIODO());
            pr.setString(2, objBean.getCANEXO_COD_DOC_INT());
            pr.setString(3, objBean.getCANEXO_SECUENCIA());
            rst = pr.executeQuery();
            while (rst.next()) {
                Blob bin = rst.getBlob("BANEXO_IMAGEN_ARCHIVO");                
                if (bin != null) {
                    InputStream inStream = bin.getBinaryStream();
                    int size = (int) bin.length();
                    buffer = new byte[size];
                    try {
                        inStream.read(buffer, 0, size);
                    } catch (IOException ex) {
                        System.out.println("Error en obtenerAdjunto IO x" + ex.toString() + "x");
                    }
                }
            }
        } catch (SQLException ex) {
            System.out.println("Error en obtenerAdjunto x" + ex.toString() + "x");
            return null;
        } finally {
            conn.close();
            rst.close();
            pr.close();
        }
        System.out.println("veremossss ANEXOOOOO"+buffer);
        return buffer;
        
    }
    
    
    public byte[] obtenerAdjunto(BeanDistribucion objBean) throws Exception {
                
    System.out.println("Ingreso al ORACLE PDF --->>>>>>>>"); 
   System.out.println("Manda al Oracle Periodo imagen-->"+objBean.getPeriodo()+"-->");
         System.out.println("Manda al Oracle Codigo Interno imagen-->"+objBean.getCodigoDocumento()+"-->");
          System.out.println("Manda al Oracle Codigo organizacion imagen-->"+objBean.getCodigoOrganizacion()+"-->");
    
         String codigoorg=objBean.getCodigoOrganizacion();
          
          String orgcom=String.format("%1$-30s",codigoorg);
           System.out.println("Manda al Oracle Codigo organizacion imaga verrrrrrrrren-->"+orgcom+"-->");
        String sql = "SELECT BDISTRIBUCION_IMAGEN_DOC "
                + "FROM SAGDE_DISTRIBUCION "
                + "WHERE CDISTRIBUCION_PERIODO = ? AND "
                + "CDISTRIBUCION_COD_DOC_INT = ? AND "
                + "CDISTRIBUCION_COD_ORG = ? ";
               
        byte[] buffer = null;
        try {
            conn = getConnection();
            pr = conn.prepareStatement(sql);
            pr.setString(1, objBean.getPeriodo());
            pr.setString(2, objBean.getCodigoDocumento());
            pr.setString(3, orgcom);
            rst = pr.executeQuery();
            while (rst.next()) {
                Blob bin = rst.getBlob("BDISTRIBUCION_IMAGEN_DOC");                
                if (bin != null) {
                    InputStream inStream = bin.getBinaryStream();
                    int size = (int) bin.length();
                    buffer = new byte[size];
                    try {
                        inStream.read(buffer, 0, size);
                    } catch (IOException ex) {
                        System.out.println("Error en obtenerAdjunto IO x" + ex.toString() + "x");
                    }
                }
            }
        } catch (SQLException ex) {
            System.out.println("Error en obtenerAdjunto x" + ex.toString() + "x");
            return null;
        } finally {
            conn.close();
            rst.close();
            pr.close();
        }
        System.out.println("veremossss"+buffer);
        return buffer;
        
    }
    
     
    public BeanDistribucion obtenerGestion(BeanDistribucion objBean) throws Exception {
        
        
        System.out.println("Manda al Oracle Periodo-->"+objBean.getPeriodo()+"-->");
         System.out.println("Manda al Oracle Codigo Interno-->"+objBean.getCodigoDocumento()+"-->");
          System.out.println("Manda al Oracle Codigo organizacion-->"+objBean.getCodigoOrganizacion()+"-->");
        BeanDistribucion objBean2 = new BeanDistribucion();
        try {
             conn = getConnection();
            String query = "begin ? := SF_GET_DISTRIBUCION_NEW(?,?,?); end;";
            cst = conn.prepareCall(query);
            cst.registerOutParameter(1, OracleTypes.CURSOR);           
            cst.setString(2, objBean.getPeriodo());
            cst.setString(3, objBean.getCodigoDocumento());
            cst.setString(4, objBean.getCodigoOrganizacion());                      
            cst.execute();
            rst = (ResultSet) cst.getObject(1);
            while (rst.next()) {
                objBean2.setNombre(rst.getString(1));                
            }
        } catch (SQLException e) {
            System.out.println("Error en obtenerGestion: " + e.toString());
        } finally {
            rst.close();
            cst.close();
            conn.close();
        }
        return objBean2;
        
    }
    
    @Override
    public Blob ObtenerPDF(String periodo, String tiporganizacion, String organizacion) throws SQLException {
        System.out.println("<---Ingreso a Obtener PDF --->");
        System.out.println("<---Ingreso a periodo  --->"+periodo+"-->");
        System.out.println("<---Ingreso a tiporganizacion  --->"+tiporganizacion+"-->");
        System.out.println("<---Ingreso a organizacion  --->"+organizacion+"-->");
        
        Blob imagen = null;
        try {
            conn = getConnection();
            stm = conn.createStatement();
            String sqlStatement = "SELECT BDISTRIBUCION_IMAGEN_DOC from SAGDE_DISTRIBUCION where CDISTRIBUCION_PERIODO  = '" + periodo + "' and  CDISTRIBUCION_COD_DOC_INT = '" + tiporganizacion + "' and CDISTRIBUCION_COD_ORG = '" + organizacion + "' ";
            rst = stm.executeQuery(sqlStatement);
            if (rst.next()) {
                System.out.println("dentro de rs.next");
                imagen = rst.getBlob("BDISTRIBUCION_IMAGEN_DOC");
                 System.out.println(imagen);
            }
          
            
        String so = System.getProperty("os.name");
        String rutaRaiz = "/tmp/";

        if (so.contains("Windows")) {
//            rutaRaiz = "c:\\tmp\\";
            rutaRaiz = "c:/tmp/";
        } else {
            rutaRaiz = "/tmp/";
        }
            
                   
            
            
            if (imagen == null) {
                imagen = rst.getBlob(rutaRaiz + "pdf_noexiste.pdf");
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " " + e.toString());
        } finally {
            rst.close();
            stm.close();
            conn.close();
        }
        System.out.println("antes de -->>>"+imagen);
        return imagen;

    }

    @Override
    public Blob ObtenerPDFReferencia(String periodo, String tiporganizacion) throws SQLException {

        Blob imagen = null;
        try {
            conn = getConnection();
            stm = conn.createStatement();
            String sqlStatement = "SELECT BDISTRIBUCION_IMAGEN_DOC from SAGDE_DISTRIBUCION where CDISTRIBUCION_PERIODO  = '" + periodo + "' and  CDISTRIBUCION_COD_DOC_INT = '" + tiporganizacion + "'";
            rst = stm.executeQuery(sqlStatement);
            if (rst.next()) {
                imagen = rst.getBlob("BDISTRIBUCION_IMAGEN_DOC");
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " " + e.toString());
        } finally {
            rst.close();
            stm.close();
            conn.close();
        }
        return imagen;

    }

    @Override
    public Blob ObtenerPDF() throws SQLException {
        System.out.println("--entro a obtener PDF--");
        Blob imagen = null;
        try {
            conn = getConnection();
            String sqlStatement = "select bdistribucion_imagen_doc from sagde_anexos where cdistribucion_periodo='2005' and cdistribucion_cod_doc_int='000001'";
            rst = conn.createStatement().executeQuery(sqlStatement);
            if (rst.next()) {
                imagen = rst.getBlob("bdistribucion_imagen_doc");
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " " + e.toString());
        } finally {
            rst.close();
            conn.close();

        }
        return imagen;
    }

    @Override
    public Blob ObtenerPDFAnexo(String periodo, String codigoInterno, String secuencia) throws SQLException {

        Blob imagen = null;
        try {
            conn = getConnection();
            stm = conn.createStatement();
            String sqlStatement = "SELECT BANEXO_IMAGEN_ARCHIVO from SAGDE_ANEXOS where CANEXO_PERIODO  = '" + periodo + "' and  CANEXO_COD_DOC_INT = '" + codigoInterno + "' and CANEXO_SECUENCIA = '" + secuencia + "' ";
            rst = stm.executeQuery(sqlStatement);
            if (rst.next()) {
                imagen = rst.getBlob("BANEXO_IMAGEN_ARCHIVO");
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE+" "+e.toString());
        } finally {
            rst.close();
            stm.close();
            conn.close();
        }
        return imagen;
    }

}
