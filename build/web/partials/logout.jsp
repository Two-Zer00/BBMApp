<%-- 
    Document   : logout
    Created on : 22-mar-2019, 16:24:30
    Author     : twozer00
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Saliendo</title>
    </head>
    <body>
        <%
            //HttpSession session1 = (HttpSession)request.getSession();
            if(request.getSession()!=null){
                request.getSession().invalidate();
                response.sendRedirect("../index.jsp");
            }
            else{
                response.sendRedirect("../index.jsp");
            }
        %>
    </body>
</html>
