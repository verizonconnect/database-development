CREATE TABLE IF NOT EXISTS person.password(
    business_entity_id INT NOT NULL
   ,password_hash VARCHAR(128) NOT NULL COMMENT 'password for the e-mail account.'
   ,password_salt VARCHAR(10) NOT NULL COMMENT 'Random value concatenated with the password string before the password is hashed.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_password` PRIMARY KEY (business_entity_id)
)
COMMENT 'One way hashed authentication information';
