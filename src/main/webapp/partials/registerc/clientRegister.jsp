<%@page import="org.json.simple.JSONObject"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    JSONObject cl = null;
%>
<form method="post" action="clientRegister.jsp">
    <p><label>Nombre: </label><input type="text" name="name" value=<%out.print("\""+cl.get("name").toString()+"\"");%> disabled/></p>
    <p><label>Apellido: </label><input type="text" name="lname" value=<%out.print("\""+cl.get("last_name").toString()+"\"");%> disabled/></p>
    <p><label>Direccion: </label><input type="text" name="adress" value=<%out.print("\""+cl.get("adress").toString()+"\"");%> disabled/></p>
    <p><label>Codigo postal: </label><input type="number" name="zipCode" value=<%out.print("\""+cl.get("zip_code").toString()+"\"");%> disabled/></p>
    <p><label>Ciudad: </label><input type="text" name="city" disabled value=<%out.print("\""+cl.get("city").toString()+"\"");%>/></p>
    <p><label>Estado: </label><input type="text" name="state" disabled value=<%out.print("\""+cl.get("state").toString()+"\"");%>/></p>
    <p><label>Pais: </label><input type="text" name="country" disabled value=<%out.print("\""+cl.get("country").toString()+"\"");%>/></p>
    <p><label>Telefono: </label><input type="number" name="phone"disabled value=<%out.print("\""+cl.get("phone").toString()+"\"");%>/></p>
    <p><label>E-mail: </label><input type="email" name="mail" disabled value=<%out.print("\""+cl.get("email").toString()+"\"");%>/></p>
    <p><label>Fecha de nacimiento: </label><input type="text" name="bdate" value=<%out.print("\""+cl.get("birth_date").toString()+"\"");%> disabled/></p>
    <p><label>Numero de cliente: </label><input type="number" name="ncliente" disabled value=<%out.print("\""+cl.get("client_number").toString()+"\"");%>/></p>
    <c:choose>
        <c:when test="${pageScope.up}">
            <p><input type="submit" name="type" value=actualizar /></p>
        </c:when>
    </c:choose>
</form>
