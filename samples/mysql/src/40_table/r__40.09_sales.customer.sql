CREATE TABLE IF NOT EXISTS sales.customer(
    customer_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key.'
   ,person_id INT NULL COMMENT 'Foreign key to person.business_entity_id'
   ,store_id INT NULL COMMENT 'Foreign key to store.business_entity_id'
   ,territory_id INT NULL COMMENT 'ID of the territory in which the customer is located. foreign key to sales_territory.sales_territory_id.'
   ,account_number VARCHAR(15)
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_customer` PRIMARY KEY (customer_id)
)
COMMENT 'Current customer information. also see the person and store tables.';
