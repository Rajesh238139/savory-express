package com.fooddelivery.model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class Restaurant {
    private int restaurantId;
    private String name;
    private String description;
    private String cuisineType;
    private BigDecimal rating;
    private String deliveryTime;
    private BigDecimal deliveryFee;
    private BigDecimal minOrder;
    private String imageUrl;
    private String address;
    private boolean isActive;
    private Timestamp createdAt;
    
    // Constructors
    public Restaurant() {}
    
    public Restaurant(int restaurantId, String name, String description, String cuisineType, 
                     BigDecimal rating, String deliveryTime, BigDecimal deliveryFee, 
                     BigDecimal minOrder, String imageUrl, String address, boolean isActive) {
        this.restaurantId = restaurantId;
        this.name = name;
        this.description = description;
        this.cuisineType = cuisineType;
        this.rating = rating;
        this.deliveryTime = deliveryTime;
        this.deliveryFee = deliveryFee;
        this.minOrder = minOrder;
        this.imageUrl = imageUrl;
        this.address = address;
        this.isActive = isActive;
    }
    
    // Getters and Setters
    public int getRestaurantId() { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    
    public String getCuisineType() { return cuisineType; }
    public void setCuisineType(String cuisineType) { this.cuisineType = cuisineType; }
    
    public BigDecimal getRating() { return rating; }
    public void setRating(BigDecimal rating) { this.rating = rating; }
    
    public String getDeliveryTime() { return deliveryTime; }
    public void setDeliveryTime(String deliveryTime) { this.deliveryTime = deliveryTime; }
    
    public BigDecimal getDeliveryFee() { return deliveryFee; }
    public void setDeliveryFee(BigDecimal deliveryFee) { this.deliveryFee = deliveryFee; }
    
    public BigDecimal getMinOrder() { return minOrder; }
    public void setMinOrder(BigDecimal minOrder) { this.minOrder = minOrder; }
    
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    
    public boolean isActive() { return isActive; }
    public void setActive(boolean active) { isActive = active; }
    
    public Timestamp getCreatedAt() { return createdAt; }
    public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}