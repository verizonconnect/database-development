CREATE TABLE IF NOT EXISTS person.address(
    address_id INT AUTO_INCREMENT COMMENT 'Primary key for address records.'
   ,address_line_1 VARCHAR(60) NOT NULL COMMENT 'First street address line.'
   ,address_line_2 VARCHAR(60) NULL COMMENT 'Second street address line.'
   ,city VARCHAR(30) NOT NULL COMMENT 'name of the city.'
   ,state_province_id INT NOT NULL COMMENT 'Unique identification number for the state or province. foreign key to state_province table.'
   ,postal_code VARCHAR(15) NOT NULL COMMENT 'Postal code for the street address.'
   ,spatial_location BLOB NULL COMMENT 'Latitude and longitude of this address.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_address` PRIMARY KEY (address_id)
)
COMMENT 'Street address information for customers, employees, and vendors.';
