package com.fooddelivery.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/order-confirmation")
public class OrderConfirmationServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Boolean orderConfirmation = (Boolean) session.getAttribute("orderConfirmation");
        
        if (orderConfirmation == null || !orderConfirmation) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        // Get order details from session
        Long orderId = (Long) session.getAttribute("orderId");
        BigDecimal orderTotal = (BigDecimal) session.getAttribute("orderTotal");
        String deliveryAddress = (String) session.getAttribute("deliveryAddress");
        String paymentMethod = (String) session.getAttribute("paymentMethod");
        
        request.setAttribute("orderId", orderId);
        request.setAttribute("orderTotal", orderTotal);
        request.setAttribute("deliveryAddress", deliveryAddress);
        request.setAttribute("paymentMethod", paymentMethod);
        
        // Clear the confirmation flag
        session.removeAttribute("orderConfirmation");
        session.removeAttribute("orderId");
        session.removeAttribute("orderTotal");
        session.removeAttribute("deliveryAddress");
        session.removeAttribute("paymentMethod");
        
        request.getRequestDispatcher("/WEB-INF/views/order-confirmation.jsp").forward(request, response);
    }
}