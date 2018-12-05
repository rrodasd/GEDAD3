/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comun;

import sagde.firmadigital.commons.BytesUtil;

/**
 *
 * @author rrodasd
 */
public class Constante {

   // public static final String PATH_PROPERTIES = "/data/gedad/gedad.properties";
    //public static final String PATH_PROPERTIESLOCAL = "C:\\data\\aws\\alfresco_api.properties";
    public static final String PATH_PROPERTIESLOCAL = "/data/gedad/gedad.properties";
   

    /**
     * PAREMTROS DE FIRMA DIGITAL
     */
    public static final String TOKEN_ID = "MjU2NTI0Mjk5MTk4NzkxOTM=";
    public static final String CLIENT_ID = "MjU2NTI0Mjk5MTk4NzkxOTQ=";
    //public static final String SERVER_PATH = "http://10.64.93.251:8084/GEDAD_2018";
    public static final String SERVER_PATH = "http://10.64.3.13:8080/GEDAD_2018";
    public static final String REASON = "Sistema GEDAD";
    public static final String DOWNLOAD_LOGO_URL = "/resources/iLogo1.png";
    public static final String DOWNLOAD_STAMP_URL = "/resources/iFirma1.png";
    public static final String UPLOAD_FILE_URL = "/servletUpload";
    public static final String IS_SIGNATURE_VISIBLE = "true";
    public static final String STAMP_APPEARANCE_ID = "0";
    public static final String PAGE_NUMBER = "0";
    public static final String POS_X = "300";
    public static final String POS_Y = "80";
    public static final String WIDTH = "100";
    public static final String FONT_SIZE = "8";
    public static final String DOC_FILTER = ".*FIR.*|.*FAU.*";
    public static final String TIMESTAMP = "false";
    public static final String MAZ_FILE_SIZE = BytesUtil.getBytesNumberFromMb(5);
   //public static final String GEDAD_TEMP_DIR       = "D:/GEDAD_TEMP_DIRECTORY";
   public static final String GEDAD_TEMP_DIR       = "/data/gedad/GEDAD_TEMP_DIRECTORY";
    public static final int THRESHOLD_SIZE         = BytesUtil.getBytesFromMb(3).intValue();
    public static final int MAX_FILE_SIZE          = BytesUtil.getBytesFromMb(10).intValue();
    public static final int MAX_REQUEST_SIZE       = BytesUtil.getBytesFromMb(10).intValue(); 
}
