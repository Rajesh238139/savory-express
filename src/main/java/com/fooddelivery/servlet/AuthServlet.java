package com.fooddelivery.servlet;

import com.fooddelivery.dao.UserDAO;
import com.fooddelivery.dao.CartDAO;
import com.fooddelivery.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private UserDAO userDAO;
    private CartDAO cartDAO;
    
    @Override
    public void init() throws ServletException {
        userDAO = new UserDAO();
        cartDAO = new CartDAO();
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String action = request.getParameter("action");
        
        if ("login".equals(action)) {
            handleLogin(request, response);
        } else if ("register".equals(action)) {
            handleRegister(request, response);
        } else if ("logout".equals(action)) {
            handleLogout(request, response);
        }
    }
    
    private void handleLogin(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if (username == null || password == null || 
            username.trim().isEmpty() || password.trim().isEmpty()) {
            
            request.setAttribute("loginError", "Please enter both username and password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        User user = userDAO.getUserByCredentials(username.trim(), password);
        
        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            // Load cart count for the user
            int cartCount = cartDAO.getCartItemCount(user.getUserId());
            session.setAttribute("cartCount", cartCount);
            
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("loginError", "Invalid username or password.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
    
    private void handleRegister(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        
        // Basic validation
        if (username == null || email == null || password == null || fullName == null ||
            username.trim().isEmpty() || email.trim().isEmpty() || 
            password.trim().isEmpty() || fullName.trim().isEmpty()) {
            
            request.setAttribute("registerError", "Please fill in all required fields.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        // Check if username/email already exists
        if (userDAO.isUsernameExists(username.trim()) || userDAO.isUsernameExists(email.trim())) {
            request.setAttribute("registerError", "Username or email already exists.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
            return;
        }
        
        User user = new User(username.trim(), email.trim(), password, 
                           fullName.trim(), phone != null ? phone.trim() : "", 
                           address != null ? address.trim() : "");
        
        if (userDAO.createUser(user)) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("cartCount", 0); // New user has empty cart
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("registerError", "Registration failed. Please try again.");
            request.getRequestDispatcher("/register.jsp").forward(request, response);
        }
    }
    
    private void handleLogout(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.invalidate();
        }
        
        response.sendRedirect(request.getContextPath() + "/index.jsp");
    }
}