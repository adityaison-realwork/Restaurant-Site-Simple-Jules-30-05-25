-- Comprehensive SQL schema for the restaurant website database.
-- This script includes table creations, foreign key constraints, and indexes.

-- Stores user credentials for accessing the owner dashboard.
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    last_login TIMESTAMP
);


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


-- Stores details for each physical restaurant location.
CREATE TABLE Locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    address VARCHAR(500) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    map_url VARCHAR(500),
    restaurant_id INT
);


-- Stores categories for food items (e.g., "Pizzas," "Desserts").
CREATE TABLE FoodCategories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL,
    description TEXT
);


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


-- Links food items to their respective categories. A food item can belong to multiple categories.
CREATE TABLE FoodItemCategories (
    food_item_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (food_item_id, category_id)
);


-- Stores different variants for a food item (e.g., sizes, patty counts).
CREATE TABLE FoodItemVariants (
    variant_id INT AUTO_INCREMENT PRIMARY KEY,
    food_item_id INT NOT NULL,
    variant_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    unit VARCHAR(50),
    is_out_of_stock BOOLEAN NOT NULL DEFAULT FALSE
);


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


-- Stores allergens and ingredients for food items.
CREATE TABLE FoodItemAllergensIngredients (
    allergen_ingredient_id INT AUTO_INCREMENT PRIMARY KEY,
    food_item_id INT UNIQUE NOT NULL,
    allergens TEXT,
    ingredients TEXT
);


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


-- Defines which days of the week an offer is valid.
CREATE TABLE OfferApplicableDays (
    offer_id INT NOT NULL,
    day_of_week VARCHAR(10) NOT NULL CHECK (day_of_week IN ('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY', 'SUNDAY')),
    PRIMARY KEY (offer_id, day_of_week)
);


-- Links offers to specific food categories they apply to.
CREATE TABLE OfferApplicableCategories (
    offer_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (offer_id, category_id)
);


-- Links offers to specific food items they apply to.
CREATE TABLE OfferApplicableFoodItems (
    offer_id INT NOT NULL,
    food_item_id INT NOT NULL,
    PRIMARY KEY (offer_id, food_item_id)
);


-- Stores categories for gallery images.
CREATE TABLE GalleryCategories (
    gallery_category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL
);


-- Stores details of images displayed in the gallery.
CREATE TABLE GalleryImages (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(500) NOT NULL,
    title VARCHAR(255),
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Links gallery images to their respective categories.
CREATE TABLE GalleryImageCategories (
    image_id INT NOT NULL,
    gallery_category_id INT NOT NULL,
    PRIMARY KEY (image_id, gallery_category_id)
);


-- Stores messages sent by customers via the contact form.
CREATE TABLE CustomerMessages (
    message_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    email_address VARCHAR(255),
    message_content TEXT NOT NULL,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL DEFAULT 'UNREAD' CHECK (status IN ('UNREAD', 'READ')),
    is_pinned BOOLEAN NOT NULL DEFAULT FALSE
);


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


-- Stores customer reservation details.
CREATE TABLE Reservations (
    reservation_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NOT NULL,
    email_address VARCHAR(255),
    number_of_people INT NOT NULL,
    reservation_date DATE NOT NULL,
    reservation_time TIME NOT NULL,
    made_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'CONFIRMED', 'CANCELLED', 'COMPLETED'))
);


