package sagde.formulardoc;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;
import comun.DAOFactory;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.List;
import javax.servlet.http.HttpSession;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.design.JasperDesign;
import net.sf.jasperreports.engine.xml.JRXmlLoader;
import sagde.bean.BeanDistribucion;
import sagde.bean.BeanUsuarioAD;
import sagde.comun.OracleDBConn;
import sagde.comun.Util;

public class OficioVPServlet extends HttpServlet {

    Connection cn = null;
    public DAOFactory objDAOFact = DAOFactory.getDAOFactory(DAOFactory.ORACLE);

    private Connection getConnection() {
        OracleDBConn cnx = new OracleDBConn();
        return cnx.getConnection();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        service(request, response);
    }
    
    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        HttpServletRequestWrapper srw = new HttpServletRequestWrapper(request);
        Decoder decoder = Base64.getDecoder();
        HttpSession session = request.getSession(true);
        
        String ruta = "";
        String orgint_origen = request.getParameter("orgint_origen");
        String nombreanio = request.getParameter("nombreanio");
        String guarnicion = request.getParameter("guarnicion");        
        String fecha = request.getParameter("fecha");
        String orgint_redacta = request.getParameter("orgint_redacta");
        String archivo = request.getParameter("archivo");
        String grado_distribucion = request.getParameter("grado_distribucion");
        String cargo_distribucion = request.getParameter("cargo_distribucion");
        String cargo_firmante = request.getParameter("cargo_firmante");
        String asunto = request.getParameter("asunto");
        String cuerpo = request.getParameter("cuerpo");
        //String cuerpo = (String) session.getAttribute("cuerpo");
        orgint_origen = new String(decoder.decode(orgint_origen));
        nombreanio = new String(decoder.decode(nombreanio));
        guarnicion = new String(decoder.decode(guarnicion));
        fecha = new String(decoder.decode(fecha));
        orgint_redacta = new String(decoder.decode(orgint_redacta));
        archivo = new String(decoder.decode(archivo));
        grado_distribucion = new String(decoder.decode(grado_distribucion));
        cargo_distribucion = new String(decoder.decode(cargo_distribucion));
        cargo_firmante = new String(decoder.decode(cargo_firmante));
        asunto = new String(decoder.decode(asunto));
        cuerpo = new String(decoder.decode(new String(decoder.decode(new String(decoder.decode(cuerpo))))));
        
        List lista = (List)session.getAttribute("distribucion");
        
        List listaOrig = new ArrayList();
        List listaCC = new ArrayList();
        BeanDistribucion objBeanD = new BeanDistribucion();
        for (int i = 0; i < lista.size(); i++) {
            objBeanD = (BeanDistribucion) lista.get(i);
            if(objBeanD.getTipo()!=null){
                if(objBeanD.getTipo().equals("T")){
                    listaOrig.add(objBeanD);
                }
            }else{
                listaCC.add(objBeanD);
            }
        }
        JRBeanCollectionDataSource objJRBOrig = new JRBeanCollectionDataSource(listaOrig);
        JRBeanCollectionDataSource objJRBCC = new JRBeanCollectionDataSource(listaCC);
        ruta = srw.getRealPath("") + "/gedad/formulardoc/I_OficioVP.jrxml";
        BeanUsuarioAD objBeanAD = (BeanUsuarioAD)session.getAttribute("usuario");
        String slash = Util.slash();
        try {
            JasperDesign diseno = JRXmlLoader.load(ruta);
            JasperReport reporte = JasperCompileManager.compileReport(diseno);
            Map prm = new HashMap();
            prm.put("RUTA", srw.getRealPath(""));
            prm.put("ORGINT-ORIGEN", orgint_origen);
            prm.put("NOMBREANIO", nombreanio);
            prm.put("GUARNICION", guarnicion);
            prm.put("FECHA", fecha);            
            prm.put("ORGINT-REDACTA", orgint_redacta);
            prm.put("ARCHIVO", archivo);
            prm.put("GRADO-DISTRIBUCION", grado_distribucion);
            prm.put("CARGO-DISTRIBUCION", cargo_distribucion);
            prm.put("ASUNTO", asunto);
            prm.put("CUERPO", cuerpo);
            prm.put("DISTRIBUCION_ORIG", objJRBOrig);
            prm.put("DISTRIBUCION_CC", objJRBCC);
            prm.put("SLASH", slash);
            prm.put("CARGO-FIRMANTE", cargo_firmante);
            prm.put("USUARIO", objBeanAD.getVUSUARIO_CODIGO());
            prm.put("INTERNA", objBeanAD.getCUSUARIO_COD_ORG());
            
            cn = getConnection();            
            byte[] Byte = JasperRunManager.runReportToPdf(reporte, prm, cn);
            String pdfBase64 = new String( Base64.getEncoder().encode(Byte), StandardCharsets.UTF_8 );
            response.setContentType("text/plain");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(pdfBase64);
            cn.close();
        } catch (JRException e) {
            System.out.println("Error JRE: "+e.toString());
        } catch (SQLException e) {
            System.out.println("Error SQLE: "+e.toString());
        }
    }
    
}