/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlets;

import com.models.RegisterTransfer;
import com.models.Transference;
import com.models.isClient;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONObject;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
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
        
        isClient val = new isClient();
        JSONObject acc = val.account("", request.getParameter("acc1"));
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
