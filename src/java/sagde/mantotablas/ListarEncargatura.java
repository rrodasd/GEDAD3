package sagde.mantotablas;

import comun.DAOFactory;
import comun.EncargaturaDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import sagde.bean.BeanEncargatura;
import sagde.bean.BeanUsuarioAD;

public class ListarEncargatura extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response) {
        
        try {
            DAOFactory objDF = DAOFactory.getDAOFactory(DAOFactory.ORACLE);
            EncargaturaDAO objE = objDF.getEncargaturaDAO();
            
            HttpSession session = request.getSession(true);
            BeanUsuarioAD objBeanUAD = (BeanUsuarioAD) session.getAttribute("usuario");
            if (objBeanUAD == null) {
                getServletContext().getRequestDispatcher("/gedad/login/I_Login.jsp").forward(request, response);
            } else {
                ArrayList listaTipo = (ArrayList)objE.listarTipoEncargaturaxUsuario(objBeanUAD.getCUSUARIO_COD_ORG(), objBeanUAD.getVUSUARIO_CODIGO());
                String tipoEnviado = "";
                String codOrgEnc = "";
                for (int i = 0; i < listaTipo.size(); i++) {
                    BeanEncargatura objBeanE = (BeanEncargatura)listaTipo.get(i);
                    if(objBeanE.getCENCARGATURA_TIPO().equals("S")){
                        tipoEnviado = objBeanE.getCENCARGATURA_TIPO();
                        break;
                    } 
                    if(objBeanE.getCENCARGATURA_TIPO().equals("A")){
                        tipoEnviado = objBeanE.getCENCARGATURA_TIPO();
                        codOrgEnc = objBeanE.getCENCARGATURA_COD_ORG();
                    }
                }
                if(tipoEnviado.equals("")){
                    getServletContext().getRequestDispatcher("/menu").forward(request, response);
                }else{
                    request.setAttribute("tipoEnviado", tipoEnviado);
                    request.setAttribute("codOrgEnc", codOrgEnc);
                    getServletContext().getRequestDispatcher("/gedad/manto/I_Encargatura.jsp").forward(request,response);
                }              
            }
            
        } catch (ServletException ex) {
            Logger.getLogger(ListarEncargatura.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(ListarEncargatura.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(ListarEncargatura.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
