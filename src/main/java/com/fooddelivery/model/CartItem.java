package com.fooddelivery.model;

import java.math.BigDecimal;

public class CartItem {
    private int cartId;
    private int userId;
    private int itemId;
    private int quantity;
    
    // Additional info from joins
    private String itemName;
    private String itemDescription;
    private BigDecimal itemPrice;
    private String itemImageUrl;
    private String restaurantName;
    private int restaurantId;
    private boolean isVegetarian;
    
    // Constructors
    public CartItem() {}
    
    public CartItem(int cartId, int userId, int itemId, int quantity) {
        this.cartId = cartId;
        this.userId = userId;
        this.itemId = itemId;
        this.quantity = quantity;
    }
    
    // Calculated properties
    public BigDecimal getTotalPrice() {
        if (itemPrice != null) {
            return itemPrice.multiply(BigDecimal.valueOf(quantity));
        }
        return BigDecimal.ZERO;
    }
    
    // Getters and Setters
    public int getCartId() { return cartId; }
    public void setCartId(int cartId) { this.cartId = cartId; }
    
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }
    
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }
    
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    
    public String getItemName() { return itemName; }
    public void setItemName(String itemName) { this.itemName = itemName; }
    
    public String getItemDescription() { return itemDescription; }
    public void setItemDescription(String itemDescription) { this.itemDescription = itemDescription; }
    
    public BigDecimal getItemPrice() { return itemPrice; }
    public void setItemPrice(BigDecimal itemPrice) { this.itemPrice = itemPrice; }
    
    public String getItemImageUrl() { return itemImageUrl; }
    public void setItemImageUrl(String itemImageUrl) { this.itemImageUrl = itemImageUrl; }
    
    public String getRestaurantName() { return restaurantName; }
    public void setRestaurantName(String restaurantName) { this.restaurantName = restaurantName; }
    
    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
    
    public boolean isVegetarian() { return isVegetarian; }
    public void setVegetarian(boolean vegetarian) { isVegetarian = vegetarian; }
}