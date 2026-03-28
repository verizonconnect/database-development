CREATE TABLE IF NOT EXISTS person.business_entity(
    business_entity_id  INT AUTO_INCREMENT COMMENT 'Primary key for all customers, vendors, and employees.'
   ,rowguid             CHAR(36)      NOT NULL DEFAULT (UUID())
   ,modified_date       DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_business_entity` PRIMARY KEY (business_entity_id)
)
COMMENT 'Source of the ID that connects vendors, customers, and employees with address and contact information.';
