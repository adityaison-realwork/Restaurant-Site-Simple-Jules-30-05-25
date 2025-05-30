-- Stores allergens and ingredients for food items.
CREATE TABLE FoodItemAllergensIngredients (
    allergen_ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
    food_item_id INT UNIQUE NOT NULL,
    allergens TEXT,
    ingredients TEXT
);
