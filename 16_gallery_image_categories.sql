-- Links gallery images to their respective categories.
CREATE TABLE GalleryImageCategories (
    image_id INT NOT NULL,
    gallery_category_id INT NOT NULL,
    PRIMARY KEY (image_id, gallery_category_id)
);
