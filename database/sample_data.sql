USE food_delivery_db;

-- Insert sample users
INSERT INTO users (username, email, password, full_name, phone, address) VALUES
('john_doe', 'john@email.com', 'password123', 'John Doe', '+91 9876543210', '123 Main St, Mumbai, Maharashtra'),
('jane_smith', 'jane@email.com', 'password456', 'Jane Smith', '+91 8765432109', '456 Oak Ave, Delhi, Delhi');

-- Insert sample restaurants
INSERT INTO restaurants (name, description, cuisine_type, rating, delivery_time, delivery_fee, min_order, image_url, address) VALUES
('Maharaja Palace', 'Authentic Indian cuisine with royal flavors and traditional spices', 'Indian', 4.5, '35-45 mins', 49.99, 250.00, 'https://images.unsplash.com/photo-1565557623262-b51c2513a641?w=800&h=600&fit=crop&q=80', '123 Spice Street, Little India'),
('Bella Italia', 'Handcrafted Italian dishes made with imported ingredients', 'Italian', 4.7, '25-35 mins', 59.99, 350.00, 'https://images.unsplash.com/photo-1554118811-1e0d58224f24?w=800&h=600&fit=crop&q=80', '456 Romano Avenue, Downtown'),
('Dragon Garden', 'Fresh and authentic Chinese cuisine with traditional wok cooking', 'Chinese', 4.3, '30-40 mins', 39.99, 200.00, 'https://images.unsplash.com/photo-1563379091-20ec5be1d9d8?w=800&h=600&fit=crop&q=80', '789 Bamboo Lane, Chinatown'),
('El Sombrero', 'Vibrant Mexican flavors with fresh ingredients and bold spices', 'Mexican', 4.4, '20-30 mins', 29.99, 300.00, 'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=800&h=600&fit=crop&q=80', '321 Fiesta Boulevard, Plaza District'),
('Tokyo Sushi', 'Premium sushi and Japanese delicacies made by master chefs', 'Japanese', 4.8, '40-50 mins', 79.99, 450.00, 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=800&h=600&fit=crop&q=80', '654 Sakura Street, Japan Town'),
('Burger Junction', 'Gourmet burgers and comfort food made with premium ingredients', 'American', 4.2, '15-25 mins', 25.99, 180.00, 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=800&h=600&fit=crop&q=80', '987 Burger Avenue, Food Court');

-- Insert menu categories for Maharaja Palace
INSERT INTO menu_categories (restaurant_id, category_name, display_order) VALUES
(1, 'Appetizers', 1),
(1, 'Main Course', 2),
(1, 'Biryanis', 3),
(1, 'Desserts', 4),
(1, 'Beverages', 5);

-- Insert menu categories for Bella Italia
INSERT INTO menu_categories (restaurant_id, category_name, display_order) VALUES
(2, 'Appetizers', 1),
(2, 'Pasta', 2),
(2, 'Pizza', 3),
(2, 'Main Course', 4),
(2, 'Desserts', 5);

-- Insert menu categories for Dragon Garden
INSERT INTO menu_categories (restaurant_id, category_name, display_order) VALUES
(3, 'Appetizers', 1),
(3, 'Soups', 2),
(3, 'Main Course', 3),
(3, 'Rice & Noodles', 4),
(3, 'Beverages', 5);

-- Insert menu items for Maharaja Palace (prices in INR)
INSERT INTO menu_items (restaurant_id, category_id, name, description, price, image_url, is_vegetarian, preparation_time) VALUES
(1, 1, 'Samosa Platter', 'Crispy pastries filled with spiced potatoes and peas', 149.99, 'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=400&h=300&fit=crop&q=80', TRUE, '10 mins'),
(1, 1, 'Chicken Tikka', 'Tender chicken marinated in yogurt and spices, grilled to perfection', 219.99, 'https://images.unsplash.com/photo-1567188040759-fb8a883dc6d8?w=400&h=300&fit=crop&q=80', FALSE, '15 mins'),
(1, 2, 'Butter Chicken', 'Creamy tomato-based curry with tender chicken pieces', 329.99, 'https://images.unsplash.com/photo-1588166524941-3bf61a9c41db?w=400&h=300&fit=crop&q=80', FALSE, '25 mins'),
(1, 2, 'Paneer Makhani', 'Rich and creamy cottage cheese curry in buttery tomato sauce', 299.99, 'https://images.unsplash.com/photo-1631452180519-c014fe946bc7?w=400&h=300&fit=crop&q=80', TRUE, '20 mins'),
(1, 3, 'Chicken Biryani', 'Fragrant basmati rice layered with spiced chicken and saffron', 399.99, 'https://images.unsplash.com/photo-1563379091339-03246963d4d6?w=400&h=300&fit=crop&q=80', FALSE, '35 mins'),
(1, 3, 'Vegetable Biryani', 'Aromatic rice with mixed vegetables and traditional spices', 349.99, 'https://images.unsplash.com/photo-1596797038530-2c107229654b?w=400&h=300&fit=crop&q=80', TRUE, '30 mins');

-- Insert menu items for Bella Italia (prices in INR)
INSERT INTO menu_items (restaurant_id, category_id, name, description, price, image_url, is_vegetarian, preparation_time) VALUES
(2, 6, 'Bruschetta Trio', 'Three varieties of toasted bread with fresh toppings', 179.99, 'https://images.unsplash.com/photo-1572695157366-5e585ab2b69f?w=400&h=300&fit=crop&q=80', TRUE, '10 mins'),
(2, 6, 'Antipasto Platter', 'Selection of Italian meats, cheeses, and marinated vegetables', 279.99, 'https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=400&h=300&fit=crop&q=80', FALSE, '15 mins'),
(2, 7, 'Spaghetti Carbonara', 'Classic Roman pasta with eggs, cheese, and pancetta', 299.99, 'https://images.unsplash.com/photo-1551892374-ecf8754cf8b0?w=400&h=300&fit=crop&q=80', FALSE, '20 mins'),
(2, 7, 'Penne Arrabbiata', 'Spicy tomato sauce with garlic, herbs, and red peppers', 259.99, 'https://images.unsplash.com/photo-1621996346565-e3dbc353d300?w=400&h=300&fit=crop&q=80', TRUE, '18 mins'),
(2, 8, 'Margherita Pizza', 'Traditional pizza with fresh mozzarella, tomatoes, and basil', 329.99, 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=400&h=300&fit=crop&q=80', TRUE, '25 mins'),
(2, 8, 'Pepperoni Supreme', 'Classic pepperoni with extra cheese and Italian herbs', 379.99, 'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=400&h=300&fit=crop&q=80', FALSE, '25 mins');

-- Insert menu items for Dragon Garden (prices in INR)
INSERT INTO menu_items (restaurant_id, category_id, name, description, price, image_url, is_vegetarian, preparation_time) VALUES
(3, 11, 'Spring Rolls', 'Crispy vegetable rolls served with sweet and sour sauce', 139.99, 'https://images.unsplash.com/photo-1544025162-d76694265947?w=400&h=300&fit=crop&q=80', TRUE, '12 mins'),
(3, 11, 'Pot Stickers', 'Pan-fried pork dumplings with ginger soy dipping sauce', 189.99, 'https://images.unsplash.com/photo-1496116218417-1a781b1c416c?w=400&h=300&fit=crop&q=80', FALSE, '15 mins'),
(3, 12, 'Hot & Sour Soup', 'Traditional Chinese soup with tofu, mushrooms, and bamboo shoots', 119.99, 'https://images.unsplash.com/photo-1547592166-23ac45744acd?w=400&h=300&fit=crop&q=80', TRUE, '10 mins'),
(3, 13, 'Sweet & Sour Pork', 'Battered pork with pineapple and bell peppers in tangy sauce', 309.99, 'https://images.unsplash.com/photo-1596797038530-2c107229654b?w=400&h=300&fit=crop&q=80', FALSE, '22 mins'),
(3, 13, 'Kung Pao Chicken', 'Spicy stir-fried chicken with peanuts and vegetables', 289.99, 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=400&h=300&fit=crop&q=80', FALSE, '20 mins'),
(3, 14, 'Fried Rice', 'Wok-fried rice with eggs, vegetables, and choice of protein', 239.99, 'https://images.unsplash.com/photo-1512058564366-18510be2db19?w=400&h=300&fit=crop&q=80', FALSE, '15 mins');

-- Add more categories for other restaurants
INSERT INTO menu_categories (restaurant_id, category_name, display_order) VALUES
(4, 'Appetizers', 1), (4, 'Tacos', 2), (4, 'Burritos', 3), (4, 'Quesadillas', 4),
(5, 'Sushi Rolls', 1), (5, 'Sashimi', 2), (5, 'Hot Dishes', 3),
(6, 'Burgers', 1), (6, 'Sides', 2), (6, 'Shakes', 3);

-- Insert more menu items for variety (prices in INR)
INSERT INTO menu_items (restaurant_id, category_id, name, description, price, image_url, is_vegetarian, preparation_time) VALUES
(4, 16, 'Beef Tacos', 'Three soft tacos with seasoned beef, lettuce, and cheese', 209.99, 'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?w=400&h=300&fit=crop&q=80', FALSE, '12 mins'),
(4, 17, 'Chicken Burrito Bowl', 'Grilled chicken with rice, beans, and fresh toppings', 249.99, 'https://images.unsplash.com/photo-1626700051175-6818013e8fb0?w=400&h=300&fit=crop&q=80', FALSE, '15 mins'),
(5, 19, 'California Roll', 'Crab, avocado, and cucumber wrapped in seaweed and rice', 229.99, 'https://images.unsplash.com/photo-1617196034796-73dfa7b1fd56?w=400&h=300&fit=crop&q=80', FALSE, '10 mins'),
(5, 20, 'Salmon Sashimi', 'Fresh Atlantic salmon sliced thin and served with wasabi', 299.99, 'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400&h=300&fit=crop&q=80', FALSE, '8 mins'),
(6, 22, 'Classic Cheeseburger', 'Beef patty with cheese, lettuce, tomato, and special sauce', 259.99, 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=400&h=300&fit=crop&q=80', FALSE, '15 mins'),
(6, 23, 'Loaded Fries', 'Crispy fries topped with cheese, bacon, and green onions', 159.99, 'https://images.unsplash.com/photo-1630384060421-cb20d0e0649d?w=400&h=300&fit=crop&q=80', FALSE, '10 mins');