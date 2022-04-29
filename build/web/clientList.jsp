<%@page import="java.nio.charset.StandardCharsets"%>
﻿<%-- 
    Document   : clientList
    Created on : 22-mar-2019, 17:15:38
    Author     : twozer00
--%>


<%@page import="com.models.jsonHandler"%>
<%@page import="com.models.isClient"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.lang.Math"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
    <head>
        <c:import url="partials/head.html"/>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="css/clientList.css" rel="stylesheet" type="text/css">
        <title>Lista de clientes</title>
    </head>
    <body>
        <c:import url="partials/jsp/valSession.jsp"/>
        <c:choose>
            <c:when test="${requestScope.red}">
                <c:redirect url="index.jsp"/>
            </c:when>
        </c:choose>
        
        <%
            jsonHandler clientsList = new jsonHandler();
            isClient val = new isClient();
            JSONArray jsonArray = clientsList.readFile(clientsList.Mainpath+clientsList.clientsP);
            
            int pag =1;
            int el=0;
            int cont=4;
            if(request.getQueryString()!=null){
            String[] params= request.getQueryString().split("&");
                Map<String, String> map = new HashMap<String, String>();  
                for (String param : params){  
                    String name = param.split("=")[0];  
                    String value = param.split("=")[1];  
                    map.put(name, value);
                }
                //out.print("hola");
                //out.print();
                //isClient val = new isClient();
                //up=true;
                //pageContext.setAttribute("up", up);
                pag =Integer.parseInt(map.get("pag"));
                el =Integer.parseInt(map.get("elem"));
                if(pag<Integer.parseInt(map.get("pag"))){
                }
                cont=el+4;
            }
            else{
                el=0;
                cont=4;
            }
        %>
        <c:import url="partials/jsp/valSession.jsp"/>
        <c:import url="partials/nav.html"/>
        
        
        
        <table>
            <tr>
              <th>No. Cliente</th>
              <th>No. Cuenta</th>
              <th>Nombre</th>
              <th>Apellido</th>
              <th>Dirección</th>
              <th>Codigo postal</th>
              <th>Estado</th>
              <th>Ciudad</th>
              <th>Pais</th>
              <th>Teléfono</th>
              <th>Correo</th>
              <th>Fecha de nacimiento</th>
            </tr>
            <%
                for(int i=0; i<jsonArray.size();i++){
                    
                    
                    out.print("<tr>");
                    String accnum[]={};
                    JSONObject cl = (JSONObject)jsonArray.get(i);
                    /*if(val.accounts("", cl.get("account_number").toString()).size()>1){
                        JSONArray temp = val.accounts("", cl.get("account_number").toString());
                        for(int o=0;o<temp.size();o++){
                            accnum=accnum+", "+temp.get(i);
                        }
                    }*/
                    
                    if(cl.get("account_number")!=null&&val.accounts(cl.get("client_number").toString(), "").size()>=2){
                        
                        JSONArray temp = val.accounts(cl.get("client_number").toString(), "");
                        accnum=new String[temp.size()];
                        System.out.println("-------"+temp.size());
                        for(int o=0;o<temp.size();o++){
                            JSONObject tempO=(JSONObject)temp.get(o);
                            System.out.println(tempO.toJSONString());
                            accnum[o]=tempO.get("account_number").toString();
                        }
                        //accnum=cl.get("account_number").toString();
                    }
                    else if(cl.get("account_number")!=null){
                        accnum=new String[1];
                        accnum[0]=cl.get("account_number").toString();
                    }
                    
                    /*for(int o=0; o<=10;o++){*/
                        out.print("<td><a  href=clientDetails.jsp?cnumber="+ cl.get("client_number")+" title=\"Actualizar los datos del cliente\">"+ cl.get("client_number")+"</a></td>"
                        ); 
                        out.print("<td>");
                        if(accnum.length>=2){
                            for(int o=0;o<accnum.length;o++){
                                out.println("<a href=accountDetail.jsp?anumber="+ accnum[o]+" title=\"Actualizar los datos de la cuenta\">"+accnum[o]+"</a>");
                            }
                        }
                        else{
                            out.print("<a  href=accountDetail.jsp?anumber="+ accnum[0]+" title=\"Actualizar los datos de la cuenta\">"+accnum[0]+"</a>");
                        }
                        //encoding adress UTF-8
                        String adress = cl.get("adress").toString();
                        byte[] bytes = adress.getBytes(StandardCharsets.UTF_8);
                        String utf8String = new String(bytes);
                        
                        out.print("</td>");
                        out.print("<td>"+ cl.get("name")+"</td>"
                                + "<td>"+ cl.get("last_name")+"</td>"
                                + "<td>"+ (adress)+"</td>"
                                + "<td>"+ cl.get("zip_code")+"</td>"
                                + "<td>"+ cl.get("state")+"</td>"
                                + "<td>"+ cl.get("city")+"</td>"
                                + "<td>"+ cl.get("country")+"</td>"
                                + "<td>"+ cl.get("phone")+"</td>"
                                + "<td>"+ cl.get("email")+"</td>"
                                + "<td>"+ cl.get("birth_date")+"</td>");
                    out.print("</tr>");
                }
            %>
        </table>
        <p id="information"><span>&#8505;</span>Actualize los datos haciendo clic en los numeros de cliente/cuenta.</p>
        <div class="tableR">
            <%
                for(int i=0; i<jsonArray.size();i++){
                    out.print("<article>");
                    if(el<jsonArray.size()){
                    JSONObject cl = (JSONObject)jsonArray.get(i);
                    String accnum[]={};
                    if(cl.get("account_number")!=null&&val.accounts(cl.get("client_number").toString(), "").size()>=2){
                        
                        JSONArray temp = val.accounts(cl.get("client_number").toString(), "");
                        accnum=new String[temp.size()];
                        System.out.println("-------"+temp.size());
                        for(int o=0;o<temp.size();o++){
                            JSONObject tempO=(JSONObject)temp.get(o);
                            System.out.println(tempO.toJSONString());
                            accnum[o]=tempO.get("account_number").toString();
                        }
                        //accnum=cl.get("account_number").toString();
                    }
                    else if(cl.get("account_number")!=null){
                        accnum=new String[1];
                        accnum[0]=cl.get("account_number").toString();
                    }
                    out.print("<p>No. de cliente: "+ cl.get("client_number")+"</p>");
                    
                    out.print("<p>");
                        if(accnum.length>=2){
                            for(int o=0;o<accnum.length;o++){
                                out.println("<a href=accountDetail.jsp?anumber="+ accnum[o]+">"+accnum[o]+"</a>");
                            }
                        }
                        else{
                            out.print("<a  href=accountDetail.jsp?anumber="+ accnum[0]+">"+accnum[0]+"</a>");
                        }
                        out.print("</p>");
                    
                    out.print("<p>Nombre: "+ cl.get("name")+"</p>"
                            + "<p>Apellido: "+ cl.get("last_name")+"</p>"
                            + "<p>Direccion: "+ cl.get("adress")+"</p>"
                            + "<p>Codigo postal: "+ cl.get("zip_code")+"</p>"
                            + "<p>Estado: "+ cl.get("state")+"</p>"
                            + "<p>Ciudad: "+ cl.get("city")+"</p>"
                            + "<p>Pais: "+ cl.get("country")+"</p>"
                            + "<p>Telefono: "+ cl.get("phone")+"</p>"
                            + "<p>Correo: "+ cl.get("email")+"</p>"
                            + "<p>Fecha de nacimiento: "+ cl.get("birth_date")+"</p>"
                            + "<p>"+"<form action=\"updateCL\"><a href=clientDetails.jsp?cnumber="+""+cl.get("client_number")+""+">Editar</a>"+"</p>");
                    
                    out.print("</article><br><hr>");
                    el++;
                    }
                    else{break;}
                    
                }
                int numpag=(int)Math.ceil((jsonArray.size())/5.0);
                //out.print("Pagina: "+pag +" "+"<br>");
                %>
                
            </div>
                <section id="navpag">
                    <%/*
                        if(pag==1){
                            for(int o=pag;o<=numpag;o++){
                                out.print("<a href=\"clientList.jsp?pag="+o+"&elem="+el+"\">"+o+"</a>");
                                pag++;
                            }  
                        }
                        else if(pag>1){
                            for(int o=pag-1;o<=numpag;o++){
                                out.print("<a href=\"clientList.jsp?pag="+o+"&elem="+el+"\">"+o+"</a>");
                                pag++;
                            }
                         
                        }*/
                    %>
                </section>
        
        <script>
        </script>
    </body>
</html>
