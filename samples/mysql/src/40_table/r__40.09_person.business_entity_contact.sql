CREATE TABLE IF NOT EXISTS person.business_entity_contact(
    business_entity_id INT NOT NULL COMMENT 'Primary key. foreign key to business_entity.business_entity_id.'
   ,person_id INT NOT NULL COMMENT 'Primary key. foreign key to person.business_entity_id.'
   ,contact_type_id INT NOT NULL COMMENT 'Primary key.  foreign key to contact_type.contact_type_id.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_business_entity_contact` PRIMARY KEY (business_entity_id, person_id, contact_type_id)
)
COMMENT 'Cross-reference table mapping stores, vendors, and employees to people';
