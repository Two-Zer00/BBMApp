<%-- 
    Document   : transferList
    Created on : 30/03/2019, 02:27:18 AM
    Author     : Usuario
--%>

<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.models.transferList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <c:import url="partials/head.html"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/clientList.css" rel="stylesheet" type="text/css">
        <title>Transferencias</title>
    </head>
    <body>
         <c:import url="partials/jsp/valSession.jsp"/>
        <c:choose>
            <c:when test="${requestScope.red}">
                <c:redirect url="index.jsp"/>
            </c:when>
        </c:choose>
            
        <c:import url="partials/nav.html"/>
        
        <%
            transferList tl = new transferList();
            JSONObject temp =(JSONObject) request.getSession().getAttribute("clientOb");
            JSONArray jsonArray = tl.clientTransfers(temp.get("client_number").toString());
            
            
        %>
        <table>
            <tr>
                <th>Fecha</th>
                <th>Cuenta de Retiro</th>
                <th>Monto</th>
                <th>Cuenta de Deposito</th>
            </tr>
            <% 
            for (int i = 0 ; i< jsonArray.size();i++ ){
                JSONObject temp1 = (JSONObject) jsonArray.get(i);
                out.print("<tr>");
                out.print("<td>"+temp1.get("date")+"</td>"+"<td>"+temp1.get("retire_account")+"</td>"+"<td>"+temp1.get("amount")+"</td>"+"<td>"+temp1.get("deposit_account")+"</td>");
                out.print("</tr>");
                
            }
            
            %>
        </table>
    </body>
</html>
