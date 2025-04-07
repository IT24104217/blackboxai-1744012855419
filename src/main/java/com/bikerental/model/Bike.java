package com.bikerental.model;

import java.util.UUID;

public class Bike {
    private String id;
    private String name;
    private double price;
    private String imageUrl;
    private boolean available;
    private String description;
    private String category;
    private String lastUpdated;

    public Bike() {
        this.id = UUID.randomUUID().toString();
        this.lastUpdated = java.time.LocalDateTime.now().toString();
    }

    public Bike(String name, double price, String imageUrl, boolean available, 
               String description, String category) {
        this();
        this.name = name;
        this.price = price;
        this.imageUrl = imageUrl;
        this.available = available;
        this.description = description;
        this.category = category;
    }

    // Getters and Setters
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { 
        this.name = name; 
        updateTimestamp();
    }
    
    public double getPrice() { return price; }
    public void setPrice(double price) { 
        this.price = price; 
        updateTimestamp();
    }
    
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { 
        this.imageUrl = imageUrl; 
        updateTimestamp();
    }
    
    public boolean isAvailable() { return available; }
    public void setAvailable(boolean available) { 
        this.available = available; 
        updateTimestamp();
    }
    
    public String getDescription() { return description; }
    public void setDescription(String description) { 
        this.description = description; 
        updateTimestamp();
    }
    
    public String getCategory() { return category; }
    public void setCategory(String category) { 
        this.category = category; 
        updateTimestamp();
    }
    
    public String getLastUpdated() { return lastUpdated; }
    
    private void updateTimestamp() {
        this.lastUpdated = java.time.LocalDateTime.now().toString();
    }

    @Override
    public String toString() {
        return "Bike{" +
                "id='" + id + '\'' +
                ", name='" + name + '\'' +
                ", price=" + price +
                ", imageUrl='" + imageUrl + '\'' +
                ", available=" + available +
                ", description='" + description + '\'' +
                ", category='" + category + '\'' +
                ", lastUpdated='" + lastUpdated + '\'' +
                '}';
    }
}