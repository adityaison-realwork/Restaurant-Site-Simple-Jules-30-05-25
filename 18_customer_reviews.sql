-- Stores customer reviews and their approval status.
CREATE TABLE CustomerReviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_name VARCHAR(255),
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    food_items_ordered TEXT,
    overall_food_experience TEXT,
    food_rating INT CHECK (food_rating BETWEEN 1 AND 5),
    staff_experience TEXT,
    staff_rating INT CHECK (staff_rating BETWEEN 1 AND 5),
    ambience_experience TEXT,
    ambience_rating INT CHECK (ambience_rating BETWEEN 1 AND 5),
    overall_experience_comments TEXT,
    overall_rating INT NOT NULL CHECK (overall_rating BETWEEN 1 AND 5),
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'APPROVED', 'DISAPPROVED')),
    food_item_id INT
);
