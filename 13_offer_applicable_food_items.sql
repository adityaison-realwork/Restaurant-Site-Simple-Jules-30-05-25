-- Links offers to specific food items they apply to.
CREATE TABLE OfferApplicableFoodItems (
    offer_id INT NOT NULL,
    food_item_id INT NOT NULL,
    PRIMARY KEY (offer_id, food_item_id)
);
