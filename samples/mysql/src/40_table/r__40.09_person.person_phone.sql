CREATE TABLE IF NOT EXISTS person.person_phone(
    business_entity_id INT NOT NULL COMMENT 'Business entity identification number. foreign key to person.business_entity_id.'
   ,phone_number VARCHAR(25) NOT NULL COMMENT 'Telephone number identification number.'
   ,phone_number_type_id INT NOT NULL COMMENT 'Kind of phone number. foreign key to phone_number_type.phone_number_type_id.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_person_phone` PRIMARY KEY (business_entity_id, phone_number, phone_number_type_id)
)
COMMENT 'Telephone number and type of a person.';
