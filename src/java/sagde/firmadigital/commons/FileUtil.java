/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sagde.firmadigital.commons;

/**
 *
 * @author rrodasd
 */
/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import comun.Constante;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FileUtils;
import pe.mil.ejercito.alfresco_api.commons.AlfrescoProcess;
import pe.mil.ejercito.alfresco_api.commons.AlfrescoWebScripts;

/**
 *
 * @author rrodasd
 */
public class FileUtil {

    public static void createPathIfNotExist(String path) {
        File uploadDir = new File(path);
        if (!uploadDir.exists()) {
            uploadDir.mkdir();
        }
    }

    public static ServletFileUpload initServletFileUpload() {
        DiskFileItemFactory factory = new DiskFileItemFactory();
        factory.setSizeThreshold(Constante.THRESHOLD_SIZE);
        factory.setRepository(new File(System.getProperty("java.io.tmpdir")));

        ServletFileUpload upload = new ServletFileUpload(factory);
        upload.setFileSizeMax(Constante.MAX_FILE_SIZE);
        upload.setSizeMax(Constante.MAX_REQUEST_SIZE);

        return upload;
    }

    public static List<String> saveFiles(List<FileItem> formItems, String pathFolder) throws UnsupportedEncodingException, Exception {
        Iterator<FileItem> iter = formItems.iterator();
        List<String> filesSaved = new ArrayList<>();
        
        while (iter.hasNext()) {
            FileItem item = (FileItem) iter.next();
            if (!item.isFormField()) {
                String fileName = URLDecoder.decode(item.getName(), "UTF-8");
                String filePath = pathFolder + File.separator + fileName;
                File storeFile = new File(filePath);
                item.write(storeFile);
                filesSaved.add(fileName);
            }
        }
        
        return filesSaved;
    }
    
    public static String uploadToAlfresco(String pathFile, String nameFile, String contentType, String pathFolder) throws IOException, Exception{
        
        AlfrescoProcess ap = new AlfrescoProcess();
        String tokenID = ap.uploadDocuments(getBytes(pathFile), 
                            nameFile, 
                            contentType, 
                            "Archivo subido automáticamente por GEDAD", 
                            pathFolder, "", "");
        return tokenID;
    }
    
    public static byte[] getBytes(String pathFile) throws IOException{
        byte[] bytesFile = Files.readAllBytes(Paths.get(pathFile));
        return bytesFile;
    }

}

