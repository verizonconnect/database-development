CREATE TABLE IF NOT EXISTS person.contact_type(
    contact_type_id INT AUTO_INCREMENT COMMENT 'Primary key for contact_type records.'
   ,name VARCHAR(50) NOT NULL COMMENT 'Contact type description.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_contact_type` PRIMARY KEY (contact_type_id)
)
COMMENT 'Lookup table containing the types of business entity contacts.';
