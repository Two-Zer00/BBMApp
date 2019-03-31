<%-- 
    Document   : accountRegister
    Created on : 21-mar-2019, 23:47:31
    Author     : twozer00
--%>
<%@page import="com.models.jsonHandler"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <c:import url="partials/head.html"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/accountRegister.css" rel="stylesheet" type="text/css">
        <title>Alta de cuenta</title>
    </head>
    <body>
        <c:import url="partials/nav.html"/>
        
        <c:import url="partials/jsp/valSession.jsp"/>
        <%
            jsonHandler clientsList = new jsonHandler();
            JSONArray jsonArray = clientsList.readFile(clientsList.Mainpath+clientsList.clientsP);
            
            
        %>
        <section id="raForm">
            <h1>Alta de cuenta</h1>
            <form action="rac.do" method="post">
            <p><label>Numero de cliente: </label>
            <select name="nclient">
                <%
                for(int i=0; i<jsonArray.size();i++){
                    JSONObject cl = (JSONObject)jsonArray.get(i);
                    /*if(cl.get("account_number").toString().isEmpty()){
                        out.print("<option value="+"\""+cl.get("client_number")+"\""+">");
                        out.print(cl.get("client_number"));
                        out.print("</option>");
                    }*/
                    out.print("<option value="+"\""+cl.get("client_number")+"\""+">");
                    out.print(cl.get("client_number"));
                    out.print("</option>");
                }
                %></select></p>
                
            <p><label>Numero de cuenta: </label><input type="number" name="naccount" required disabled/></p>
            <p><label>Tipo: </label><select name="type">
                    <option value="debito">Debito</option>
                    <option value="credito">Credito</option>
                </select></p>
            <p><label>Monto: </label><input type="number" name="amount"/></p>
            <p><label>Fecha: </label><input type="date" name="date" /></p>
            <input type="submit" value="Guardar" />
            </form>
        </section>
    </body>
</html>
