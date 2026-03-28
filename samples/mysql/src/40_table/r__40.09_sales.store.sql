CREATE TABLE IF NOT EXISTS sales.store(
    business_entity_id INT NOT NULL COMMENT 'Primary key. foreign key to customer.business_entity_id.'
   ,name VARCHAR(50) NOT NULL COMMENT 'name of the store.'
   ,sales_person_id INT NULL COMMENT 'ID of the sales person assigned to the customer. foreign key to sales_person.business_entity_id.'
   ,demographics TEXT NULL COMMENT 'Demographic informationg about the store such as the number of employees, annual sales and store type.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_store` PRIMARY KEY (business_entity_id)
)
COMMENT 'Customers (resellers) of adventure works products.';
