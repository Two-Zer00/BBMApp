<%-- 
    Document   : clientDetails
    Created on : 22-mar-2019, 17:20:18
    Author     : twozer00
--%>
<%@page import="com.models.isClient"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <c:import url="partials/head.html"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/ClientRegister.css" rel="stylesheet" type="text/css">
        <title>Detalles</title>
    </head>
    <body>
        
        <c:import url="partials/nav.html"/>
        <%
            JSONObject cl=null;
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
                //out.print("hola");
                //out.print();
                isClient val = new isClient();
                up=true;
                pageContext.setAttribute("up", up);
                cl =val.client(map.get("cnumber"));
                if(cl.get("account_number")!=null){
                    acc=acc+cl.get("account_number").toString();
                    //out.print(acc);
                }
                else{
                    acc="no account number";
                }
            }
            else{
                if(request.getSession().getAttribute("clientOb")!=null){
                    cl = (JSONObject)request.getSession().getAttribute("clientOb");
                    if(cl.get("account_number")!=null){
                    acc=cl.get("account_number").toString();
                }
                else{
                    acc="123";
                }
                }
                else{
                    response.sendRedirect("index.jsp");
                }
            }
            
            
        %>
        
        <section id="formR">
            <c:choose>
                <c:when test="${pageScope.up}">
                    <c:set var="up" value="${true}" scope="request" />
                    <%request.getSession().setAttribute("up", true);    %>
                    <h2>Actualizando cliente</h2>
                    <form method="post" action="rc.do">
                <p><label>Nombre: </label><input type="text" name="name" value=<%out.print("\""+cl.get("name").toString()+"\" "+up);%>/></p>
                <p><label>Apellido: </label><input type="text" name="lname" value=<%out.print("\""+cl.get("last_name").toString()+"\"" +up);%>/></p>
                <p><label>Dirección: </label><input type="text" name="adress" value=<%out.print("\""+cl.get("adress").toString()+"\""+up);%> /></p>
                <p><label>Código postal: </label><input type="text" name="zipCode" pattern="[0-9]{5}" value=<%out.print("\""+cl.get("zip_code").toString()+"\""+up);%> /></p>
                <p><label>Ciudad: </label><input type="text" name="city"  value=<%out.print("\""+cl.get("city").toString()+"\""+up);%>/></p>
                <p><label>Estado: </label><input type="text" name="state"  value=<%out.print("\""+cl.get("state").toString()+"\""+up);%>/></p>
                <p><label>País: </label><input type="text" name="country"  value=<%out.print("\""+cl.get("country").toString()+"\""+up);%>/></p>
                <p><label>Teléfono: </label><input type="number" name="phone" value=<%out.print("\""+cl.get("phone").toString()+"\""+up);%>/></p>
                <p><label>E-mail: </label><input type="email" name="mail"  value=<%out.print("\""+cl.get("email").toString()+"\""+up);%>/></p>
                <p><label>Fecha de nacimiento: </label><input type="text" name="bdate" value=<%out.print("\""+cl.get("birth_date").toString()+"\""+up);%>/></p>
                <p><label>Número de cliente: </label><input type="text" name="ncliente" pattern="[0-9]{5}" value=<%out.print("\""+cl.get("client_number").toString()+"\"" +up);%>/></p>
                <p><label>Número de cuenta: </label><input type="text" name="naccount" pattern="[0-9]{5}" value=<%
                    out.print("\"");
                    out.print(acc);
                    out.print("\" ");
                    out.print(up);%>/></p>
                <p><label>Nueva contraseña: </label><input type="password" name="pass" value="0000" <%out.print(up);%>/></p>
                
                <c:choose>
                    <c:when test="${pageScope.up}">
                        <p><input type="submit" name="type" value=actualizar /></p>
                    </c:when>
                </c:choose>
            </form>
                </c:when>
                <c:otherwise>
                    <h2>Detalles del cliente</h2>
                    <form method="post" action="rc.do">
                <p><label>Nombre: </label><input type="text" name="name" value=<%out.print("\""+cl.get("name").toString()+"\"");%> disabled/></p>
                <p><label>Apellido: </label><input type="text" name="lname" value=<%out.print("\""+cl.get("last_name").toString()+"\"");%> disabled/></p>
                <p><label>Dirección: </label><input type="text" name="adress" value=<%out.print("\""+cl.get("adress").toString()+"\"");%> disabled/></p>
                <p><label>Código postal: </label><input type="number" name="zipCode" value=<%out.print("\""+cl.get("zip_code").toString()+"\"");%> disabled/></p>
                <p><label>Ciudad: </label><input type="text" name="city" disabled value=<%out.print("\""+cl.get("city").toString()+"\"");%>/></p>
                <p><label>Estado: </label><input type="text" name="state" disabled value=<%out.print("\""+cl.get("state").toString()+"\"");%>/></p>
                <p><label>País: </label><input type="text" name="country" disabled value=<%out.print("\""+cl.get("country").toString()+"\"");%>/></p>
                <p><label>Teléfono: </label><input type="number" name="phone"disabled value=<%out.print("\""+cl.get("phone").toString()+"\"");%>/></p>
                <p><label>E-mail: </label><input type="email" name="mail" disabled value=<%out.print("\""+cl.get("email").toString()+"\"");%>/></p>
                <p><label>Fecha de nacimiento: </label><input type="text" name="bdate" value=<%out.print("\""+cl.get("birth_date").toString()+"\"");%> disabled/></p>
                <p><label>Número de cliente: </label><input type="number" name="ncliente" disabled value=<%out.print("\""+cl.get("client_number").toString()+"\"");%>/></p>
                <p><label>Número de cuenta: </label><input type="number" name="ncliente"  disabled value=<%out.print("\""+acc+"\"");%>/></p>
                <c:choose>
                    <c:when test="${pageScope.up}">
                        <p><input type="submit" name="type" value=actualizar /></p>
                    </c:when>
                </c:choose>
            </form>
                </c:otherwise>
            </c:choose>
        </section>
    </body>
</html>
