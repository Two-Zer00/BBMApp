<%-- 
    Document   : clientRegister
    Created on : 21-mar-2019, 9:57:45
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
        <link href="css/ClientRegister.css" rel="stylesheet" type="text/css">
        <title>Alta de cliente</title>
    </head>
    <body>

        <c:import url="partials/jsp/valSession.jsp"/>
        <c:import url="partials/nav.html"/>
        <c:choose>
            <c:when test="${requestScope.passconfirm==false}">
                <p id="warning"><c:out value="Las contraseñas no son las mismas, verifique e ingrese de nuevo"/></p>
            </c:when>
            <c:when test="${requestScope.emptyF==false}">
                <p id="warning"><c:out value="Algunos de los campos estan vacios, favor de rellenar todos los campos"/></p>
            </c:when>
        </c:choose>
        <c:import url="partials/registerc/RegisterForm.html"/>
    </body>
</html>
