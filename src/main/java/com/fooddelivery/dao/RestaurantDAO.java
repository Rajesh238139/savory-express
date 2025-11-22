package com.fooddelivery.dao;

import com.fooddelivery.model.Restaurant;
import com.fooddelivery.util.DatabaseConnection;

import java.math.BigDecimal;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RestaurantDAO {
    
    public List<Restaurant> getAllRestaurants() {
        List<Restaurant> restaurants = new ArrayList<>();
        String sql = "SELECT * FROM restaurants WHERE is_active = TRUE ORDER BY rating DESC, name ASC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                restaurants.add(mapResultSetToRestaurant(rs));
            }
            
        } catch (SQLException e) {
            System.err.println("Error fetching restaurants: " + e.getMessage());
        }
        
        return restaurants;
    }
    
    public List<Restaurant> getRestaurantsByCuisine(String cuisine) {
        List<Restaurant> restaurants = new ArrayList<>();
        String sql = "SELECT * FROM restaurants WHERE cuisine_type = ? AND is_active = TRUE ORDER BY rating DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, cuisine);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    restaurants.add(mapResultSetToRestaurant(rs));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error fetching restaurants by cuisine: " + e.getMessage());
        }
        
        return restaurants;
    }
    
    public Restaurant getRestaurantById(int restaurantId) {
        String sql = "SELECT * FROM restaurants WHERE restaurant_id = ? AND is_active = TRUE";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, restaurantId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToRestaurant(rs);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error fetching restaurant by ID: " + e.getMessage());
        }
        
        return null;
    }
    
    public List<String> getAllCuisineTypes() {
        List<String> cuisines = new ArrayList<>();
        String sql = "SELECT DISTINCT cuisine_type FROM restaurants WHERE is_active = TRUE ORDER BY cuisine_type";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                cuisines.add(rs.getString("cuisine_type"));
            }
            
        } catch (SQLException e) {
            System.err.println("Error fetching cuisine types: " + e.getMessage());
        }
        
        return cuisines;
    }
    
    public List<Restaurant> searchRestaurants(String searchTerm) {
        List<Restaurant> restaurants = new ArrayList<>();
        String sql = "SELECT * FROM restaurants WHERE (name LIKE ? OR cuisine_type LIKE ? OR description LIKE ?) AND is_active = TRUE ORDER BY rating DESC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            String searchPattern = "%" + searchTerm + "%";
            stmt.setString(1, searchPattern);
            stmt.setString(2, searchPattern);
            stmt.setString(3, searchPattern);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    restaurants.add(mapResultSetToRestaurant(rs));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error searching restaurants: " + e.getMessage());
        }
        
        return restaurants;
    }
    
    private Restaurant mapResultSetToRestaurant(ResultSet rs) throws SQLException {
        Restaurant restaurant = new Restaurant();
        restaurant.setRestaurantId(rs.getInt("restaurant_id"));
        restaurant.setName(rs.getString("name"));
        restaurant.setDescription(rs.getString("description"));
        restaurant.setCuisineType(rs.getString("cuisine_type"));
        restaurant.setRating(rs.getBigDecimal("rating"));
        restaurant.setDeliveryTime(rs.getString("delivery_time"));
        restaurant.setDeliveryFee(rs.getBigDecimal("delivery_fee"));
        restaurant.setMinOrder(rs.getBigDecimal("min_order"));
        restaurant.setImageUrl(rs.getString("image_url"));
        restaurant.setAddress(rs.getString("address"));
        restaurant.setActive(rs.getBoolean("is_active"));
        restaurant.setCreatedAt(rs.getTimestamp("created_at"));
        return restaurant;
    }
}