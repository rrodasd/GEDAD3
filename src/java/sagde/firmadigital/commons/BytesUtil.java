/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package sagde.firmadigital.commons;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import org.apache.commons.io.IOUtils;

/**
 *
 * @author rrodasd
 */
public class BytesUtil {
    public static String getBytesNumberFromMb(int mb){
        return getBytesFromMb(mb).toString();
    }
    
    public static Long getBytesFromMb(int mb){
        return 1024*1024*mb*1L;
    }
    
    public static byte[] getBytes(InputStream stream) throws IOException{
        return IOUtils.toByteArray(stream);
    }
    
    public static void copy(byte[] source, OutputStream target) throws IOException{
        InputStream is = new ByteArrayInputStream(source);
        IOUtils.copy(is, target);
    }
}
