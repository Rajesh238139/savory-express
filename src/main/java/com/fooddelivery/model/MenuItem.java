package com.fooddelivery.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class MenuItem {
    private int itemId;
    private int restaurantId;
    private int categoryId;
    private String name;
    private String description;
    private BigDecimal price;
    private String imageUrl;
    private boolean isVegetarian;
    private boolean isAvailable;
    private String preparationTime;
    private Timestamp createdAt;
    
    // Category information
    private String categoryName;
    
    // Constructors
    public MenuItem() {}
    
    public MenuItem(int itemId, int restaurantId, int categoryId, String name, 
                   String description, BigDecimal price, String imageUrl, 
                   boolean isVegetarian, boolean isAvailable, String preparationTime) {
        this.itemId = itemId;
        this.restaurantId = restaurantId;
        this.categoryId = categoryId;
        this.name = name;
        this.description = description;
        this.price = price;
        this.imageUrl = imageUrl;
        this.isVegetarian = isVegetarian;
        this.isAvailable = isAvailable;
        this.preparationTime = preparationTime;
    }
    
    // Getters and Setters
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }
    
    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
    
    public int getCategoryId() { return categoryId; }
    public void setCategoryId(int categoryId) { this.categoryId = categoryId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    
    public boolean isVegetarian() { return isVegetarian; }
    public void setVegetarian(boolean vegetarian) { isVegetarian = vegetarian; }
    
    public boolean isAvailable() { return isAvailable; }
    public void setAvailable(boolean available) { isAvailable = available; }
    
    public String getPreparationTime() { return preparationTime; }
    public void setPreparationTime(String preparationTime) { this.preparationTime = preparationTime; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
    
    public String getCategoryName() { return categoryName; }
    public void setCategoryName(String categoryName) { this.categoryName = categoryName; }
}