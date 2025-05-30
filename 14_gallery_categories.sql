-- Stores categories for gallery images.
CREATE TABLE GalleryCategories (
    gallery_category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(100) UNIQUE NOT NULL
);
