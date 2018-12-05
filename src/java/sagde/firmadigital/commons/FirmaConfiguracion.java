/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sagde.firmadigital.commons;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import comun.Constante;
import comun.StringUtil;
import java.nio.charset.StandardCharsets;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

/**
 *
 * @author rrodasd
 */
public class FirmaConfiguracion {
    /**
     * Obtiene el protocolo a asignar para la firma
     * @param url
     * @return 
     */
    public static String getProtocolo(String url){
        return url.contains("https://")?"S":"T";
    }
    
    /**
     * Permite obtener los parametros para la firma web
     * @param protocolo Protocolo de comunicacion
     * @param urlPDF URL del pdf a descargar
     * @param serverPath Serverpath de la aplicación
     * @param pdfName Nombre del archivo pdf
     * @return 
     */
    public static String paramWeb(String protocolo, String urlPDF, String serverPath, String pdfName) throws JsonProcessingException{
         System.out.println("---------argumentos :protocol------"+protocolo+"--serverPath:>"+serverPath+"--documentName:>"+pdfName+"-urlPDF->"+urlPDF);
        
        ObjectMapper params = new ObjectMapper();
        Map<String, String> map = new HashMap<>();
           // map.put("idRegister", Constante.TOKEN_ID);            
            map.put("clientId",Constante.TOKEN_ID);            
            map.put("clientSecret", Constante.CLIENT_ID);
            map.put("idFile", StringUtil.createRandom(3, StringUtil.NUMBERS)); 
            map.put("type", "W"); 
            map.put("protocol", protocolo); 
            map.put("fileDownloadUrl", urlPDF);
           // map.put("fileDownloadUrl", StringUtil.unir(serverPath, "/documents/demo.pdf"));           
            map.put("fileDownloadLogoUrl", StringUtil.unir(serverPath, "/resources/iLogo1.png"));
            map.put("fileDownloadStampUrl", StringUtil.unir(serverPath, "/imagenes/icono/firma_digital.jpg"));
            map.put("fileUploadUrl", StringUtil.unir(serverPath, "/servletUpload"));      
            map.put("contentFile", "demo.pdf");
            map.put("reason", Constante.REASON);
            map.put("isSignatureVisible", Constante.IS_SIGNATURE_VISIBLE);             
            map.put("stampAppearanceId", Constante.STAMP_APPEARANCE_ID); 
            map.put("pageNumber", Constante.PAGE_NUMBER);
            map.put("posx", Constante.POS_X); 
            map.put("posy", Constante.POS_Y); 
            map.put("width", Constante.WIDTH);         
            map.put("fontSize", Constante.FONT_SIZE); 
            map.put("dcfilter", Constante.DOC_FILTER); 
            map.put("timestamp", Constante.TIMESTAMP);               
                map.put("outputFile", StringUtil.unir("res_", pdfName));    
            map.put("maxFileSize", Constante.MAZ_FILE_SIZE); 
        
        String stringParams = params.writeValueAsString(map);
        stringParams = Base64.getEncoder().encodeToString(stringParams.getBytes(StandardCharsets.UTF_8));
        System.out.println(stringParams);
        return stringParams;
        
    }
}
