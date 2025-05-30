-- Stores details for each physical restaurant location.
CREATE TABLE Locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(500) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    map_url VARCHAR(500),
    restaurant_id INT
);
