package sagde.ad;

import java.util.Hashtable;
import javax.naming.Context;
import javax.naming.NamingException;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;



public class ActiveDirectoryDAO{
    
    static final String LDAP_URL = "ldap://d138-1001.ep.mil.pe:389/DC=ep,DC=mil,DC=pe";
    DirContext ctx;
    
    
    public boolean loginTCOS(String usuario, String clave) throws Exception {
        Hashtable env = new Hashtable();
        env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
        env.put(Context.PROVIDER_URL, LDAP_URL);
        env.put(Context.SECURITY_AUTHENTICATION, "simple");
        env.put(Context.SECURITY_PRINCIPAL, "CN="+usuario.toUpperCase()+ ",OU=TCOS, OU=CHASQUI, DC=ep,DC=mil,DC=pe");
        env.put(Context.SECURITY_CREDENTIALS, clave);
        try {
            ctx = new InitialDirContext(env);
            return true;
        }catch (NamingException ex) {
            
        }
        return false;
    }
    
    public boolean loginSSOO(String usuario, String clave) throws Exception {
        
        Hashtable env = new Hashtable();
        env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
        env.put(Context.PROVIDER_URL, LDAP_URL);
        env.put(Context.SECURITY_AUTHENTICATION, "simple");
        env.put(Context.SECURITY_PRINCIPAL, "CN="+usuario.toUpperCase()+ ",OU=SSOO, OU=CHASQUI, DC=ep,DC=mil,DC=pe");
        env.put(Context.SECURITY_CREDENTIALS, clave);
        try {
            ctx = new InitialDirContext(env);
            return true;
        }catch (NamingException ex) {
            
        }
        return false;
        
    }
    
    public boolean loginOFICIALES(String usuario, String clave) throws Exception {
        
        Hashtable env = new Hashtable();
        env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
        env.put(Context.PROVIDER_URL, LDAP_URL);
        env.put(Context.SECURITY_AUTHENTICATION, "simple");
        env.put(Context.SECURITY_PRINCIPAL, "CN="+usuario.toUpperCase()+ ",OU=OFICIALES, OU=CHASQUI, DC=ep,DC=mil,DC=pe");
        env.put(Context.SECURITY_CREDENTIALS, clave);
        try {
            ctx = new InitialDirContext(env);
            return true;
        }catch (NamingException ex) {
            
        }
        return false;
        
    }
    
    public boolean loginEECC(String usuario, String clave) throws Exception {
        
        Hashtable env = new Hashtable();
        env.put(Context.INITIAL_CONTEXT_FACTORY, "com.sun.jndi.ldap.LdapCtxFactory");
        env.put(Context.PROVIDER_URL, LDAP_URL);
        env.put(Context.SECURITY_AUTHENTICATION, "simple");
        env.put(Context.SECURITY_PRINCIPAL, "CN="+usuario.toUpperCase()+ ",OU=EECC, OU=CHASQUI, DC=ep,DC=mil,DC=pe");
        env.put(Context.SECURITY_CREDENTIALS, clave);
        try {
            ctx = new InitialDirContext(env);
            return true;
        }catch (NamingException ex) {
            
        }
        return false;
        
    }

}