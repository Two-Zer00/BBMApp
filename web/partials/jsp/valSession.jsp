<%@page import="org.json.simple.JSONObject"%>
<%
    JSONObject cl=null;
    
    System.out.print("Validando sesion");
    if(request.getSession().getAttribute("clientOb")!=null){
        cl = (JSONObject)request.getSession().getAttribute("clientOb");
        System.out.print("Validado");
    }
    /*else if(n.isPresent()){
        cl=val.client(n.toString());
    }*/
    else{
        System.out.print("\n------SALIENDO----");
        request.setAttribute("red", true);
        response.sendRedirect("index.jsp");
    }
%>