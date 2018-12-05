package email;

import comun.DAOFactory;
import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import sagde.bean.BeanUsuarioAD;
import javax.servlet.http.HttpSession;

public class Email {
    
    public String codificaClave() throws Exception {
        
        String numero = Math.random()+"";
          System.out.println("-numero random-----:"+numero.length());
        MessageDigest md = MessageDigest.getInstance("MD5");
        byte[] b = md.digest(numero.getBytes());

        int size = b.length;
        System.out.println("-size-----:"+size);
        StringBuilder h = new StringBuilder(size);
        for (int i = 0; i < size; i++) {
            int u = b[i] & 255;
            if (u < 16) {
                h.append("0").append(Integer.toHexString(u));
            } else {
                h.append(Integer.toHexString(u));
            }
        }
         
        return h.toString().substring(1,9);
         
 //return h.toString().substring(1,8);
    }
    
    public boolean enviarcorreo(String cip,String para,String de,String asuntodoc,String apenom_rev,String grado_rev) throws UnsupportedEncodingException, Exception {
        
                
        
        //String de, String clave   
        boolean enviado = false;
        //de = "desis.ti";
        String FROM = "desis.ti@ejercito.mil.pe";
        String FROMNAME = "DEPARTAMENTO DE SISTEMAS - CINFE";
        String TO = para;
         System.out.println("-TO----:"+para);
        String SMTP_USERNAME = "desis.ti";
        String SMTP_PASSWORD = "Sised20D";
        
       // String pwd = codificaClave();
        //String mensaje = "Estimado(a): Tiene un documento Pendiente de Revisar con los siguinete detalles enviado por:"+de+" con el siguiente asunto:"+asuntodoc; 
        
        String mensaje ="<html><h3><font color='DE615E'>-----------------------------------Sistema GEDAD----------------------------</font></h3>" 
                    + "Estimado(a):"+grado_rev +"   "+apenom_rev
                    + "<p>Tiene un <b>documento Digital por REVISAR </b> con los siguiente detalles:</p>" 
                    + "Formulado por  :" +de+"<br>"
                    + "Asunto         :" +"<b>"+asuntodoc+"</b>"
                    + "<p>Revise sus bandeja de pendiente por Revisar del Sistema GEDAD, Ingrese-->>><a href='http://10.64.3.13:8080/GEDAD_RESTRU/'>http://10.64.3.13:8080/GEDAD_RESTRU/</a></p>" 
                    + "<h3><font color='DE615E'>-----------------------------------CINFE -DESIS -------------------------------------</font></h3>" 
                    + "</html>";
        String asunto = "Sistema GEDAD:: Tiene un Documento Digital Pendiente de Revisar";
        
        int PORT = 587;
        
        try {

            String host = "d138-1110.ep.mil.pe";
           // String host = "10.64.1.110";

                        
            Properties props = System.getProperties();
            props.put("mail.transport.protocol", "smtp");
            props.put("mail.smtp.port", PORT); 
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.auth", "true");
            
            Session session = Session.getDefaultInstance(props);
            System.out.println("-1-----:");
            MimeMessage msg = new MimeMessage(session);
             System.out.println("-2-----:");
            msg.setFrom(new InternetAddress(FROM,FROMNAME));
             System.out.println("-3-----:");
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(TO));
             System.out.println("-4-----:");
            msg.setSubject(asunto);
             System.out.println("-5-----:");
            msg.setContent(mensaje,"text/html");
         System.out.println("-6-----:");
           System.out.println("-HOST--:"+host+ "SMTP_USERNAME--"+SMTP_USERNAME+"SMTP_PASSWORD---"+SMTP_PASSWORD);
            
            Transport transport = session.getTransport();
             System.out.println("-7-----:");                      
            transport.connect(host, FROM, SMTP_PASSWORD);
             System.out.println("-8-----:");
            transport.sendMessage(msg, msg.getAllRecipients());
             System.out.println("-9-----:");
            transport.close();
             System.out.println("-10-----:");
            enviado = true;
             System.out.println("-11-----:");
             
             

        } catch (MessagingException e) {
            System.out.println("Error en Email: "+e.toString()+"x");
        }
        return enviado;

    }
    
    
 
    
    
    //-------------------------------empieza para enviar correo comercial
    
    
    public boolean enviarcorreoComercial(String cip,String para) throws UnsupportedEncodingException, Exception {
     
        boolean enviado = false;
        
       
        
        String pwd = codificaClave();
       
       
        
        try {

            String host = "173.194.202.108";
             Properties props = new Properties();
            props.setProperty("mail.smtp.host", "smtp.gmail.com");
            props.setProperty("mail.smtp.starttls.enable", "true");
            props.setProperty("mail.smtp.port", "587");
            props.setProperty("mail.smtp.auth", "true");
            
             Session session = Session.getDefaultInstance(props);
             
             
            String correoRemitente = "rrodasd@gmail.com";
            String passwordRemitente = "cekgeutmtovieway";
            String correoReceptor = "rrodasd@gmail.com";     
            String asunto = "Cambio de Clave SCV - Planillas";
            String mensaje = "Su nueva clave es: "+pwd+" Esta debera ser cambiada la proxima vez que ingrese al sistema."; 
            String FROMNAME = "DEPARTAMENTO DE SISTEMAS - CINFE";
                   
            System.out.println("-1-----:");
            MimeMessage msg = new MimeMessage(session);             
             System.out.println("-2-----:");
            msg.setFrom(new InternetAddress(correoRemitente,FROMNAME));            
             System.out.println("-3-----:");
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(correoReceptor));                      
             System.out.println("-4-----:");
            msg.setSubject(asunto);              
             System.out.println("-5-----:");
            msg.setContent(mensaje,"text/html");            
         System.out.println("-6-----:");
           System.out.println( "correoRemitente--"+correoRemitente+"passwordRemitente---"+passwordRemitente);
            
           
                    
            Transport transport = session.getTransport("smtp");            
             System.out.println("-7-----:");   
           
               transport.connect(host,correoRemitente, passwordRemitente);
            
             System.out.println("-8-----:");
            transport.sendMessage(msg, msg.getAllRecipients());
             System.out.println("-9-----:");
            transport.close();
             System.out.println("-10-----:");
            enviado = true;
             System.out.println("-11-----:");
             
   // DAOFactory daoFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
    //UsuarioDAO objU = daoFactory.getUsuarioDAO();
    //BeanUsuarioSCV objBeanU = null;
    //objBeanU = objU.restableceClaveAleatoria(cip,pwd);

        } catch (MessagingException e) {
            System.out.println("Error en Email: "+e.toString()+"x");
        }
        return enviado;

    }
    //-------->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    

}