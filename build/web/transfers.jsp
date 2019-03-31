<%-- 
    Document   : transfers
    Created on : 22-mar-2019, 2:09:01
    Author     : twozer00
--%>

<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.models.isClient"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        
        <c:import url="partials/head.html"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/transfers.css" rel="stylesheet" type="text/css">
        <title>Transferencias</title>
    </head>
    <body>
        <c:import url="partials/jsp/valSession.jsp"/>
               
        <c:import url="partials/nav.html"/>
        <section id="transForm">
            <h2>Transferencias</h2>
        <form method="post" action="transfer.do">
            <table>
                <tr>
                    <td id="title"><p>Cuentas</p></td>
                    <td><fieldset>
                        <p>Cuenta de Retiro</p>
                        <select name="acc1">
                            <%
                                JSONObject cl =(JSONObject) request.getSession().getAttribute("clientOb");
                                isClient val = new isClient();
                                JSONArray accts = val.accounts(cl.get("client_number").toString(),"");
                                for(int i=0;i<accts.size();i++){
                                    JSONObject acc=(JSONObject)accts.get(i);
                                    out.print("<option value =\""+acc.get("account_number")+"\">"+ acc.get("account_number")+"</option>");
                                }
                            %>
                        </select>
                            <br>
                        <p>Cuenta de Destino</p>
                        <input name="acc2" type="number" maxlength="5" minlength="5">
                    </fieldset></td>
                </tr>
            </table>
            
            <table>
                <td id="title"><p>Datos de la transferencia</p></td>
                <td>
                    <fieldset>
                    <p>Importe MXN</p>
                    <input name="amount" type="number">
                    </fieldset>
                </td>
            </table>
            
           
            <input type="submit" value="transferir"> 
            
        </form>
    </section>
        
        
    </body>
</html>
