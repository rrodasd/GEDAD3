<%@page session="true"%>
<% 
    if(session.getAttribute("usuario")==null){
        response.sendRedirect(request.getContextPath()+"/logout");
    }
%>