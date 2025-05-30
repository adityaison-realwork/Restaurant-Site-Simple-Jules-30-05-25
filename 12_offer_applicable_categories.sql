-- Links offers to specific food categories they apply to.
CREATE TABLE OfferApplicableCategories (
    offer_id INT NOT NULL,
    category_id INT NOT NULL,
    PRIMARY KEY (offer_id, category_id)
);
