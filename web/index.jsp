<%-- 
    Document   : index
    Created on : 21-mar-2019, 7:17:57
    Author     : twozer00
--%>

<%@page import="org.json.simple.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <c:import url="partials/head.html"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/index.css" rel="stylesheet" type="text/css">
        <title>Banco Mercantíl de México</title>
    </head>
    <body>
        <c:import url="partials/header.html"/>
        
        <c:choose>
            <c:when test="${requestScope.userVal==false}">
                <section id="warning">
                    <span class="icon-times"></span>
                    <p>El usuario que ha ingresado no es valido, intentelo de nuevo</p>
                </section>
            </c:when>
            <c:when test="${requestScope.emptyFields==false}">
                <section id="warning">
                    <span class="icon-times"></span>
                    <p>Los campos estan vacios</p>
                </section>
            </c:when>
        </c:choose>
        
        
        <c:choose>
            <c:when test="${sessionScope.clientOb!=null}">
                <%
                    response.sendRedirect("dashboard.jsp");
                %>
            </c:when>    
            <c:otherwise>
                <c:import url="partials/LoginForm.html"/>
            </c:otherwise>
        </c:choose>
        
        
    </body>
</html>
