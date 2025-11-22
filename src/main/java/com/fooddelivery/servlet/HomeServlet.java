package com.fooddelivery.servlet;

import com.fooddelivery.dao.RestaurantDAO;
import com.fooddelivery.model.Restaurant;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {
    private RestaurantDAO restaurantDAO;
    
    @Override
    public void init() throws ServletException {
        restaurantDAO = new RestaurantDAO();
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String cuisine = request.getParameter("cuisine");
        String search = request.getParameter("search");
        
        List<Restaurant> restaurants;
        List<String> cuisineTypes = restaurantDAO.getAllCuisineTypes();
        
        if (search != null && !search.trim().isEmpty()) {
            restaurants = restaurantDAO.searchRestaurants(search.trim());
            request.setAttribute("searchTerm", search.trim());
        } else if (cuisine != null && !cuisine.trim().isEmpty()) {
            restaurants = restaurantDAO.getRestaurantsByCuisine(cuisine);
            request.setAttribute("selectedCuisine", cuisine);
        } else {
            restaurants = restaurantDAO.getAllRestaurants();
        }
        
        request.setAttribute("restaurants", restaurants);
        request.setAttribute("cuisineTypes", cuisineTypes);
        
        request.getRequestDispatcher("/WEB-INF/views/home.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}