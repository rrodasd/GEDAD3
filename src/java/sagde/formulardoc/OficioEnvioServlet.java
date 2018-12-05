package sagde.formulardoc;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import comun.DAOFactory;
import comun.FormularDocumentoDAO;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Base64.Decoder;
import java.util.Calendar;
import javax.servlet.http.HttpSession;
import sagde.bean.BeanCuerpoDocumento;
import sagde.bean.BeanDocumento;
import sagde.bean.BeanHistorialDocumento;
import sagde.bean.BeanUsuarioAD;

public class OficioEnvioServlet extends HttpServlet {

    Connection cn = null;
    public DAOFactory objDAOFact = DAOFactory.getDAOFactory(DAOFactory.ORACLE);

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        service(request, response);
    }

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession(true);
        BeanUsuarioAD objBeanU = (BeanUsuarioAD) session.getAttribute("usuario");

        String observacion = request.getParameter("observacion");
        String tipo = request.getParameter("tipo");
        String guarnicion = request.getParameter("guarnicion");
        String clave = request.getParameter("clave");
        String clasificacion = request.getParameter("clasificacion");
        String archivo = request.getParameter("archivo");
        String prioridad = request.getParameter("prioridad");
        String interna = request.getParameter("interna");
        String nivelsuperior = request.getParameter("nivelsuperior");
        String asunto = request.getParameter("asunto");
        String firmante = request.getParameter("firmante");
        String accion = request.getParameter("accion");
        String cuerpo = request.getParameter("cuerpo");
        String revisor = request.getParameter("revisor");
        
        try {
            //Clase para Decodificar
            Decoder decoder = Base64.getDecoder();
            asunto = new String(decoder.decode(asunto));
            observacion = new String(decoder.decode(observacion));
            cuerpo = new String(decoder.decode(new String(decoder.decode(cuerpo))));
            //Generando los parametros que no fueron recibidos
            Calendar fecha_cal = Calendar.getInstance();
            String periodo = fecha_cal.get(java.util.Calendar.YEAR) + "";
            //Llenando BeanDocumento
            BeanDocumento objBeanD = new BeanDocumento();
            objBeanD.setPeriodo(periodo);
            objBeanD.setTipoOrganizacion(tipo);
            objBeanD.setCodigoOrganizacion(objBeanU.getCUSUARIO_COD_ORG());
            objBeanD.setClase("0001");//CODIGO QUE IDENTIFICA AL OFICIO
            objBeanD.setClave(clave);
            objBeanD.setArchivo(archivo);
            objBeanD.setClasificacion(clasificacion);
            objBeanD.setPrioridad(prioridad);
            objBeanD.setAsunto(asunto);
            objBeanD.setUsuario(objBeanU.getVUSUARIO_CODIGO());
            objBeanD.setCodigoOrganizacionDep(interna);
            objBeanD.setCodigoOrganizacionNiv(nivelsuperior);
            objBeanD.setGuarnicion(guarnicion);
            objBeanD.setV_firma_usuario(firmante);
            objBeanD.setV_tipo_accion(accion);

            //Llenando BeanCuerpo
            BeanCuerpoDocumento objBeanCD = new BeanCuerpoDocumento();
            objBeanCD.setLCDOCUMENTO_CUERPO_DOC(cuerpo);

            //Llenando BeanHistorialDocumento
            BeanHistorialDocumento objBeanHD = new BeanHistorialDocumento();
            objBeanHD.setVHDOCUMENTO_COD_USUARIO(revisor);
            objBeanHD.setVHDOCUMENTO_OBERVACION(observacion);

            //Llenando Lista de Distribucion con la Sesion
            ArrayList distribucion = (ArrayList) session.getAttribute("distribucion");
            if (distribucion == null) {
                distribucion = new ArrayList();
            }

            //Llenando Lista de Referencia con la Sesion
            ArrayList referencia = (ArrayList) session.getAttribute("referencia");
            if (referencia == null) {
                referencia = new ArrayList();
            }

            //Llenando Lista de Anexos con la Sesion
            ArrayList anexo = (ArrayList) session.getAttribute("anexo");
            if (anexo == null) {
                anexo = new ArrayList();
            }

            //Se invoca al metodo del FormularDocumentoDAO
            DAOFactory objDAOFactory = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
            FormularDocumentoDAO objFD = objDAOFactory.getFormularDocumentoDAO();
            objFD.FormularDocumentoTransaction(objBeanD, objBeanCD, objBeanHD, distribucion, referencia, anexo);
            objFD.limpiaTemporales(objBeanU.getVUSUARIO_CODIGO(), objBeanU.getCUSUARIO_COD_ORG());
            
        } catch (SQLException e) {
            System.out.println("Error SQLE: " + e.toString());
        }finally{
            session.removeAttribute("distribucion");
            session.removeAttribute("referencia");
            session.removeAttribute("anexo");
        }
    }

}
