/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlets;

import com.models.RegisterTransfer;
import com.models.Transference;
import com.models.isClient;
import com.models.jsonHandler;
import com.models.transferList;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;
import java.util.Date;
import java.util.Optional;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpSession;
import org.json.simple.JSONArray;
import org.json.simple.parser.ParseException;

/**
 *
 * @author Usuario
 */
@WebServlet(name = "trasferSv", urlPatterns = {"/trasferSv"})
public class trasferSv extends HttpServlet {

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
            out.println("<title>Servlet trasferSv</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet trasferSv at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        response.setContentType("application/json;charset=UTF-8");
        String key = "client";
        Optional<String> n = Arrays.stream(request.getCookies())
            .filter(c -> key.equals(c.getName()))
            .map(Cookie::getValue)
            .findAny();
        System.out.println("The Cookies are: " + n.toString());
        if(n.isPresent()){
            jsonHandler.setMainpath(getServletContext().getRealPath("/json"));
            transferList tl = new transferList();
            isClient val = new isClient();
            JSONObject acc = (JSONObject) val.accounts(n.get(), "").get(0);
            //JSONObject temp =(JSONObject) request.getSession().getAttribute("clientOb");
            //JSONArray jsonArray = ;
            
            //JSONArray comb = tl.recieveAccountTransfers("asdasd").tl.clientTransfers("sdasda");
            
            //response.getWriter().write("{\"NUMEROS\":[{\"numero\":123},{\"numero\":123}]}");
            
            
            response.getWriter().write("{\"recibidas\":[");
            response.getWriter().write(tl.recieveAccountTransfers(acc.get("account_number").toString()).toString().replace("[", "").replace("]", ""));
            response.getWriter().write("],");
            
            response.getWriter().write("\"hechas\":[");
            response.getWriter().write(tl.clientTransfers(n.get()).toString().replace("[", "").replace("]", ""));
            response.getWriter().write("]}");
            
        }
        
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
        
        isClient val = new isClient();
        JSONArray accts = val.accounts("", request.getParameter("acc1"));
        JSONObject acc = (JSONObject) accts.get(0);
        if (Double.valueOf(acc.get("amount").toString()) > Double.valueOf(request.getParameter("amount"))){
            DateFormat d = new SimpleDateFormat("dd-MM-yyyy");
            JSONObject cl = (JSONObject)request.getSession().getAttribute("clientOb");
        
            Transference tf = new Transference();
            tf.setAcc1(request.getParameter("acc1"));
            tf.setAcc2(request.getParameter("acc2"));
            tf.setAmount(request.getParameter("amount"));
            tf.setNclient(cl.get("client_number").toString());
            tf.setDate(d.format(new Date()));

            RegisterTransfer rf = new RegisterTransfer();
            try {
                rf.RegTransfer(tf);
            } catch (FileNotFoundException | ParseException ex) {
                Logger.getLogger(trasferSv.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.setAttribute("TFSucces", true);
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/dashboard.jsp");
            dispatcher.forward(request,response);
        }
        else{
            request.setAttribute("TFSucces", false);
            RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/transfers.jsp");
            dispatcher.forward(request,response);
            
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
