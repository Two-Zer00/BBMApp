<%-- 
    Document   : dashboard
    Created on : 21-mar-2019, 23:11:56
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
        <link href="css/dashboard.css" rel="stylesheet" type="text/css">
        <title>Dashboard</title>
    </head>
    <body>
        <c:import url="partials/nav.html"/>
        <c:import url="partials/jsp/valSession.jsp"/>
        
        <c:choose>
            <c:when test="${requestScope.success==true}">
                <c:choose>
                    <c:when test="${requestScope.account_number!=null}">
                        <div class="notification">
                            <c:import url="/partials/notifications/newaccount.html"/>
                            <p id="result"><c:out value="No. de cuenta ${requestScope.account_number}"/></p>
                        </div>
                    </c:when>
                    <c:when test="${requestScope.client_number!=null}">
                        <div class="notification">
                            <c:import url="/partials/notifications/newclient.html"/>
                            <p id="result"><c:out value="No. de cliente ${requestScope.client_number}"/></p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="notification">
                            <c:import url="/partials/notifications/newclient.html"/>
                        </div>
                    </c:otherwise>
                </c:choose>
            </c:when>
            <c:when test="${requestScope.TFSucces==true}">
                        <div class="notification">
                            <c:import url="/partials/notifications/newaccount.html"/>
                            <p id="result"><c:out value="No. de cuenta ${requestScope.account_number}"/></p>
                        </div>
            </c:when>
            
            <c:when test="${requestScope.successup==true}">
                <div class="notification">
                    <c:import url="/partials/notifications/updatingclient.html"/>
                    <p id="result"><c:out value="No. de cliente ${requestScope.client_number}"/></p>
                </div>
            </c:when>
        </c:choose>
        
        <%
            JSONObject client=null;
            String name = "";/*
            JSONObject temp = (JSONObject)request.getSession().getAttribute("clientOb");
            if(request.getAttribute("client_number").equals(temp.get("client_number"))){
                request.getSession().removeAttribute("clientOb");
                isClient val = new isClient();
                request.getSession().setAttribute("clientOb", val.client((String)temp.get("client_number")));
            }
            
            */
            if(request.getSession().getAttribute("clientOb")!=null){
                client = (JSONObject)request.getSession().getAttribute("clientOb");
                name = client.get("name")+ " " + client.get("last_name");
                out.print("<h1 style=\"margin-left:20px;\">Hola "+name+"</h1>");
                if(client.get("role").equals("user")){
                    pageContext.setAttribute("userC", true);
                }
                else if(client.get("role").equals("admin")){
                    pageContext.setAttribute("adminC", true);

                }
            }
            else{
                response.sendRedirect("index.jsp");
            }
        %>
        <c:choose>
            <c:when test="${adminC}">
                <c:import url="partials/dashboard/adminMenu.html"/>
            </c:when>
            <c:when test="${userC}">
                <c:import url="partials/dashboard/userMenu.html"/>
            </c:when>
        </c:choose>
        
        
    </body>
    <script>
        document.getElementById("out").href="partials/logout.jsp";
        document.getElementById("out").innerText="Salir";
    </script>
</html>
