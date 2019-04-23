<%-- 
    Document   : dashboard
    Created on : 21-mar-2019, 23:11:56
    Author     : twozer00
--%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="java.text.DateFormatSymbols"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.Date"%>
<%@page import="com.models.jsonHandler"%>
<%@page import="java.util.Optional"%>
<%@page import="java.util.Arrays"%>
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
        
        
        <c:choose>
            <c:when test="${requestScope.success==true}">
                <c:choose>
                    <c:when test="${requestScope.account_number!=null}">
                        <div class="notification">
                            <c:import url="/partials/notifications/newaccount.html"/>
                            <p id="result"><c:out value="No. de cuenta ${requestScope.account_number}"/></p>
                            <c:redirect url="dashboard.jsp"/>
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
                            <c:import url="/partials/notifications/transfer.html"/>
                            <c:redirect url="dashboard.jsp"/>
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
            String name = "";
            String key = "client";
            Optional<String> n = Arrays.stream(request.getCookies())
                .filter(c -> key.equals(c.getName()))
                .map(Cookie::getValue)
                .findAny();
            
            JSONObject cl=null;
            isClient val = new isClient();
            
            if(request.getSession().getAttribute("clientOb")==null){
                client = (JSONObject) val.accounts(n.get(), "").get(0);
            }
            
                  
            if(request.getSession().getAttribute("clientOb")!=null){
                client = (JSONObject)request.getSession().getAttribute("clientOb");
                name = client.get("name")+ " " + client.get("last_name");
                out.print("<div class=\"user\"><a id=\"title\" href=\"javascript:void(0)\" onClick=\"options()\" >Hola "+name+"<span id=\"triangle\">&#9650;</span></a>");
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
                <ul id="menu" class="menuD">
                    <li><a href="clientRegister.jsp">Alta de cliente</a></li>
                    <li><a href="accountRegister.jsp">Alta de cuenta</a></li>
                    <li><a href="clientList.jsp">Lista de clientes</a></li>
                    <li><a href="transfers.jsp">Transferencias</a></li>
                    <li><a href="transferList.jsp">Lista de transferencias</a></li>
                    <li><a href="accountDetail.jsp">Detalles de la cuenta</a></li>
                </ul>
            </c:when>
            <c:when test="${userC}">
                <ul id="menu" class="menuD">
                    <li><a href="transfers.jsp">Transferencias</a></li>
                    <li><a href="transferList.jsp">Lista de transferencias</a></li>
                    <li><a href="accountDetail.jsp">Detalles de la cuenta</a></li>
                </ul>
            </c:when>
        </c:choose>
        </div>
        
        <div class="headerDashboard">
            <section>
                <%
                    jsonHandler.setMainpath(getServletContext().getRealPath("/json"));
                    val = new isClient();
                    JSONObject account = (JSONObject) val.accounts(client.get("client_number").toString(), "").get(0);
                    out.print("<h1>Balance en la cuenta "+ account.get("account_number") +"</h1>");
                    out.print("<h2>$ "+account.get("amount")+" MXN</h2>");
                %>
            </section>
        </div>
        
        <div class="dateSelector" style="width: 80%; margin:auto;">
            <%
                Date today = new Date(); // Fri Jun 17 14:54:28 PDT 2016
                Calendar cal = Calendar.getInstance();
                int month = cal.get(Calendar.MONTH); // 5
                pageContext.setAttribute("month", month);
                DateFormatSymbols dts = new DateFormatSymbols();
            %>
            <h1>Seleccione el mes a revisar</h1>
            <label for="transfers">Mes</label>
            <select name="transerfs" id="transfers" onChange="chart(this.value)">
                <c:forEach var="i" begin="0" end="${month}" step="1">
                    <c:choose>
                        <c:when test="${i==month}">
                            <option value="${i}" selected><% out.print(dts.getMonths()[(int)pageContext.getAttribute("i")]); %></option>
                        </c:when>
                        <c:otherwise>
                            <option value="${i}"><% out.print(dts.getMonths()[(int)pageContext.getAttribute("i")]); %></option>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>
            </select>
        </div>
        
        <script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
        <div class="graphContainer" >
        <div class="loader" id="loader"></div> 
        <div class="graph"><canvas id="myChart"></canvas></div>
        </div>
        <script>
            var today = new Date();
            var days = [];
            chart(today.getMonth());
            
            function daysGenerator(n){
                console.log("Generador de dias " + n);
                days = [];
                for (var i=1;i<32;i++){
                if(i!==n){
                    days.push(i);
                    
                    console.log(n);
                }
                else{
                    days.push(i);
                    break;
                }
                }
                console.log("Dias "+days.toString());
            }
            
            function chart(month){
                document.getElementById("loader").style.display="block";
                console.log("-----------------------------");
                console.log("Grafica para el mes " + month );
                //daysGenerator();
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.onreadystatechange = function() {
                    if (this.readyState === 4 && this.status === 200) {
                        document.getElementById("loader").style.display="none";
                        var myObj = JSON.parse(this.responseText);
                        var total=0;
                        console.log("GENERANDO LAS TRANFERENCIAS HECHAS");
                        var tempObj = myObj.hechas;
                        var ammonts=[];
                        if(tempObj.toString()===""){
                            console.log("NULO");
                            for(var i=1;i<32;i++){
                                ammonts.push(0);
                            }
                        }
                        else{
                        for(var i=0;i<tempObj.length;i++){
                            var temp = tempObj[i];
                            var date = temp.date;
                            //console.log("TODAY"+today.getMonth());
                            var newdate = date.split("-").reverse().join("-");
                            var dateT = new Date(newdate);
                            console.log(dateT.getDate());
                            //console.log("----"+month + " y " +dateT.getMonth());
                            if(parseInt(month)===dateT.getMonth()){
                                daysGenerator(parseInt(dateT.getDate())+1);
                                //console.log(dateT + " " +temp.amount);
                                ammonts=[];
                                for(var o=1;o<32;o++){
                                    if(o!==dateT.getDate()+1){
                                        //days.push(o);
                                        console.log("no entra en el dia" + days[o]);
                                        ammonts.push(0);
                                    }
                                    else{
                                        //days.push(o);
                                        console.log("entro en el dia " + days[o]);
                                        total+=parseInt(temp.amount);
                                        
                                        break;
                                    }

                                }
                                console.log(total +" "+ ammonts.length);
                                ammonts.push(total);
                            }
                            else{
                                console.log("NO COINCIDE");
                            }

                        }
                    }
                        /* RECIBIDAS */
                        console.log("GENERANDO LAS TRANFERENCIAS RECIBIDAS");
                        var tempObj = myObj.recibidas;
                        var ammonts1=[];
                        if(tempObj.toString()===""){
                            console.log("NULO");
                            for(var i=1;i<32;i++){
                                ammonts1.push(0);
                            }
                        }
                        else{
                        for(var i=0;i<tempObj.length;i++){
                            var temp = tempObj[i];
                            var date = temp.date;
                            //console.log("TODAY"+today.getMonth());
                            var newdate = date.split("-").reverse().join("-");
                            var dateT = new Date(newdate);
                            console.log(dateT.getDate());
                            //console.log("----"+month + " y " +dateT.getMonth());
                            if(parseInt(month)===dateT.getMonth()){
                                daysGenerator(parseInt(dateT.getDate())+1);
                                //console.log(dateT + " " +temp.amount);
                                ammonts1=[];
                                for(var o=1;o<32;o++){
                                    if(o!==dateT.getDate()+1){
                                        //days.push(o);
                                        console.log("no entra en el dia" + days[o]);
                                        ammonts1.push(0);
                                    }
                                    else{
                                        //days.push(o);
                                        console.log("entro en el dia " + days[o]);
                                        total+=parseInt(temp.amount);
                                        
                                        break;
                                    }

                                }
                                console.log(total +" "+ ammonts1.length);
                                ammonts1.push(total);
                            }
                            else{
                                console.log("NO COINCIDE");
                            }

                        }
                        }
                        console.log(days.toString());
                        
                        var chart = new Chart(ctx, {
                        // The type of chart we want to create
                        type: 'line',

                        // The data for our dataset
                        data: {
                            labels: days,
                            datasets: [{
                                label: 'Monto total de las tranferencias realizadas en el mes',
                                borderColor: 'rgb(255,5,5)',
                                data: ammonts
                            },{
                                label: 'Monto total de las tranferencias recibidas en el mes',
                                borderColor: 'rgb(9,79,164)',
                                data: ammonts1
                            }]
                        
                        },

                        // Configuration options go here
                        options: {}
                        });
                    }
            
    
                };
                xmlhttp.open("GET", "trasferSv", true);
                xmlhttp.send();
                var ctx = document.getElementById('myChart').getContext('2d');
            }
            
            
            function generateNumber(json){
                for(var i=0;i<tempObj.length;i++){
                            var temp = tempObj[i];
                            var date = temp.date;
                            //console.log("TODAY"+today.getMonth());
                            var newdate = date.split("-").reverse().join("-");
                            var dateT = new Date(newdate);
                            console.log(dateT.getDate());
                            //console.log("----"+month + " y " +dateT.getMonth());
                            if(parseInt(month)===dateT.getMonth()){
                                daysGenerator(parseInt(dateT.getDate())+1);
                                //console.log(dateT + " " +temp.amount);
                                var ammonts=[];
                                for(var o=1;o<32;o++){
                                    if(o!==dateT.getDate()+1){
                                        //days.push(o);
                                        console.log("no entra en el dia" + days[o]);
                                        ammonts.push(0);
                                    }
                                    else{
                                        //days.push(o);
                                        console.log("entro en el dia " + days[o]);
                                        total+=parseInt(temp.amount);
                                        
                                        break;
                                    }

                                }
                                console.log(total +" "+ ammonts.length);
                                ammonts.push(total);
                            }
                            else{
                                console.log("NO COINCIDE");
                            }

                        }
            }
            
            /*
            
            //var today = new date();
            var ammont=0;
            
            var xmlhttp = new XMLHttpRequest();
            xmlhttp.onreadystatechange = function() {
              if (this.readyState === 4 && this.status === 200) {
                var myObj = JSON.parse(this.responseText);
                
                //document.getElementById("demo").innerHTML =
                // ;
                var total=0;
                for(var i=0;i<myObj.length;i++){
                    var temp = myObj[i];
                    var date = temp.date;
                    //console.log(date);
                    var newdate = date.split("-").reverse().join("-");
                    var dateT = new Date(Date.parse(newdate));
                    if(today.getMonth()===dateT.getMonth()){
                        console.log(dateT + " " +temp.amount);
                        var ammonts=[];
                        for(var o=0;o<31;o++){
                            if(o!==dateT.getDate()){
                                console.log("no entra");
                                ammonts.push(0);
                            }
                            else{
                                console.log("entro");
                                total+=parseInt(temp.amount);
                                break;
                            }
                            
                        }
                        console.log(total + ammonts.length);
                        ammonts.push(total);
                    }
                    
                }
                /*
                ammont = myObj[0].amount;
                
                var date = myObj[1].date;
                var newdate = date.split("-").reverse().join("-");
                var dateT = new Date(Date.parse(newdate));
                console.log(dateT);
                for(var i=0;i<31;i++){
                    if(i!==dateT.getDate()){
                        ammonts.push(0);
                    }
                    else{
                        ammonts.push(myObj[1].amount);
                    }
                }
                
                var chart = new Chart(ctx, {
                // The type of chart we want to create
                type: 'line',

                // The data for our dataset
                data: {
                    labels: days,
                    datasets: [{
                        label: 'Monto total de las tranferencias realizadas en el mes',
                        borderColor: 'rgb(9,79,164)',
                        data: ammonts
                    }]
                },

                // Configuration options go here
                options: {}
            });
                
              }
            };
            xmlhttp.open("GET", "trasferSv", true);
            //console.log(ammont);
            xmlhttp.send();
            var d= new Date();
            //var months = ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'];
            /*var days = [];
            for (var i=1;i<31;i++){
                if(i!==d.getDate()){
                    days.push(i);
                    console.log(d.getDate());
                }
                else{
                    days.push(i);
                    break;
                }
            }
            //console.log(ammont);
            var cant =100;*/
            var ctx = document.getElementById('myChart').getContext('2d');
            
            </script>
    </body>
    <script>
        document.getElementById("out").href="Logout";
        document.getElementById("out").innerText="Salir";
        function options(){
            var option = document.getElementById("menu");
            var trangle = document.getElementById("trangle");
            if(option.classList.contains('menu')){
                    option.className="menuD";
                    triangle.innerHTML="&#9650;";
                    option.style.display="none";
                    
                    
                }
                else{
                    option.className="menu";
                    triangle.innerHTML="&#9660;";
                    option.style.display="block";
                    
                }
            
        }
    </script>
</html>
