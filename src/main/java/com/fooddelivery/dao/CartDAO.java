package com.fooddelivery.dao;

import com.fooddelivery.model.CartItem;
import com.fooddelivery.util.DatabaseConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {
    
    public List<CartItem> getCartItems(int userId) {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = """
            SELECT c.*, mi.name as item_name, mi.description as item_description, 
                   mi.price as item_price, mi.image_url as item_image_url, 
                   mi.is_vegetarian, r.name as restaurant_name, r.restaurant_id
            FROM cart c
            JOIN menu_items mi ON c.item_id = mi.item_id
            JOIN restaurants r ON mi.restaurant_id = r.restaurant_id
            WHERE c.user_id = ?
            ORDER BY c.created_at DESC
        """;
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    cartItems.add(mapResultSetToCartItem(rs));
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error fetching cart items: " + e.getMessage());
        }
        
        return cartItems;
    }
    
    public boolean addToCart(int userId, int itemId, int quantity) {
        String checkSql = "SELECT cart_id, quantity FROM cart WHERE user_id = ? AND item_id = ?";
        String insertSql = "INSERT INTO cart (user_id, item_id, quantity) VALUES (?, ?, ?)";
        String updateSql = "UPDATE cart SET quantity = ? WHERE cart_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection()) {
            // Check if item already exists in cart
            try (PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {
                checkStmt.setInt(1, userId);
                checkStmt.setInt(2, itemId);
                
                try (ResultSet rs = checkStmt.executeQuery()) {
                    if (rs.next()) {
                        // Update existing item
                        int cartId = rs.getInt("cart_id");
                        int currentQuantity = rs.getInt("quantity");
                        
                        try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
                            updateStmt.setInt(1, currentQuantity + quantity);
                            updateStmt.setInt(2, cartId);
                            return updateStmt.executeUpdate() > 0;
                        }
                    } else {
                        // Insert new item
                        try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
                            insertStmt.setInt(1, userId);
                            insertStmt.setInt(2, itemId);
                            insertStmt.setInt(3, quantity);
                            return insertStmt.executeUpdate() > 0;
                        }
                    }
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error adding item to cart: " + e.getMessage());
        }
        
        return false;
    }
    
    public boolean updateCartItem(int userId, int itemId, int quantity) {
        if (quantity <= 0) {
            return removeFromCart(userId, itemId);
        }
        
        String sql = "UPDATE cart SET quantity = ? WHERE user_id = ? AND item_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, quantity);
            stmt.setInt(2, userId);
            stmt.setInt(3, itemId);
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Error updating cart item: " + e.getMessage());
        }
        
        return false;
    }
    
    public boolean removeFromCart(int userId, int itemId) {
        String sql = "DELETE FROM cart WHERE user_id = ? AND item_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            stmt.setInt(2, itemId);
            
            return stmt.executeUpdate() > 0;
            
        } catch (SQLException e) {
            System.err.println("Error removing item from cart: " + e.getMessage());
        }
        
        return false;
    }
    
    public boolean clearCart(int userId) {
        String sql = "DELETE FROM cart WHERE user_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            return stmt.executeUpdate() >= 0;
            
        } catch (SQLException e) {
            System.err.println("Error clearing cart: " + e.getMessage());
        }
        
        return false;
    }
    
    public int getCartItemCount(int userId) {
        String sql = "SELECT COALESCE(SUM(quantity), 0) as total_items FROM cart WHERE user_id = ?";
        
        try (Connection conn = DatabaseConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, userId);
            
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("total_items");
                }
            }
            
        } catch (SQLException e) {
            System.err.println("Error getting cart item count: " + e.getMessage());
        }
        
        return 0;
    }
    
    private CartItem mapResultSetToCartItem(ResultSet rs) throws SQLException {
        CartItem cartItem = new CartItem();
        cartItem.setCartId(rs.getInt("cart_id"));
        cartItem.setUserId(rs.getInt("user_id"));
        cartItem.setItemId(rs.getInt("item_id"));
        cartItem.setQuantity(rs.getInt("quantity"));
        cartItem.setItemName(rs.getString("item_name"));
        cartItem.setItemDescription(rs.getString("item_description"));
        cartItem.setItemPrice(rs.getBigDecimal("item_price"));
        cartItem.setItemImageUrl(rs.getString("item_image_url"));
        cartItem.setVegetarian(rs.getBoolean("is_vegetarian"));
        cartItem.setRestaurantName(rs.getString("restaurant_name"));
        cartItem.setRestaurantId(rs.getInt("restaurant_id"));
        return cartItem;
    }
}