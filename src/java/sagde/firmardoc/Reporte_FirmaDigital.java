package sagde.firmardoc;

import java.io.IOException;
import java.sql.Connection;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletRequestWrapper;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.nio.file.Files;
import java.nio.file.Paths;

import sagde.comun.OracleDBConn;

public class Reporte_FirmaDigital extends HttpServlet {

    private Connection getConnection() {
        OracleDBConn cnx = new OracleDBConn();
        return cnx.getConnection();
    }

    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpServletRequestWrapper srw = new HttpServletRequestWrapper(request);
        ServletOutputStream sous = response.getOutputStream();

        String cip = request.getParameter("uuid");
        String accion = request.getParameter("filename");
        System.out.println("reporteeeee " + cip + "-" + accion + "-");

        String ruta = srw.getRealPath("") + "/gedad/revisardoc/reporte/reportFirmaDigital.jrxml";
//        try {
//			JasperDesign diseno =JRXmlLoader.load(ruta);
//                        System.out.println("1");
//			JasperReport reporte=JasperCompileManager.compileReport(diseno);
//			Map prm = new HashMap();			
//			prm.put("CIP",cip);
//			prm.put("ACCION",accion);
//			//prm.put("RUTA",srw.getRealPath(""));
//			System.out.println("2");
//			Connection cn = getConnection();
//			byte[] byteStream=JasperRunManager.runReportToPdf(reporte,prm,cn);

        byte[] byteStream = Files.readAllBytes(Paths.get(new File("D:\\pdf_sign_2.pdf").toURI()));
        response.setContentType("application/pdf");
        response.setContentLength(byteStream.length);

        sous.write(byteStream);

        sous.close();

//		} catch (JRException e) {
//			// TODO Auto-generated catch block
//			e.printStackTrace();
//		} 
    }

}
