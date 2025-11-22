package com.fooddelivery.servlet;

import com.fooddelivery.dao.CartDAO;
import com.fooddelivery.dao.MenuDAO;
import com.fooddelivery.model.CartItem;
import com.fooddelivery.model.MenuItem;
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

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private CartDAO cartDAO;
    private MenuDAO menuDAO;
    
    @Override
    public void init() throws ServletException {
        cartDAO = new CartDAO();
        menuDAO = new MenuDAO();
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
        
        // Calculate totals
        BigDecimal subtotal = BigDecimal.ZERO;
        BigDecimal deliveryFee = new BigDecimal("49.99"); // Default delivery fee in INR
        BigDecimal tax = BigDecimal.ZERO;
        
        for (CartItem item : cartItems) {
            subtotal = subtotal.add(item.getTotalPrice());
        }
        
        tax = subtotal.multiply(new BigDecimal("0.08")); // 8% tax
        BigDecimal total = subtotal.add(deliveryFee).add(tax);
        
        request.setAttribute("cartItems", cartItems);
        request.setAttribute("subtotal", subtotal);
        request.setAttribute("deliveryFee", deliveryFee);
        request.setAttribute("tax", tax);
        request.setAttribute("total", total);
        request.setAttribute("isEmpty", cartItems.isEmpty());
        
        request.getRequestDispatcher("/WEB-INF/views/cart.jsp").forward(request, response);
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
        
        String action = request.getParameter("action");
        String itemIdStr = request.getParameter("itemId");
        String quantityStr = request.getParameter("quantity");
        
        try {
            int itemId = Integer.parseInt(itemIdStr);
            
            switch (action) {
                case "add":
                    int quantity = quantityStr != null ? Integer.parseInt(quantityStr) : 1;
                    cartDAO.addToCart(user.getUserId(), itemId, quantity);
                    break;
                    
                case "update":
                    int newQuantity = Integer.parseInt(quantityStr);
                    cartDAO.updateCartItem(user.getUserId(), itemId, newQuantity);
                    break;
                    
                case "remove":
                    cartDAO.removeFromCart(user.getUserId(), itemId);
                    break;
                    
                case "clear":
                    cartDAO.clearCart(user.getUserId());
                    break;
            }
            
            // Get updated cart count for session
            int cartCount = cartDAO.getCartItemCount(user.getUserId());
            session.setAttribute("cartCount", cartCount);
            
        } catch (NumberFormatException e) {
            // Invalid parameters, ignore
        }
        
        // Redirect back to cart or the referring page
        String referer = request.getHeader("Referer");
        if (referer != null && referer.contains("/menu")) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect(request.getContextPath() + "/cart");
        }
    }
}