-- Stores overall order details for the WhatsApp-based checkout system.
CREATE TABLE Orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_number VARCHAR(100) UNIQUE NOT NULL,
    customer_full_name VARCHAR(255) NOT NULL,
    customer_phone_number VARCHAR(20) NOT NULL,
    customer_email_address VARCHAR(255),
    delivery_address TEXT,
    payment_method VARCHAR(50) NOT NULL CHECK (payment_method IN ('CASH_ON_DELIVERY', 'ONLINE_PAYMENT')),
    order_type VARCHAR(50) NOT NULL CHECK (order_type IN ('PICK_UP', 'DELIVERY')),
    delivery_charge DECIMAL(10,2) DEFAULT 0.00,
    overall_custom_instructions TEXT,
    subtotal_amount DECIMAL(10,2) NOT NULL,
    discount_amount DECIMAL(10,2) DEFAULT 0.00,
    total_amount DECIMAL(10,2) NOT NULL,
    order_status VARCHAR(50) NOT NULL DEFAULT 'PENDING' CHECK (order_status IN ('PENDING', 'CONFIRMED', 'PREPARING', 'OUT_FOR_DELIVERY', 'DELIVERED', 'CANCELLED')),
    ordered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Stores individual food items within an order.
CREATE TABLE OrderItems (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    food_item_id INT NOT NULL,
    variant_id INT,
    quantity INT NOT NULL,
    price_at_order DECIMAL(10,2) NOT NULL,
    custom_instructions TEXT
);


-- Records which offers were applied to a specific order.
CREATE TABLE AppliedOffers (
    order_id INT NOT NULL,
    offer_id INT NOT NULL,
    discount_applied DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (order_id, offer_id)
);


