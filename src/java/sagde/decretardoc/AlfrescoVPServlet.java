package sagde.decretardoc;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import pe.mil.ejercito.alfresco_api.commons.AlfrescoProcess;
import pe.mil.ejercito.alfresco_api.commons.PropertiesUtil;
import static comun.Constante.*;
import javax.servlet.ServletContext;

public class AlfrescoVPServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // PropertiesUtil pUtil = new PropertiesUtil(PATH_PROPERTIES);
        PropertiesUtil pUtil = new PropertiesUtil(PATH_PROPERTIESLOCAL);

        AlfrescoProcess ap = new AlfrescoProcess();
        String token = request.getParameter("token");
        String archivo = request.getParameter("archivo");
        
        byte[] Byte = ap.obtenerBytes(token);
        
        ServletContext context = getServletContext();

        String mimeType = context.getMimeType(archivo);
        
        if (mimeType == null) {
            mimeType = "application/octet-stream";
        }
        // set content properties and header attributes for the response
        response.setContentType(mimeType);
        String headerKey = "Content-Disposition";
        String headerValue = String.format("inline; filename=\"%s\"", archivo);
        response.setHeader(headerKey, headerValue);

        // writes the file to the client
        ServletOutputStream out2 = response.getOutputStream();
        out2.write(Byte);
        
    }

}
