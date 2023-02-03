/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlets;

import com.models.ClientNumber;
import com.models.RegisterClient;
import com.models.clients;
import com.models.isClient;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.ParseException;

/**
 *
 * @author twozer00
 */
@WebServlet(name = "Servlet1", urlPatterns = {"/Servlet1"})
public class Servlet1 extends HttpServlet {
    clients client = new clients();
    HttpSession UserSession;

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Cliente registrado</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>El cliente " + client.getName() + " ha sido regitrado exitosamente, con el numero de cliente"+client.getNclient()+"</h1>");
            out.println("<p>You will be redirected in <span id=\"counter\">10</span> second(s).</p>\n" +
                        "<script type=\"text/javascript\">\n" +
                        "function countdown() {\n" +
                        "    var i = document.getElementById('counter');\n" +
                        "    if (parseInt(i.innerHTML)<=0) {\n" +
                        "        location.href = 'dashboard.jsp';\n" +
                        "    }\n" +
                        "    i.innerHTML = parseInt(i.innerHTML)-1;\n" +
                        "}\n" +
                        "setInterval(function(){ countdown(); },1000);\n" +
                        "</script>");
            out.println("<a href='clientRegister.jsp'>Regresar</a>");
            out.println("</body>");
            out.println("</html>");
            
            request.getSession().removeAttribute("up");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Boolean up = (Boolean)request.getSession().getAttribute("up");
        //ClientNumber cn = new ClientNumber();
        //String cnw = cn.getNumber();
        System.out.println("----123"+up);
        Boolean k = false;
        //Map mp = request.getParameterValues();
        //request.getParameterValues(name)
        String[] keys={"name","lname","adress","zipCode","city","state","country","phone","bdate","mail","pass","role"};
        String temp="";
        int cont=0;
        
       
        
        if(up!=null){
            System.out.print("updating client number" + request.getParameter("ncliente"));
            client = new clients();
            client.setName(request.getParameter("name"));
            client.setLname(request.getParameter("lname"));
            client.setAdress(request.getParameter("adress"));
            client.setZip(request.getParameter("zipCode"));
            client.setCity(request.getParameter("city"));
            client.setState(request.getParameter("state"));
            client.setCountry(request.getParameter("country"));
            client.setTel(request.getParameter("phone"));
            client.setBdate(request.getParameter("bdate"));
            client.setEmail(request.getParameter("mail"));
            client.setNclient(request.getParameter("ncliente"));
            if(request.getParameter("pass").equals("0000")){
            client.setPass(null);
            }
            //client.setPass((String)request.getParameter("pass"));
            RegisterClient rc = new RegisterClient();
            try {
                rc.rc(client);
            } catch (FileNotFoundException | ParseException ex) {
                Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.setAttribute("successup",true);
            request.setAttribute("name", client.getName());
            request.setAttribute("client_number", client.getNclient());
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/dashboard.jsp");
            dispatcher.forward(request,response);
        }
        else{
            for(String key:keys){
                if (key.equals("role")){temp="user";}
                else{
                temp=request.getParameter(key);}
                System.out.println("///----///"+temp + key);
                if(temp.equals("")){
                    k=true;
                    break;
                }
                cont++;
            }
            if(!k&&request.getParameter("pass").equals(request.getParameter("cpass"))){
            System.out.print("adding new client");
            ClientNumber cn = new ClientNumber();
            System.out.println("K "+k+"CONT "+cont);
            JSONObject cl = (JSONObject)request.getSession().getAttribute("clientOb");
            if(!cl.get("role").equals("admin")){
                //response.sendError(403);
                response.sendRedirect("dashboard.jsp");
            }
            client = new clients();
            client.setName(request.getParameter("name"));
            client.setLname(request.getParameter("lname"));
            client.setAdress(request.getParameter("adress"));
            client.setZip(request.getParameter("zipCode"));
            client.setCity(request.getParameter("city"));
            client.setState(request.getParameter("state"));
            client.setCountry(request.getParameter("country"));
            client.setTel(request.getParameter("phone"));
            client.setBdate(request.getParameter("bdate"));
            client.setEmail(request.getParameter("mail"));
            client.setNclient(cn.getNumber());
            client.setPass((String)request.getParameter("pass"));
            RegisterClient rc = new RegisterClient();
            try {
                rc.rc(client);
            } catch (FileNotFoundException | ParseException ex) {
                Logger.getLogger(Servlet1.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.setAttribute("success",true);
            request.setAttribute("name", client.getName());
            request.setAttribute("client_number", client.getNclient());
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/dashboard.jsp");
            dispatcher.forward(request,response);
            //processRequest(request, response);
            
            }
            else{
                if(k){
                    request.setAttribute("emptyF",false);
                }else{
                    request.setAttribute("passconfirm", false);
                }
                
                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/clientRegister.jsp");
                dispatcher.forward(request,response);
            }
            
        }
    }
        
        

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
