package comun;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import oracle.jdbc.OracleTypes;
import sagde.bean.BeanArchivo;
import sagde.bean.BeanAuxiliar;
import sagde.bean.BeanClase;
import sagde.bean.BeanGrupo;
import sagde.bean.BeanOrganizacionExterna;
import sagde.bean.BeanOrganizacionInterna;
import sagde.bean.BeanPeriodo;
import sagde.bean.BeanPrioridadDocumento;
import sagde.bean.BeanUsuarioAD;
import sagde.comun.OracleDBConn;
import sagde.comun.Parametros;

public class OracleComboboxDAO implements ComboboxDAO {

    Connection conn = null;
    CallableStatement cs = null;
    ResultSet rs = null;
    BeanAuxiliar objBeanA = null;
    BeanOrganizacionInterna objBeanOI = null;
    BeanPeriodo objBeanP = null;
    BeanArchivo objBeanAR = null;
    BeanOrganizacionExterna objBeanOE = null;
    BeanPrioridadDocumento objBeanPD = null;

    BeanClase objClaseDoc = null;
    BeanGrupo objBeanG = null;

    BeanUsuarioAD objBeanU = null;

    private Connection getConnection() {
        OracleDBConn cnx = new OracleDBConn();
        return cnx.getConnection();
    }

    /*
    * SE OBTIENE LOS USUARIO DE NIVEL INFERIOR PASANDO COMO PARAMERO EL CODIGO DE ORGANIZACION
     */
    @Override
    public Collection obtenerUsuarioNivelInf(String codOrganizacion) throws SQLException {
        //System.out.println("codOrganizacion+++"+codOrganizacion+"++");
        Collection c = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_COMBOS(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "A");
            cs.setString(3, codOrganizacion);
            cs.setString(4, "");
            cs.setString(5, "");
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
                objBeanA = new BeanAuxiliar();
                objBeanA.setCodigo(rs.getString(1));
                objBeanA.setNombre(rs.getString(2));
                c.add(objBeanA);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return c;

    }

