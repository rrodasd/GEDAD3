package comun;

import java.io.FileInputStream;
import java.sql.CallableStatement;
import java.sql.Connection;

import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

import oracle.jdbc.OracleTypes;
import sagde.bean.BeanAuxiliar;
import sagde.bean.BeanOrganizacionInterna;

import java.sql.PreparedStatement;
import java.io.*;
import java.sql.Types;

import sagde.comun.OracleDBConn;
import sagde.comun.Parametros;

public class OracleOrganizacionInternaDAO implements OrganizacionInternaDAO {

    Connection conn = null;
    CallableStatement cs = null;
    PreparedStatement pcs = null;
    BeanOrganizacionInterna objBeanOI = null;
    BeanAuxiliar objBeanA = null;
    ResultSet rs = null;

    private Connection getConnection() {
        OracleDBConn cnx = new OracleDBConn();
        return cnx.getConnection();
    }

    @Override
    public Collection obtenerFullOrgani(String codOrg) throws Exception {

        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            String query = "begin ? := SF_GET_ORG_INT_USU(?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, codOrg);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanOI = new BeanOrganizacionInterna();
                objBeanOI.setCOINTERNA_CODIGO(rs.getString(1));
                objBeanOI.setNOINTERNA_NIVEL(rs.getString(2));
                objBeanOI.setVOINTERNA_NOM_CORTO(rs.getString(3));
                objBeanOI.setVOINTERNA_NOM_LARGO(rs.getString(4));
                objBeanOI.setVOINTERNA_GUARNICION(rs.getString(5));
                objBeanOI.setVOINTERNA_CLAVE_INDIC(rs.getString(6));
                objBeanOI.setCOINTERNA_ESTADO(rs.getString(7));
                objBeanOI.setVOINTERNA_USU_JEFE(rs.getString(8));
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
    public BeanOrganizacionInterna obtenerOrganizacionInternaPK(String sCodigo) throws Exception {

        objBeanOI = new BeanOrganizacionInterna();
        try {
            conn = getConnection();
            String query = "begin ? := sf_get_orgint_filtro(?); end;";
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, sCodigo);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            if (rs.next()) {
                objBeanOI.setCOINTERNA_CODIGO(rs.getString(1));
                objBeanOI.setNOINTERNA_NIVEL(rs.getString(2));
                objBeanOI.setVOINTERNA_NOM_CORTO(rs.getString(3));
                objBeanOI.setVOINTERNA_NOM_LARGO(rs.getString(4));
                objBeanOI.setVOINTERNA_GUARNICION(rs.getString(5));
                objBeanOI.setVOINTERNA_CLAVE_INDIC(rs.getString(6));
                objBeanOI.setCOINTERNA_ESTADO(rs.getString(7));
                objBeanOI.setVOINTERNA_USU_JEFE(rs.getString(8));
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " - "+getClass()+": " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objBeanOI;

    }   
    
    @Override
    public void insertarOrganizacionInterna(BeanOrganizacionInterna entidad) throws Exception {

        try {
            conn = getConnection();
            cs = conn.prepareCall("{call SP_INS_ORG_INT(?,?,?,?,?,?,?,?)}");
            cs.setString(1, entidad.getCOINTERNA_CODIGO());
            cs.setString(2, entidad.getNOINTERNA_NIVEL());
            cs.setString(3, entidad.getVOINTERNA_NOM_CORTO());
            cs.setString(4, entidad.getVOINTERNA_NOM_LARGO());
            cs.setString(5, entidad.getVOINTERNA_GUARNICION());
            cs.setString(6, entidad.getVOINTERNA_CLAVE_INDIC());
            cs.setString(7, entidad.getCOINTERNA_ESTADO());
            cs.setString(8, entidad.getVOINTERNA_USU_JEFE());
            cs.executeUpdate();
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " " + e.toString());
        } finally {
            cs.close();
            conn.close();
        }

    }

    @Override
    public void actualizarOrganizacionInterna(BeanOrganizacionInterna entidad) throws Exception {

        try {
            conn = getConnection();
            cs = conn.prepareCall("{call SP_UPD_ORG_INT(?,?,?,?,?,?,?,?)}");
            cs.setString(1, entidad.getCOINTERNA_CODIGO());
            cs.setString(2, entidad.getNOINTERNA_NIVEL());
            cs.setString(3, entidad.getVOINTERNA_NOM_CORTO());
            cs.setString(4, entidad.getVOINTERNA_NOM_LARGO());
            cs.setString(5, entidad.getVOINTERNA_GUARNICION());
            cs.setString(6, entidad.getVOINTERNA_CLAVE_INDIC());
            cs.setString(7, entidad.getCOINTERNA_ESTADO());
            cs.setString(8, entidad.getVOINTERNA_USU_JEFE());
            cs.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            cs.close();
            conn.close();
        }

    }

    @Override
    public void eliminarOrganizacionInterna(String sCodigo) throws Exception {

        try {
            conn = getConnection();
            cs = conn.prepareCall("{call SP_DEL_ORG_INT(?)}");
            cs.setString(1, sCodigo);
            cs.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.toString());
        } finally {
            cs.close();
            conn.close();
        }

    }

