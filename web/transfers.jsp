<%-- 
    Document   : transfers
    Created on : 22-mar-2019, 2:09:01
    Author     : twozer00
--%>

<%@page import="com.models.isClient"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        
        <c:import url="partials/head.html"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Transferencias</title>
    </head>
    <body>
        <c:import url="partials/jsp/valSession.jsp"/>
               
        <c:import url="partials/nav.html"/>
        
        <form method="post" action="transfer.do">
            <fieldset>
                Cuenta de Retiro<br>
                <select name="acc1">
                    <%
                        JSONObject cl =(JSONObject) request.getSession().getAttribute("clientOb");
                        isClient val = new isClient();
                        JSONObject acc = val.account(cl.get("client_number").toString(),"");
                        
                        out.print("<option value =\""+acc.get("account_number")+"\">"+ acc.get("account_number")+"</option>");
                        
                        
                    %>
                </select>
                    <br>
                Cuenta de Destino<br>
                <input name="acc2" type="number" maxlength="5" minlength="5">
            </fieldset>
            <fieldset>
                Monto <br>
                <input name="amount" type="number">
                
            </fieldset>
               <input type="submit" value="transferir"> 
            
        </form>
        
        
    </body>
</html>
