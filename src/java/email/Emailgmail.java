package email;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class Emailgmail {
    
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
    
    public boolean enviarcorreo(String cip,String para) throws UnsupportedEncodingException, Exception {
        
        //String de, String clave, , 
        boolean enviado = false;
        //de = "desis.ti";
        String FROM = "desis.ti@ejercito.mil.pe";
        String FROMNAME = "DEPARTAMENTO DE SISTEMAS - CINFE";
        String TO = para;
         System.out.println("-TO----:"+para);
        String SMTP_USERNAME = "desis.ti";
        String SMTP_PASSWORD = "Sised20D";
        
        String pwd = codificaClave();
        String mensaje = "Su nueva clave es: "+pwd+" Esta debera ser cambiada la proxima vez que ingrese al sistema."; 
        String asunto = "Cambio de Clave SCV - Planillas";
        
        int PORT = 587;
        
        try {

            String host = "d138-1110.ep.mil.pe";
                        
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
            transport.connect(host, SMTP_USERNAME, SMTP_PASSWORD);
             System.out.println("-8-----:");
            transport.sendMessage(msg, msg.getAllRecipients());
             System.out.println("-9-----:");
            transport.close();
             System.out.println("-10-----:");
            enviado = true;
             System.out.println("-11-----:");
             /*
              DAOFactory daoFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
    UsuarioDAO objU = daoFactory.getUsuarioDAO();
    BeanUsuarioSCV objBeanU = null;
             objBeanU = objU.restableceClaveAleatoria(cip,pwd);
*/
        } catch (MessagingException e) {
            System.out.println("Error en Email: "+e.toString()+"x");
        }
        return enviado;

    }

}