-- Stores images of the restaurant's physical menu.
CREATE TABLE ActualMenuImages (
    menu_image_id INT AUTO_INCREMENT PRIMARY KEY,
    image_url VARCHAR(500) NOT NULL,
    uploaded_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- Foreign Key Constraints --
-- Foreign Key for Locations Table
-- Links location to the main restaurant settings.
ALTER TABLE Locations
ADD CONSTRAINT fk_locations_restaurant_settings
FOREIGN KEY (restaurant_id) REFERENCES RestaurantSettings(setting_id) ON DELETE RESTRICT;

-- Foreign Keys for FoodItemCategories Junction Table
-- Links to FoodItems table.
ALTER TABLE FoodItemCategories
ADD CONSTRAINT fk_fooditemcategories_fooditem
FOREIGN KEY (food_item_id) REFERENCES FoodItems(food_item_id) ON DELETE CASCADE;
-- Links to FoodCategories table.
ALTER TABLE FoodItemCategories
ADD CONSTRAINT fk_fooditemcategories_category
FOREIGN KEY (category_id) REFERENCES FoodCategories(category_id) ON DELETE CASCADE;

-- Foreign Key for FoodItemVariants Table
-- Links variant to its parent food item.
ALTER TABLE FoodItemVariants
ADD CONSTRAINT fk_fooditemvariants_fooditem
FOREIGN KEY (food_item_id) REFERENCES FoodItems(food_item_id) ON DELETE CASCADE;

-- Foreign Key for FoodItemNutrition Table
-- Links nutrition information to a food item.
ALTER TABLE FoodItemNutrition
ADD CONSTRAINT fk_fooditemnutrition_fooditem
FOREIGN KEY (food_item_id) REFERENCES FoodItems(food_item_id) ON DELETE CASCADE;

-- Foreign Key for FoodItemAllergensIngredients Table
-- Links allergens/ingredients to a food item.
ALTER TABLE FoodItemAllergensIngredients
ADD CONSTRAINT fk_fooditemallergensingredients_fooditem
FOREIGN KEY (food_item_id) REFERENCES FoodItems(food_item_id) ON DELETE CASCADE;

-- Foreign Key for OfferApplicableDays Table
-- Links applicable day to an offer.
ALTER TABLE OfferApplicableDays
ADD CONSTRAINT fk_offerapplicabledays_offer
FOREIGN KEY (offer_id) REFERENCES Offers(offer_id) ON DELETE CASCADE;

-- Foreign Keys for OfferApplicableCategories Junction Table
-- Links to Offers table.
ALTER TABLE OfferApplicableCategories
ADD CONSTRAINT fk_offerapplicablecategories_offer
FOREIGN KEY (offer_id) REFERENCES Offers(offer_id) ON DELETE CASCADE;
-- Links to FoodCategories table.
ALTER TABLE OfferApplicableCategories
ADD CONSTRAINT fk_offerapplicablecategories_category
FOREIGN KEY (category_id) REFERENCES FoodCategories(category_id) ON DELETE CASCADE;

-- Foreign Keys for OfferApplicableFoodItems Junction Table
-- Links to Offers table.
ALTER TABLE OfferApplicableFoodItems
ADD CONSTRAINT fk_offerapplicablefooditems_offer
FOREIGN KEY (offer_id) REFERENCES Offers(offer_id) ON DELETE CASCADE;
-- Links to FoodItems table.
ALTER TABLE OfferApplicableFoodItems
ADD CONSTRAINT fk_offerapplicablefooditems_fooditem
FOREIGN KEY (food_item_id) REFERENCES FoodItems(food_item_id) ON DELETE CASCADE;

-- Foreign Keys for GalleryImageCategories Junction Table
-- Links to GalleryImages table.
ALTER TABLE GalleryImageCategories
ADD CONSTRAINT fk_galleryimagecategories_image
FOREIGN KEY (image_id) REFERENCES GalleryImages(image_id) ON DELETE CASCADE;
-- Links to GalleryCategories table.
ALTER TABLE GalleryImageCategories
ADD CONSTRAINT fk_galleryimagecategories_gallerycategory
FOREIGN KEY (gallery_category_id) REFERENCES GalleryCategories(gallery_category_id) ON DELETE CASCADE;

-- Foreign Key for CustomerReviews Table
-- Links review to a specific food item, allowing food item to be deleted without losing review.
ALTER TABLE CustomerReviews
ADD CONSTRAINT fk_customerreviews_fooditem
FOREIGN KEY (food_item_id) REFERENCES FoodItems(food_item_id) ON DELETE SET NULL;

-- Foreign Keys for OrderItems Table
-- Links order item to its parent order.
ALTER TABLE OrderItems
ADD CONSTRAINT fk_orderitems_order
FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE;
-- Links order item to the specific food item.
ALTER TABLE OrderItems
ADD CONSTRAINT fk_orderitems_fooditem
FOREIGN KEY (food_item_id) REFERENCES FoodItems(food_item_id) ON DELETE RESTRICT;
-- Links order item to the specific food item variant.
ALTER TABLE OrderItems
ADD CONSTRAINT fk_orderitems_variant
FOREIGN KEY (variant_id) REFERENCES FoodItemVariants(variant_id) ON DELETE RESTRICT;

-- Foreign Keys for AppliedOffers Junction Table
-- Links applied offer to an order.
ALTER TABLE AppliedOffers
ADD CONSTRAINT fk_appliedoffers_order
FOREIGN KEY (order_id) REFERENCES Orders(order_id) ON DELETE CASCADE;
-- Links applied offer to the specific offer.
ALTER TABLE AppliedOffers
ADD CONSTRAINT fk_appliedoffers_offer
FOREIGN KEY (offer_id) REFERENCES Offers(offer_id) ON DELETE RESTRICT;


-- Indexes --
-- Index for Locations table
-- On restaurant_id for faster lookups of locations by restaurant.
CREATE INDEX idx_locations_restaurant_id ON Locations (restaurant_id);

-- Indexes for FoodItemCategories junction table
-- On food_item_id for faster lookups.
CREATE INDEX idx_fic_food_item_id ON FoodItemCategories (food_item_id);
-- On category_id for faster lookups.
CREATE INDEX idx_fic_category_id ON FoodItemCategories (category_id);

-- Index for FoodItemVariants table
-- On food_item_id for faster lookups of variants by food item.
CREATE INDEX idx_fiv_food_item_id ON FoodItemVariants (food_item_id);

-- Indexes for Offers table
-- On offer_type for filtering offers by type.
CREATE INDEX idx_offers_offer_type ON Offers (offer_type);
-- On validity dates for range queries on offer validity.
CREATE INDEX idx_offers_valid_from_to_date ON Offers (valid_from_date, valid_to_date);

-- Indexes for OfferApplicableDays junction table
-- On offer_id for faster lookups.
CREATE INDEX idx_oad_offer_id ON OfferApplicableDays (offer_id);
-- On day_of_week for filtering offers by day.
CREATE INDEX idx_oad_day_of_week ON OfferApplicableDays (day_of_week);

-- Indexes for OfferApplicableCategories junction table
-- On offer_id for faster lookups.
CREATE INDEX idx_oac_offer_id ON OfferApplicableCategories (offer_id);
-- On category_id for faster lookups.
CREATE INDEX idx_oac_category_id ON OfferApplicableCategories (category_id);

-- Indexes for OfferApplicableFoodItems junction table
-- On offer_id for faster lookups.
CREATE INDEX idx_oafi_offer_id ON OfferApplicableFoodItems (offer_id);
-- On food_item_id for faster lookups.
CREATE INDEX idx_oafi_food_item_id ON OfferApplicableFoodItems (food_item_id);

-- Indexes for GalleryImageCategories junction table
-- On image_id for faster lookups.
CREATE INDEX idx_gic_image_id ON GalleryImageCategories (image_id);
-- On gallery_category_id for faster lookups.
CREATE INDEX idx_gic_gallery_category_id ON GalleryImageCategories (gallery_category_id);

-- Indexes for CustomerMessages table
-- On status for filtering messages by status.
CREATE INDEX idx_cm_status ON CustomerMessages (status);
-- On is_pinned for quickly finding pinned messages.
CREATE INDEX idx_cm_is_pinned ON CustomerMessages (is_pinned);

-- Indexes for CustomerReviews table
-- On status for filtering reviews by approval status.
CREATE INDEX idx_cr_status ON CustomerReviews (status);
-- On food_item_id for finding reviews related to a specific food item.
CREATE INDEX idx_cr_food_item_id ON CustomerReviews (food_item_id);
-- On overall_rating for sorting or filtering by rating.
CREATE INDEX idx_cr_overall_rating ON CustomerReviews (overall_rating);

-- Indexes for Reservations table
-- On status for filtering reservations by status.
CREATE INDEX idx_reservations_status ON Reservations (status);
-- On reservation date and time for range queries and sorting.
CREATE INDEX idx_reservations_date_time ON Reservations (reservation_date, reservation_time);
-- On phone_number for looking up reservations by customer phone.
CREATE INDEX idx_reservations_phone_number ON Reservations (phone_number);

-- Indexes for Orders table
-- On order_status for filtering orders by status.
CREATE INDEX idx_orders_status ON Orders (order_status);
-- On customer_phone_number for looking up orders by customer phone.
CREATE INDEX idx_orders_customer_phone ON Orders (customer_phone_number);
-- On order_type for filtering orders by type.
CREATE INDEX idx_orders_type ON Orders (order_type);
-- On ordered_at for time-based analysis and sorting of orders.
CREATE INDEX idx_orders_ordered_at ON Orders (ordered_at);

-- Indexes for OrderItems table
-- On order_id for retrieving all items for a specific order.
CREATE INDEX idx_oi_order_id ON OrderItems (order_id);
-- On food_item_id for finding all orders containing a specific food item.
CREATE INDEX idx_oi_food_item_id ON OrderItems (food_item_id);
-- On variant_id for finding all orders containing a specific variant.
CREATE INDEX idx_oi_variant_id ON OrderItems (variant_id);

-- Indexes for AppliedOffers junction table
-- On order_id for finding offers applied to a specific order.
CREATE INDEX idx_ao_order_id ON AppliedOffers (order_id);
-- On offer_id for finding all orders where a specific offer was applied.
CREATE INDEX idx_ao_offer_id ON AppliedOffers (offer_id);
