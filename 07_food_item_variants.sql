-- Stores different variants for a food item (e.g., sizes, patty counts).
CREATE TABLE FoodItemVariants (
    variant_id INT AUTO_INCREMENT PRIMARY KEY,
    food_item_id INT NOT NULL,
    variant_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    unit VARCHAR(50),
    is_out_of_stock BOOLEAN NOT NULL DEFAULT FALSE
);