    @Override
    public String verificarOrganizacionInternaPK(String sCodigo) throws Exception {

        String sRetorno = "";
        try {
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_VERIF_ORGINT(?); end;";
            String genericQuery = "{ call ? := SF_VERIF_ORGINT(?) }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, Types.VARCHAR);
            cs.setString(2, sCodigo);
            cs.execute();
            sRetorno = (String) cs.getObject(1);
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " " + e.toString());
        } finally {
            cs.close();
            conn.close();
        }
        return sRetorno;

    }

    @Override
    public Collection obtenerFullOrganif() throws Exception {

        Collection objLista = new ArrayList();
        try {
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_GET_ORGINT(); end;";
            String genericQuery = "{ call ? := SF_GET_ORGINT() }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanOI = new BeanOrganizacionInterna();
                objBeanOI.setCOINTERNA_CODIGO(rs.getString(1));
                objBeanOI.setNOINTERNA_NIVEL(rs.getString(2));
                objBeanOI.setVOINTERNA_NOM_CORTO(rs.getString(3));
                objBeanOI.setVOINTERNA_NOM_LARGO(rs.getString(4));
                objBeanOI.setVOINTERNA_GUARNICION(rs.getString(5));
                objBeanOI.setVOINTERNA_CLAVE_INDIC(rs.getString(6));
                objBeanOI.setCOINTERNA_ESTADO(rs.getString(7));
                objBeanOI.setVOINTERNA_USU_JEFE(rs.getString(8));
                objLista.add(objBeanOI);
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objLista;

    }

    @Override
    public boolean existeElemento(Collection c, BeanOrganizacionInterna bean) {

        Iterator iterator = c.iterator();
        while (iterator.hasNext()) {
            objBeanOI = (BeanOrganizacionInterna) iterator.next();
            if (objBeanOI.getCOINTERNA_CODIGO().trim().equals(bean.getCOINTERNA_CODIGO())) {
                return true;
            }
        }
        return false;

    }

    @Override
    public Collection obtenerOrganizacionInterna() throws SQLException {

        Collection c = new ArrayList();
        try {
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_GET_ORG_INTERNA(); end;";
            String genericQuery = "{ call ? := SF_GET_ORG_INTERNA() }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
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

    @Override
    public Collection obtenerUsuariosxNivelInf(String codOrganizacion) throws SQLException {

        Collection c = new ArrayList();
        try {
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_GET_USU_NIV_INF(?); end;";
            String genericQuery = "{ call ? := SF_GET_USU_NIV_INF(?) }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, codOrganizacion);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            while (rs.next()) {
                objBeanA = new BeanAuxiliar();
                objBeanA.setCodigo(rs.getString(1));
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

    @Override
    public void insertarUsuarioImg(String codigo, FileInputStream file) throws Exception {

        try {
            conn = getConnection();
            cs = conn.prepareCall("{call SP_UPD_USUARIOIMG(?,?)}");
            cs.setString(1, codigo);
            cs.setBinaryStream(2, file, file.available());
            cs.executeUpdate();
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " " + e.toString());
        } finally {
            cs.close();
            conn.close();
            file.close();
        }

    }

    @Override
    public void uu_imagen_insertar(String lm, FileInputStream streamEntrada) throws Exception {

        try {
            conn = getConnection();
            pcs = conn.prepareStatement("UPDATE SAGDE_ORGANIZACIONINTERNA SET BOINTERNA_SELLO = ? WHERE COINTERNA_CODIGO = ?");
            pcs.setString(2, lm);
            pcs.setBinaryStream(1, streamEntrada, streamEntrada.available());
            pcs.executeUpdate();
        } catch (IOException | SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " " + e.toString());
        } finally {
            pcs.close();
            conn.close();
            streamEntrada.close();
        }

    }

    @Override
    public BeanOrganizacionInterna obtener_Tit_Org_Consulta(String codOrganizacion) throws Exception {

        objBeanOI = new BeanOrganizacionInterna();
        try {
            conn = getConnection();
            boolean useOracleQuery = true;
            String oracleQuery = "begin ? := SF_GET_CONS_ORG_TIT(?); end;";
            String genericQuery = "{ call ? := SF_GET_CONS_ORG_TIT(?) }";
            String query = useOracleQuery ? oracleQuery : genericQuery;
            cs = conn.prepareCall(query);
            cs.registerOutParameter(1, OracleTypes.CURSOR);
            cs.setString(2, codOrganizacion);
            cs.execute();
            rs = (ResultSet) cs.getObject(1);
            if (rs.next()) {
                objBeanOI = new BeanOrganizacionInterna();
                objBeanOI.setVOINTERNA_NOM_LARGO(rs.getString(1));
                objBeanOI.setVOINTERNA_NOM_CORTO(rs.getString(2));
            }
        } catch (SQLException e) {
            System.out.println(Parametros.S_APP_NOMBRE + " " + e.toString());
        } finally {
            rs.close();
            cs.close();
            conn.close();
        }
        return objBeanOI;

    }

}
