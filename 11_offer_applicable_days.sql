-- Defines which days of the week an offer is valid.
CREATE TABLE OfferApplicableDays (
    offer_id INT NOT NULL,
    day_of_week VARCHAR(10) NOT NULL CHECK (day_of_week IN ('MONDAY', 'TUESDAY', 'WEDNESDAY', 'THURSDAY', 'FRIDAY', 'SATURDAY', 'SUNDAY')),
    PRIMARY KEY (offer_id, day_of_week)
);
