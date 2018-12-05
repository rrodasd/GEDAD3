/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comun;


import static comun.StringUtil.*;

/**
 *
 * @author rrodasd
 */
public class GedadBase {
    
    private String temporalFileSystem;
    
    private static String SO_WINDOWS="Windows";
    private static String LINUX_TEMP_PATH = "/tmp/";
    private static String WINDOWS_TEMP_PATH = "c:\\tmp\\";
    
    public GedadBase(){
        init();
    }
    
    public void init(){
        
        String so = System.getProperty("os.name");
        System.out.println("so gedad --"+so);
        setTemporalFileSystem(LINUX_TEMP_PATH);
        
        if( isEq(so, SO_WINDOWS) ){
             System.out.println("sentro a winowwwwww --"+so);
            setTemporalFileSystem(WINDOWS_TEMP_PATH);
        }
System.out.println("se quedoooooooo a winowwwwww --"+so);
    }

    /**
     * @return the temporalFileSystem
     */
    public String getTemporalFileSystem() {
        return temporalFileSystem;
    }

    /**
     * @param temporalFileSystem the temporalFileSystem to set
     */
    public void setTemporalFileSystem(String temporalFileSystem) {
        this.temporalFileSystem = temporalFileSystem;
    }
}
