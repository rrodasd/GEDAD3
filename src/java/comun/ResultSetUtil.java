/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comun;

import java.sql.ResultSet;
import static comun.StringUtil.*;
import java.sql.SQLException;

/**
 *
 * @author rrodasd
 */
public class ResultSetUtil {
    
    ResultSet rs;
    
    public ResultSetUtil(ResultSet rs){
        this.rs = rs;
    }
    
    public Integer getInt(String key, Integer defaultValue){
        if( isEmpty(key) ){
            return null;
        }
        
        try{
            return rs.getInt(key);
        }catch(SQLException e){
            return defaultValue;
        }
    }
    
    public String getStr(String key, String defaultValue){
        if( isEmpty(key) ){
            return null;
        }
        
        try{
            return rs.getString(key);
        }catch(SQLException e){
            return defaultValue;
        }
    }
}
