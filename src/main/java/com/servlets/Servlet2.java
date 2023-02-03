/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.servlets;

import com.models.ClientNumber;
import com.models.RegisterAccount;
import com.models.accounts;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.simple.parser.ParseException;

/**
 *
 * @author twozer00
 */
@WebServlet(name = "Servlet2", urlPatterns = {"/Servlet2"})
public class Servlet2 extends HttpServlet {
    accounts ac;

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
            out.println("<title>Cuenta registrada</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>La cuenta " + ac.getNaccount() + " ha sido regitrada exitosamente</h1>");
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
            out.println("<a href='accountRegister.jsp'>Regresar</a>");
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
        ac = new accounts();
        ClientNumber cn = new ClientNumber();
        ac.setNaccount(cn.getNumberAcc());
        ac.setNclient(request.getParameter("nclient"));
        ac.setType(request.getParameter("type"));
        ac.setAmount(request.getParameter("amount"));
        ac.setDate(request.getParameter("date"));
        RegisterAccount rac = new RegisterAccount();
        rac.rac(ac);
        request.setAttribute("success",true);
        request.setAttribute("client_number", ac.getNclient());
        request.setAttribute("account_number", ac.getNaccount());
        RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/dashboard.jsp");
        dispatcher.forward(request,response);
        //processRequest(request, response);
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
