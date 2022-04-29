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
                out.print("<div class=\"container-lg\"><h1 class='fw-bold'>Hola "+name+"</h1></div>");
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
<%--            <c:choose>--%>
<%--            <c:when test="${adminC}">--%>
<%--                <ul id="menu" class="menuD">--%>
<%--                    <li><a href="clientRegister.jsp">Alta de cliente</a></li>--%>
<%--                    <li><a href="accountRegister.jsp">Alta de cuenta</a></li>--%>
<%--                    <li><a href="clientList.jsp">Lista de clientes</a></li>--%>
<%--                    <li><a href="transfers.jsp">Transferencias</a></li>--%>
<%--                    <li><a href="transferList.jsp">Lista de transferencias</a></li>--%>
<%--                    <li><a href="accountDetail.jsp">Detalles de la cuenta</a></li>--%>
<%--                </ul>--%>
<%--            </c:when>--%>
<%--            <c:when test="${userC}">--%>
<%--                <div id="menu" class="menuD">--%>
<%--                    <a href="transfers.jsp">Transferencias</a>--%>
<%--                    <a href="transferList.jsp">Lista de transferencias</a>--%>
<%--                    <a href="accountDetail.jsp">Detalles de la cuenta</a>--%>
<%--                </div>--%>
<%--            </c:when>--%>
<%--        </c:choose>--%>
        </div>
        


        <div class="container-lg">

            <div class="border">
                    <%
                        jsonHandler.setMainpath(request.getServletContext().getRealPath("/json"));
                        val = new isClient();
                        //JSONObject account = (JSONObject) val.accounts(client.get("client_number").toString(), "").get(0);

                        JSONArray accounts = (JSONArray) val.accounts(client.get("client_number").toString(), "");
                        //JSONObject account = (JSONObject) val.accounts(client.get("client_number").toString(), "").get(0);
                        for(int i =0; i<accounts.size();i++){
                            JSONObject account = (JSONObject) accounts.get(i);
                            out.print("<div class='border rounded d-inline-block p-1 m-2'><p class='fw-bold '>Balance en No. de cuenta <a href='javascript:void(0)' onclick='updateAccount(\""+account.get("account_number")+"\")'>"+ account.get("account_number") +"</a></p>");
                            out.print("<p class='fw-bold m-0'>$ "+account.get("amount")+" MXN</p></div>");
                        }
                    %>
            </div>
            <div class="row mx-0 mt-2 mb-2">
                <div class="col-4 ps-0 pe-0 me-2 border">
                    <div class="list-group list-group-flush">
                    <c:choose>
                        <c:when test="${adminC}">
                            <a class="list-group-item list-group-item-action " href="clientRegister.jsp">Alta de cliente</a>
                            <a class="list-group-item list-group-item-action " href="accountRegister.jsp">Alta de cuenta</a>
                            <a class="list-group-item list-group-item-action " href="clientList.jsp">Lista de clientes</a>
                            <a class="list-group-item list-group-item-action " href="transfers.jsp">Transferencias</a>
                            <a class="list-group-item list-group-item-action " href="transferList.jsp">Lista de transferencias</a>
                            <a class="list-group-item list-group-item-action " href="accountDetail.jsp">Detalles de la cuenta</a>
                        </c:when>
                        <c:when test="${userC}">
                                <a class="list-group-item list-group-item-action" href="transfers.jsp">Transferencias</a>
                                <a class="list-group-item list-group-item-action" href="transferList.jsp">Lista de transferencias</a>
                                <a class="list-group-item list-group-item-action" href="accountDetail.jsp">Detalles de la cuenta</a>
                        </c:when>
                    </c:choose>
                    </div>
                </div>
                <div class="col ps-0 pe-0 border">
                    <div class="row">
                        <div class="col-4 d-flex justify-content-center">
                            <div class="text-center m-2">
                                <%
                                    Date today = new Date(); // Fri Jun 17 14:54:28 PDT 2016
                                    Calendar cal = Calendar.getInstance();
                                    int month = cal.get(Calendar.MONTH); // 5
                                    pageContext.setAttribute("month", month);
                                    DateFormatSymbols dts = new DateFormatSymbols();
                                %>
                                <p>Seleccione el mes a revisar</p>
                                <label for="transfers">Mes</label>
                                <select name="transerfs" id="transfers" onChange="chartA(this.value)">
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
                        </div>
                        <div class="col-8">
                            <div id="graphContainer" class="position-relative p-3">
                                <div class="position-absolute top-50 start-50 translate-middle">
                                    <div class="spinner-border text-primary" id="spinner" style="width: 10rem; height: 10rem;" role="status">
                                        <span class="visually-hidden">Loading...</span>
                                    </div>
                                </div>
                                <canvas id="myChart"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.5.1/chart.min.js"></script>

        <script>
            var ctx = document.getElementById('myChart');
            var today = new Date();
            var days = [];
            var myChart;
            let selectDate = document.getElementById('transfers').value;
            //let loader = document.getElementById('loader');
            let accN = ""+<% out.print("\""+((JSONObject)accounts.get(0)).get("account_number")+"\"");%> ;
            chartA(selectDate || today.getMonth());
            function updateAccount(accountNumber){
                accN = accountNumber;
                chartA(selectDate || today.getMonth(),accN);
            }

            function chartA(month,accountNumber){
                document.getElementById("spinner").classList.remove("d-none");
                if(accountNumber){
                    accN = accountNumber;
                }
                fetch('transfer.do?month='+month+'&accountNumber='+accN)
                    .then(response => response.json())
                    .then(data => {
                        loadChart(data, month);
                    });
            }

            function updateData(chart,newData) {
                chart.data.datasets[0].data = newData;
                chart.update();
                document.getElementById("spinner").classList.add("d-none");
            }

            function loadChart(data){
                var hechas = data.hechas;
                var recibidas = data.recibidas;
                //console.warn(typeof (hechas),hechas==0,typeof (recibidas),recibidas==0);
                if(document.getElementById('advise')){
                    document.getElementById('advise').remove();
                }
                if(hechas===0 && recibidas===0 && !document.getElementById('advise')){
                    console.log('advise');
                    let advise = document.createElement('div');
                    advise.id = 'advise';
                    advise.style.position = 'absolute';
                    advise.style.top = '50%';
                    advise.style.left = '50%';
                    advise.style.transform = 'translate(-50%,-50%)';
                    advise.textContent = 'No transactions made o received, try other month';
                    advise.style.textTransform = 'uppercase';
                    console.log(document.getElementById('graphContainer').appendChild(advise));
                }
                if(myChart){
                    //if(document.getElementById('advise')) document.getElementById('advise').remove();
                    console.log('updating chart',hechas,recibidas);
                    updateData(myChart,[hechas,recibidas]);
                    //loader.style.display = 'none';
                }else {
                    ctx = document.getElementById('myChart');
                    //daysGenerator(parseInt(new Date().getDate()));
                    //daysGenerator(parseInt(new Date().getDate()));
                    const dataA = {
                        labels: [
                            'Hechas',
                            'Recibidas',
                        ],
                        datasets: [{
                            label: 'Transacciones realizadas y recibidas(Montos totales)',
                            data: [hechas, recibidas],
                            backgroundColor: [
                                'rgb(9,79,164)',
                                'rgb(33,151,238)'
                            ],
                            borderColor:'rgba(121,121,121,0)',
                            spacing:1,
                            hoverOffset: 4
                        }]
                    };
                    const config = {
                        type: 'doughnut',
                        data: dataA,
                        options:
                            {
                                responsive: true,
                                maintainAspectRatio:true
                            }
                    };
                    myChart = new Chart(ctx, config);
                    //loader.style.display = 'none';
                    document.getElementById("spinner").classList.add("d-none");
                }
            }
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
