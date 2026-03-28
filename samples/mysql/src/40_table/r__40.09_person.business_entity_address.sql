CREATE TABLE IF NOT EXISTS person.business_entity_address(
    business_entity_id INT NOT NULL COMMENT 'Primary key. foreign key to business_entity.business_entity_id.'
   ,address_id INT NOT NULL COMMENT 'Primary key. foreign key to address.address_id.'
   ,address_type_id INT NOT NULL COMMENT 'Primary key. foreign key to address_type.address_type_id.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_business_entity_address` PRIMARY KEY (business_entity_id, address_id, address_type_id)
)
COMMENT 'Cross-reference table mapping customers, vendors, and employees to their addresses.';
