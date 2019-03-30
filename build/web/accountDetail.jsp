<%-- 
    Document   : accountDetail
    Created on : 30/03/2019, 03:15:31 AM
    Author     : Usuario
--%>

<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="com.models.isClient"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <c:import url="partials/head.html"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/accountRegister.css" rel="stylesheet" type="text/css">
        <title>Detalles de cuenta</title>
    </head>
    <body>
        <c:import url="partials/nav.html"/>
        <c:import url="partials/jsp/valSession.jsp"/>
        
        <%
            JSONObject cl = (JSONObject) request.getSession().getAttribute("clientOb");
            isClient val = new isClient();
            JSONObject acc1 = null;
            
            String[] params= {request.getQueryString()};
            Boolean up=false;
            String acc="";
            if(request.getQueryString()!=null){
                Map<String, String> map = new HashMap<String, String>();  
                for (String param : params){  
                    String name = param.split("=")[0];  
                    String value = param.split("=")[1];  
                    map.put(name, value);
                }
               
                up=true;
                pageContext.setAttribute("up", up);
                acc1 = val.account("",map.get("anumber"));
                
            }
            else{
                acc1 =  val.account(cl.get("client_number").toString(), "");
            }
            
        %>
        
        <section id="raForm">
            <h1>Detalles</h1>
            <form action="rac.do" method="post">
                <p><label>Numero de cliente: </label><input type="text" value="<%out.print(acc1.get("client_number"));  %>" disabled></p>
            <p><label>Numero de cuenta: </label><input type="number" name="naccount" value="<%out.print(acc1.get("account_number"));  %>" disabled /></p>
            <p><label>Tipo: </label><input type="text" value="<%out.print(acc1.get("type"));  %>" disabled></p>
            <p><label>Monto: </label><input type="number" name="amount" value="<%out.print(acc1.get("amount"));  %>" disabled/></p>
            <p><label>Fecha: </label><input type="date" name="date" value="<%out.print(acc1.get("date"));  %>" disabled /></p>
            
            </form>
        </section>
    </body>
</html>
