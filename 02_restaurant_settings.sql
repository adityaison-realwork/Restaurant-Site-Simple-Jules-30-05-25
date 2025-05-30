-- Stores general restaurant information displayed on the client-side footer and used across the site.
CREATE TABLE RestaurantSettings (
    setting_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_name VARCHAR(255) NOT NULL,
    whatsapp_number VARCHAR(20) NOT NULL,
    contact_phone_number VARCHAR(255),
    contact_email_address VARCHAR(255),
    about_us_chef_bio TEXT,
    about_us_staff_intro TEXT,
    about_us_health_hygiene TEXT,
    about_us_journey_struggle TEXT,
    about_us_timeline JSONB,
    review_visibility_mode VARCHAR(50) NOT NULL DEFAULT 'APPROVED_ONLY' CHECK (review_visibility_mode IN ('APPROVED_ONLY', 'SHOW_ALL')),
    default_delivery_charge DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
