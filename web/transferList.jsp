<%-- 
    Document   : transferList
    Created on : 30/03/2019, 02:27:18 AM
    Author     : Usuario
--%>

<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="com.models.transferList"%>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.*" %>
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
                <th class="position-relative"><a class="text-white text-decoration-none stretched-link" href="javascript:sortTable(0)">Fecha</a></th>
                <th class="position-relative"><a class="text-white text-decoration-none stretched-link" href="javascript:sortTable(1)">Cuenta de Retiro</a></th>
                <th class="position-relative"><a class="text-white text-decoration-none stretched-link" href="javascript:sortTable(2)">Monto</a></th>
                <th class="position-relative"><a class="text-white text-decoration-none stretched-link" href="javascript:sortTable(3)">Cuenta de Deposito</a></th>
            </tr>
            <%
                for (Object o : jsonArray) {
                    JSONObject temp1 = (JSONObject) o;
                    Calendar calendar = Calendar.getInstance();
                    //DateFormat df = DateFormat.getDateInstance(DateFormat.LONG, Locale.);
                    calendar.setTimeInMillis(Long.parseLong(temp1.get("date").toString()));
                    DateFormat formatter = new SimpleDateFormat("dd-MM-YY  hh:mm:ss z");
                    out.print("<tr>");
                    out.print("<td>" + formatter.format(calendar.getTime()) + "</td>" + "<td>" + temp1.get("retire_account") + "</td>" + "<td>" + temp1.get("amount") + "</td>" + "<td>" + temp1.get("deposit_account") + "</td>");
                    out.print("</tr>");
                }
            %>
        </table>
         <script>
             function sortTable(column) {
                 var table, rows, switching, i, x, y, shouldSwitch;
                 table = document.getElementsByTagName("table")[0];
                 switching = true;
                 /* Make a loop that will continue until
                 no switching has been done: */
                 while (switching) {
                     // Start by saying: no switching is done:
                     switching = false;
                     rows = table.rows;
                     /* Loop through all table rows (except the
                     first, which contains table headers): */
                     for (i = 1; i < (rows.length - 1); i++) {
                         // Start by saying there should be no switching:
                         shouldSwitch = false;
                         /* Get the two elements you want to compare,
                         one from current row and one from the next: */
                         x = rows[i].getElementsByTagName("TD")[column];
                         y = rows[i + 1].getElementsByTagName("TD")[column];
                         // Check if the two rows should switch place:
                         if (x.innerHTML.toLowerCase() > y.innerHTML.toLowerCase()) {
                             // If so, mark as a switch and break the loop:
                             shouldSwitch = true;
                             break;
                         }
                     }
                     if (shouldSwitch) {
                         /* If a switch has been marked, make the switch
                         and mark that a switch has been done: */
                         rows[i].parentNode.insertBefore(rows[i + 1], rows[i]);
                         switching = true;
                     }
                 }
             }
         </script>
    </body>
</html>
