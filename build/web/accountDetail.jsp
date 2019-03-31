<%-- 
    Document   : accountDetail
    Created on : 30/03/2019, 03:15:31 AM
    Author     : Usuario
--%>

<%@page import="org.json.simple.JSONArray"%>
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
           JSONArray acc = null;
           JSONObject acc1=null;
          
            
            String[] params= {request.getQueryString()};
            Boolean up=false;
            
            if(request.getQueryString()!=null && !params[0].contains("index")){
                Map<String, String> map = new HashMap<String, String>();  
                for (String param : params){  
                    String name = param.split("=")[0];  
                    String value = param.split("=")[1];  
                    map.put(name, value);
                }
               
                //up=true;
                pageContext.setAttribute("up", up);
                acc = val.accounts("",map.get("anumber"));
                acc1 = (JSONObject) acc.get(0);
                
            }
            else{
                
                acc =  val.accounts(cl.get("client_number").toString(), "");
                
                for(int i=0;i<acc.size();i++){
                    acc1=(JSONObject)acc.get(i);
                    out.print("<section id=\"raForm\"><h2>Detalles de la cuenta "+acc1.get("account_number")+"</h2><form>");
                    out.print("<p><label>Numero de cliente: </label><input type=\"text\" value="+acc1.get("client_number")+" disabled></p>");
                    out.print("<p><label>Numero de cuenta </label><input type=\"text\" value="+acc1.get("account_number")+" disabled></p>");
                    out.print("<p><label>Tipo: </label><input type=\"text\" value="+acc1.get("type")+" disabled></p>");
                    out.print("<p><label>Monto: </label><input type=\"number\" name=\"amount\" value="+acc1.get("amount")+" disabled/></p>");
                    out.print("<p><label>Fecha: </label><input type=\"date\" name=\"date\" value="+acc1.get("date")+" disabled /></p>");
                    out.print("</form></section><hr style=\"width:50%;\">");
                }
            }
            
        %>        
                    
    </body>
</html>
