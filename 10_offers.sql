-- Stores details of all special offers and promotions.
CREATE TABLE Offers (
    offer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    offer_type VARCHAR(50) NOT NULL CHECK (offer_type IN ('PERCENTAGE_OFF', 'FLAT_OFF', 'COMBO_OFFER', 'UNLIMITED_OFFER')),
    discount_value DECIMAL(10,2),
    min_value DECIMAL(10,2),
    max_value DECIMAL(10,2),
    terms_conditions TEXT,
    applies_to_whole_menu BOOLEAN NOT NULL DEFAULT FALSE,
    valid_from_date DATE NOT NULL,
    valid_to_date DATE NOT NULL,
    valid_from_time TIME NOT NULL,
    valid_to_time TIME NOT NULL,
    combo_details_json JSONB,
    unlimited_details_json JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
