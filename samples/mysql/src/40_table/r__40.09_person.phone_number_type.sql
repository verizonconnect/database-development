CREATE TABLE IF NOT EXISTS person.phone_number_type(
    phone_number_type_id INT AUTO_INCREMENT COMMENT 'Primary key for telephone number type records.'
   ,name VARCHAR(50) NOT NULL COMMENT 'name of the telephone number type'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_phone_number_type` PRIMARY KEY (phone_number_type_id)
)
COMMENT 'Type of phone number of a person.';
