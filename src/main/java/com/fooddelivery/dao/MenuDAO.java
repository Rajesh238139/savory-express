package com.fooddelivery.dao;

import com.fooddelivery.model.MenuItem;
import com.fooddelivery.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class MenuDAO {
    
    public List<MenuItem> getMenuItemsByRestaurant(int restaurantId) {
        List<MenuItem> menuItems = new ArrayList<>();
        String sql = """
            SELECT mi.*, mc.category_name 
            FROM menu_items mi 
            LEFT JOIN menu_categories mc ON mi.category_id = mc.category_id 
            WHERE mi.restaurant_id = ? AND mi.is_available = TRUE 
            ORDER BY mc.display_order ASC, mi.name ASC
        """;
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, restaurantId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    menuItems.add(mapResultSetToMenuItem(rs));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error fetching menu items: " + e.getMessage());
        }
        
        return menuItems;
    }
    
    public List<MenuItem> getMenuItemsByCategory(int restaurantId, int categoryId) {
        List<MenuItem> menuItems = new ArrayList<>();
        String sql = """
            SELECT mi.*, mc.category_name 
            FROM menu_items mi 
            LEFT JOIN menu_categories mc ON mi.category_id = mc.category_id 
            WHERE mi.restaurant_id = ? AND mi.category_id = ? AND mi.is_available = TRUE 
            ORDER BY mi.name ASC
        """;
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, restaurantId);
            stmt.setInt(2, categoryId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    menuItems.add(mapResultSetToMenuItem(rs));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error fetching menu items by category: " + e.getMessage());
        }
        
        return menuItems;
    }
    
    public MenuItem getMenuItemById(int itemId) {
        String sql = """
            SELECT mi.*, mc.category_name 
            FROM menu_items mi 
            LEFT JOIN menu_categories mc ON mi.category_id = mc.category_id 
            WHERE mi.item_id = ? AND mi.is_available = TRUE
        """;
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, itemId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToMenuItem(rs);
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error fetching menu item by ID: " + e.getMessage());
        }
        
        return null;
    }
    
    public List<String> getCategoriesByRestaurant(int restaurantId) {
        List<String> categories = new ArrayList<>();
        String sql = "SELECT category_name FROM menu_categories WHERE restaurant_id = ? ORDER BY display_order ASC";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, restaurantId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    categories.add(rs.getString("category_name"));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error fetching categories: " + e.getMessage());
        }
        
        return categories;
    }
    
    private MenuItem mapResultSetToMenuItem(ResultSet rs) throws SQLException {
        MenuItem menuItem = new MenuItem();
        menuItem.setItemId(rs.getInt("item_id"));
        menuItem.setRestaurantId(rs.getInt("restaurant_id"));
        menuItem.setCategoryId(rs.getInt("category_id"));
        menuItem.setName(rs.getString("name"));
        menuItem.setDescription(rs.getString("description"));
        menuItem.setPrice(rs.getBigDecimal("price"));
        menuItem.setImageUrl(rs.getString("image_url"));
        menuItem.setVegetarian(rs.getBoolean("is_vegetarian"));
        menuItem.setAvailable(rs.getBoolean("is_available"));
        menuItem.setPreparationTime(rs.getString("preparation_time"));
        menuItem.setCreatedAt(rs.getTimestamp("created_at"));
        menuItem.setCategoryName(rs.getString("category_name"));
        return menuItem;
    }
}