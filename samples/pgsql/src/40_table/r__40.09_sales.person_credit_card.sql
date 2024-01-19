CREATE TABLE IF NOT EXISTS sales.person_credit_card(
    business_entity_id INT NOT NULL
   ,credit_card_id INT NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);
COMMENT ON TABLE sales.person_credit_card IS 'Cross-reference table mapping people to their credit card information in the credit_card table.';
COMMENT ON COLUMN sales.person_credit_card.business_entity_id IS 'Business entity identification number. foreign key to person.business_entity_id.';
COMMENT ON COLUMN sales.person_credit_card.credit_card_id IS 'Credit card identification number. foreign key to credit_card.credit_card_id.';