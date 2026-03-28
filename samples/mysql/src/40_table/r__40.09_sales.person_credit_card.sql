CREATE TABLE IF NOT EXISTS sales.person_credit_card(
    business_entity_id INT NOT NULL COMMENT 'Business entity identification number. foreign key to person.business_entity_id.'
   ,credit_card_id INT NOT NULL COMMENT 'Credit card identification number. foreign key to credit_card.credit_card_id.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_person_credit_card` PRIMARY KEY (business_entity_id, credit_card_id)
)
COMMENT 'Cross-reference table mapping people to their credit card information in the credit_card table.';
