-- Stores details for each food item on the menu.
CREATE TABLE FoodItems (
    food_item_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    image_url VARCHAR(500),
    is_veg BOOLEAN NOT NULL,
    base_price DECIMAL(10,2),
    overall_rating DECIMAL(2,1) DEFAULT 0.0,
    total_reviews INT DEFAULT 0,
    is_available BOOLEAN NOT NULL DEFAULT TRUE,
    specific_rating_visibility VARCHAR(50) DEFAULT 'GLOBAL_SETTING' CHECK (specific_rating_visibility IN ('GLOBAL_SETTING', 'SHOW_ALL', 'APPROVED_ONLY')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
