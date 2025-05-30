-- Stores categories for food items (e.g., "Pizzas," "Desserts").
CREATE TABLE FoodCategories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);
