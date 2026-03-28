CREATE TABLE IF NOT EXISTS person.address_type(
    address_type_id INT AUTO_INCREMENT COMMENT 'Primary key for address_type records.'
   ,name VARCHAR(50) NOT NULL COMMENT 'address type description. for example, billing, home, or shipping.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_address_type` PRIMARY KEY (address_type_id)
)
COMMENT 'Types of addresses stored in the address table.';
