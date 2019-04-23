<%-- 
    Document   : logout
    Created on : 22-mar-2019, 16:24:30
    Author     : twozer00
--%>

<%@page import="java.util.Arrays"%>
<%@page import="java.util.Optional"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Saliendo</title>
    </head>
    <body>
        <%
            String key = "client";
            /*Optional<String> n = Arrays.stream(request.getCookies())
                .filter(c -> key.equals(c.getName()))
                .map(Cookie::getValue)
                .findAny();*/
            
            System.out.println("\n-----Borrando cookies-----\n");
            Cookie cookie = new Cookie("client", "");
            cookie.setMaxAge(0);
            response.addCookie(cookie);
            Optional<String> n = Arrays.stream(request.getCookies())
                .filter(c -> key.equals(c.getName()))
                .map(Cookie::getValue)
                .findAny();
            
            System.out.println("\n-----cookies"+ n +"-----\n");
                
            
            if(request.getSession()!=null){
                /*Cookie cookie = new Cookie("client", "");
                cookie.setMaxAge(0);
                response.addCookie(cookie);
                
                System.out.println("\n-----SALIENDO-----\n"+n);*/
                request.getSession().invalidate();
                response.sendRedirect("../index.jsp");
            }
            else{
                response.sendRedirect("../index.jsp");
            }
        %>
    </body>
</html>
