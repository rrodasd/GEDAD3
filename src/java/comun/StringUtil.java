/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package comun;

/**
 *
 * @author rrodasd
 */
public class StringUtil {
    
    public static final String[] NUMBERS = {"0", "1", "2", "3", "4", "5", "6", "7", "8", "9"};
    
    public static String unir(String... valores) {
        if (valores == null) {
            return null;
        }

        StringBuilder retorno = new StringBuilder("");
        for (String valor : valores) {
            retorno.append(valor);
        }

        return retorno.toString();
    }
    
    public static String createRandom(int length, String[] vars) {
        if (vars == null || length <= 0) {
            return null;
        }
        
        StringBuilder retorno = new StringBuilder("");
        int left = 0;
        while (left < length) {
            retorno.append(vars[getRandomNumber(0, vars.length-1)]);
            left++;
        }
        return retorno.toString();
    }
    
    public static int getRandomNumber(int start, int end){
        Long randomNumber = Math.round(start + (Math.random() * (end - start)));
        return randomNumber.intValue();
    }
    
    public static final boolean isEmpty(Object obj){
        
        if(obj==null){
            return true;
        }
        
        if(obj instanceof String){
            return obj.toString().isEmpty();
        }
        
        return false;
    }
    
    public static final boolean isEq(Object source, Object target){
        
        if( isEmpty(source) && isEmpty(target) ){
            return true;
        }
        
        if( isEmpty(source) || isEmpty(target) ){
            return false;
        }
        
        if((source instanceof String) && (target instanceof String)){
            return ((String)source).equals((String)target);
        }
        
        return false;
        
        
    }
    
    
    
    
}
