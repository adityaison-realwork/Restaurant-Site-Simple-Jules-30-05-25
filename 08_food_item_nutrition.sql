-- Stores nutritional information for food items.
CREATE TABLE FoodItemNutrition (
    nutrition_id INT AUTO_INCREMENT PRIMARY KEY,
    food_item_id INT UNIQUE NOT NULL,
    calories DECIMAL(10,2),
    carbohydrates DECIMAL(10,2),
    protein DECIMAL(10,2),
    fats DECIMAL(10,2),
    fiber DECIMAL(10,2),
    sodium DECIMAL(10,2),
    other_nutrition_info TEXT
);
