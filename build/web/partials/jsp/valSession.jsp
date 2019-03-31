

<%@page import="org.json.simple.JSONObject"%>
<%
JSONObject cl=null;
if(request.getSession().getAttribute("clientOb")!=null){
    cl = (JSONObject)request.getSession().getAttribute("clientOb");
    //out.print(cl.get("name"));
}
else{
    response.sendRedirect("index.jsp");
}
%>