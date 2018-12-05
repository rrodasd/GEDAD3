package sagde.ad;

import java.util.Hashtable;
import javax.naming.Context;
import javax.naming.NamingException;
import javax.naming.directory.Attribute;
import javax.naming.directory.Attributes;
import javax.naming.directory.DirContext;
import javax.naming.directory.InitialDirContext;


public class ActiveDirectory{
    
    static final String LDAP_URL = "ldap://d138-1001.ep.mil.pe:389/DC=ep,DC=mil,DC=pe";
    DirContext ctx;
    
    public Attribute cargarPropiedadConexion(String usuario, String atributo, String rango) {
        
        Attribute propiedad = null; 
        try {
            Attributes attrs = ctx.getAttributes("CN="+usuario.toUpperCase()+ ",OU="+rango+", OU=CHASQUI, DC=ep,DC=mil,DC=pe"); 
            if (attrs == null) {
                propiedad = null;
            } else {
                propiedad = attrs.get(atributo);
            }
        } catch (NamingException e) {
            System.out.println("Error en cargarPropiedadConexion x"+e.toString());
            propiedad = null;
        }
        return propiedad;
        
    }
    
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