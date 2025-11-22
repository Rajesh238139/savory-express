package com.fooddelivery.servlet;

import com.fooddelivery.dao.MenuDAO;
import com.fooddelivery.dao.RestaurantDAO;
import com.fooddelivery.model.MenuItem;
import com.fooddelivery.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/menu")
public class MenuServlet extends HttpServlet {
    private MenuDAO menuDAO;
    private RestaurantDAO restaurantDAO;
    
    @Override
    public void init() throws ServletException {
        menuDAO = new MenuDAO();
        restaurantDAO = new RestaurantDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String restaurantIdStr = request.getParameter("restaurant");
        
        if (restaurantIdStr == null || restaurantIdStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }
        
        try {
            int restaurantId = Integer.parseInt(restaurantIdStr);
            
            Restaurant restaurant = restaurantDAO.getRestaurantById(restaurantId);
            if (restaurant == null) {
                response.sendRedirect(request.getContextPath() + "/home");
                return;
            }
            
            List<MenuItem> menuItems = menuDAO.getMenuItemsByRestaurant(restaurantId);
            List<String> categories = menuDAO.getCategoriesByRestaurant(restaurantId);
            
            request.setAttribute("restaurant", restaurant);
            request.setAttribute("menuItems", menuItems);
            request.setAttribute("categories", categories);
            
            request.getRequestDispatcher("/WEB-INF/views/menu.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }
}