    /*
    *SE OBTIENE LA ORGANIZACION LARGA DE LA CABECERA
     */
    @Override
    public Collection obtenerOrganizacionInternaNombreLargo(String codigoUsuario, String nivel) throws Exception {

        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "";
            if ("1".equals(nivel)) {
                query = "begin ? := SF_GET_ORG_NOM_LARGO(?); end;";
            } else {
                query = "begin ? := SF_COMBOS(?,?,?,?,?,?,?,?,?,?,?); end;";
            }
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "B");
            cs.setString(3, codigoUsuario);
            cs.setString(4, "");
            cs.setString(5, "");
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
                objBeanOI = new BeanOrganizacionInterna();
                objBeanOI.setCOINTERNA_CODIGO(rs.getString(1));
                objBeanOI.setVOINTERNA_NOM_LARGO(rs.getString(2));
                objLista.add(objBeanOI);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objLista;

    }

    /*
    *SE OBTIENE DEFINION DEL AÑO ACTUAL::AÑO DE LA MUJER ETC...
     */
    @Override
    public BeanPeriodo obtenerDefinicionPeriodo(String anio) throws Exception {

        objBeanP = new BeanPeriodo();
        try {
            conn = getConnection();
            String query = "begin ? := SF_COMBOS(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "C");
            cs.setString(3, anio);
            cs.setString(4, "");
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            if (rs.next()) {
                objBeanP = new BeanPeriodo();
                objBeanP.setCPERIODO_CODIGO(rs.getString(1));
                objBeanP.setVPERIODO_DEFINICION(rs.getString(2));
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objBeanP;

    }

    /*
    *SE OBTIENE EL LUGAR DE GUARNICION ::SAN  BORJA ETC...
     */
    @Override
    public String obtenerGuarnicionUsuario(String codigoOrganizacionUsuario) throws Exception {

        String guarnicion = "";
        try {
            conn = getConnection();
            String query = "begin ? := SF_COMBOS(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "D");
            cs.setString(3, codigoOrganizacionUsuario);
            cs.setString(4, "");
            cs.setString(5, "");
            cs.setString(6, "");
            cs.setString(7, "");
            cs.setString(8, "");
            cs.setString(9, "");
            cs.setString(10, "");
            cs.setString(11, "");
            cs.setString(12, "");
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            if (rs.next()) {
                guarnicion = (rs.getString(1));
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return guarnicion;

    }

    /*
    *SE OBTIENE LA LISTA DE INDICATIVOS DEL DOCUMENTO...
     */
    @Override
    public Collection obtenerArchivoIndicativo() throws Exception {

        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_COMBOS(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "E");
            cs.setString(3, "");
            cs.setString(4, "");
            cs.setString(5, "");
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
                objBeanAR = new BeanArchivo();
                objBeanAR.setCARCHIVO_CODIGO(rs.getString(1));
                objBeanAR.setVARCHIVO_NOMBRE(rs.getString(2));
                objLista.add(objBeanAR);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objLista;

    }

    @Override
    public Collection obtenerListaOrganizacionInterna(String codigo_org) throws Exception {

        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_COMBOS(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "F");
            cs.setString(3, codigo_org);
            cs.setString(4, "");
            cs.setString(5, "");
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
                objBeanOI = new BeanOrganizacionInterna();
                objBeanOI.setCOINTERNA_CODIGO(rs.getString(1));
                objBeanOI.setVOINTERNA_NOM_CORTO(rs.getString(2));
                objLista.add(objBeanOI);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objLista;

    }

    @Override
    public Collection obtenerListaOrganizacionExterna() throws Exception {

        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_COMBOS(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "G");
            cs.setString(3, "");
            cs.setString(4, "");
            cs.setString(5, "");
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
                objBeanOE = new BeanOrganizacionExterna();
                objBeanOE.setNombre(rs.getString(1));
                objBeanOE.setCodigo(rs.getString(2));
                objLista.add(objBeanOE);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objLista;

    }

    @Override
    public Collection obtenerListaOrganizacionEjercito(String codigo_org, String dato) throws Exception {
        System.out.println("codigo_org--->" + codigo_org + "<--");
        System.out.println("dato--->" + dato + "<--");
        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_COMBOS(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "H");
            cs.setString(3, codigo_org);
            cs.setString(4, dato);
            cs.setString(5, "");
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
                objBeanOI = new BeanOrganizacionInterna();
                objBeanOI.setVOINTERNA_NOM_CORTO(rs.getString(1));
                objBeanOI.setCOINTERNA_CODIGO(rs.getString(2));
                objLista.add(objBeanOI);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objLista;

    }

    @Override
    public Collection obtenerPrioridades() throws Exception {

        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_COMBOS(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "I");
            cs.setString(3, "");
            cs.setString(4, "");
            cs.setString(5, "");
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
                objBeanPD = new BeanPrioridadDocumento();
                objBeanPD.setCodigo(rs.getString(1));
                objBeanPD.setNombre(rs.getString(2));
                objLista.add(objBeanPD);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objLista;

    }

    public Collection obtenerfirmadoPor(String nombreUsuario) throws Exception {

        Collection c = new ArrayList();
        try {
            conn = getConnection();
            String query = "";

            query = "begin ? := SF_COMBOS(?,?,?,?,?,?,?,?,?,?,?); end;";

            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "J");
            cs.setString(3, nombreUsuario);
            cs.setString(4, "");
            cs.setString(5, "");
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
                objBeanU = new BeanUsuarioAD();
                objBeanU.setVUSUARIO_CODIGO(rs.getString(1));
                objBeanU.setCUSUARIO_COD_ORG(rs.getString(2));
                objBeanU.setVUSUARIO_CARGO(rs.getString(3));
                c.add(objBeanU);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return c;

    }

    @Override
    public Collection obtenerRevisadorPor(String nombreUsuario) throws Exception {

        Collection c = new ArrayList();
        try {
            conn = getConnection();
            String query = "";

            query = "begin ? := SF_COMBOS(?,?,?,?,?,?,?,?,?,?,?); end;";

            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "K");
            cs.setString(3, nombreUsuario);
            cs.setString(4, "");
            cs.setString(5, "");
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
                objBeanU = new BeanUsuarioAD();
                objBeanU.setVUSUARIO_CODIGO(rs.getString(1));
                objBeanU.setCUSUARIO_COD_ORG(rs.getString(2));
                objBeanU.setVUSUARIO_CARGO(rs.getString(3));
                c.add(objBeanU);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return c;

    }

    @Override
    public Collection obtenerRevisadorPor_mismo(String nombreUsuario) throws Exception {
        System.out.println("-----nombreUsuario--"+nombreUsuario);

        Collection c = new ArrayList();
        try {
            conn = getConnection();
            String query = "";        
                query = "begin ? := SF_COMBOS(?,?,?,?,?,?,?,?,?,?,?); end;";            
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "L");
            cs.setString(3, nombreUsuario);
            cs.setString(4, "");
            cs.setString(5, "");
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
                objBeanU = new BeanUsuarioAD();
                objBeanU.setVUSUARIO_CODIGO(rs.getString(1));
                objBeanU.setCUSUARIO_COD_ORG(rs.getString(2));
                objBeanU.setVUSUARIO_CARGO(rs.getString(3));
                c.add(objBeanU);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return c;

    }

    @Override
    public Collection obtenerPeriodo() throws Exception {

        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_COMBOS(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "M");
            cs.setString(3, "");
            cs.setString(4, "");
            cs.setString(5, "");
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
                objBeanP = new BeanPeriodo();
                objBeanP.setCPERIODO_CODIGO(rs.getString(1));
                objBeanP.setVPERIODO_DEFINICION(rs.getString(2));
                objLista.add(objBeanP);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objLista;

    }

    @Override
    public Collection obtenerOrganizacionEjercito_MP() throws Exception {

        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_COMBOS(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "N");
            cs.setString(3, "");
            cs.setString(4, "");
            cs.setString(5, "");
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
                objBeanOI = new BeanOrganizacionInterna();
                objBeanOI.setVOINTERNA_NOM_CORTO(rs.getString(1));
                objBeanOI.setCOINTERNA_CODIGO(rs.getString(2));
                objLista.add(objBeanOI);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objLista;

    }

    @Override
    public Collection obtenerClaseDocumento() throws Exception {

        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_COMBOS(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "O");
            cs.setString(3, "");
            cs.setString(4, "");
            cs.setString(5, "");
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
                objClaseDoc = new BeanClase();
                objClaseDoc.setCCLASE_CODIGO(rs.getString(1));
                objClaseDoc.setVCLASE_NOM_LARGO(rs.getString(2));
                objLista.add(objClaseDoc);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objLista;

    }

    @Override
    public Collection obtenerClasificacion() throws Exception {

        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_COMBOS(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "P");
            cs.setString(3, "");
            cs.setString(4, "");
            cs.setString(5, "");
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
                objClaseDoc = new BeanClase();
                objClaseDoc.setCCLASE_CODIGO(rs.getString(1));
                objClaseDoc.setVCLASE_NOM_LARGO(rs.getString(2));
                objLista.add(objClaseDoc);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objLista;

    }
    
     @Override
    public Collection obtenerdDestinariosEP() throws Exception {

        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_COMBOS(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "Q");
            cs.setString(3, "");
            cs.setString(4, "");
            cs.setString(5, "");
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
                objBeanOI = new BeanOrganizacionInterna();
                objBeanOI.setVOINTERNA_NOM_CORTO(rs.getString(1));
                objBeanOI.setCOINTERNA_CODIGO(rs.getString(2));
                objLista.add(objBeanOI);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objLista;

    }
    
     @Override
    public Collection obtenerGrupo(String usuario) throws Exception {

        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_COMBOS(?,?,?,?,?,?,?,?,?,?,?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, "R");
            cs.setString(3, usuario);
            cs.setString(4, "");
            cs.setString(5, "");
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
                objBeanG = new BeanGrupo();
                objBeanG.setVGRUPO_COD(rs.getString(1));
                objBeanG.setVGRUPO_DESC_CORTA(rs.getString(2));
                objLista.add(objBeanG);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - " + getClass() + ": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objLista;

    }


}
