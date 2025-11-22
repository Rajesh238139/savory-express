package com.fooddelivery.servlet;

import com.fooddelivery.dao.CartDAO;
import com.fooddelivery.model.CartItem;
import com.fooddelivery.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
    private CartDAO cartDAO;
    
    @Override
    public void init() throws ServletException {
        cartDAO = new CartDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        List<CartItem> cartItems = cartDAO.getCartItems(user.getUserId());
        
        if (cartItems.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/cart");
            return;
        }
        
        // Calculate totals
        BigDecimal subtotal = BigDecimal.ZERO;
        BigDecimal deliveryFee = new BigDecimal("49.99");
        BigDecimal tax = BigDecimal.ZERO;
        
        for (CartItem item : cartItems) {
            subtotal = subtotal.add(item.getTotalPrice());
        }
        
        tax = subtotal.multiply(new BigDecimal("0.08"));
        BigDecimal total = subtotal.add(deliveryFee).add(tax);
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("deliveryFee", deliveryFee);
        request.setAttribute("tax", tax);
        request.setAttribute("total", total);
        request.setAttribute("user", user);
        
        request.getRequestDispatcher("/WEB-INF/views/checkout.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }
        
        // Get form data
        String deliveryAddress = request.getParameter("deliveryAddress");
        String paymentMethod = request.getParameter("paymentMethod");
        String totalStr = request.getParameter("total");
        
        // Validate required fields
        if (deliveryAddress == null || deliveryAddress.trim().isEmpty() ||
            paymentMethod == null || paymentMethod.trim().isEmpty()) {
            
            request.setAttribute("error", "Please fill in all required fields.");
            doGet(request, response);
            return;
        }
        
        try {
            BigDecimal total = new BigDecimal(totalStr);
            
            // Generate order ID (simplified - in real app, insert into orders table)
            long orderId = System.currentTimeMillis() % 1000000;
            
            // Clear the cart after successful order
            cartDAO.clearCart(user.getUserId());
            
            // Update cart count in session
            session.setAttribute("cartCount", 0);
            
            // Set order details for confirmation page
            session.setAttribute("orderConfirmation", true);
            session.setAttribute("orderId", orderId);
            session.setAttribute("orderTotal", total);
            session.setAttribute("deliveryAddress", deliveryAddress);
            session.setAttribute("paymentMethod", paymentMethod);
            
            response.sendRedirect(request.getContextPath() + "/order-confirmation");
            
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid total amount.");
            doGet(request, response);
        }
    }
}