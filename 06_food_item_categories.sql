-- Links food items to their respective categories. A food item can belong to multiple categories.
CREATE TABLE FoodItemCategories (
    food_item_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (food_item_id, category_id)
);
