<%@page session="true"%>
<% 
    if(session.getAttribute("usuario")==null){
        response.sendRedirect(request.getContextPath()+"/login/frm_sief_login.jsp");
    }
%>