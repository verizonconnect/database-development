CREATE TABLE IF NOT EXISTS person.email_address(
    business_entity_id INT NOT NULL COMMENT 'Primary key. person associated with this email address.  foreign key to person.business_entity_id'
   ,email_address_id INT AUTO_INCREMENT COMMENT 'Primary key. ID of this email address.'
   ,email_address VARCHAR(50) NULL COMMENT 'E-mail address for the person.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_email_address` PRIMARY KEY (email_address_id)
)
COMMENT 'Where to send a person email.';
