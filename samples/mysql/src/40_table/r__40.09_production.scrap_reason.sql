CREATE TABLE IF NOT EXISTS production.scrap_reason(
    scrap_reason_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for scrap_reason records.'
   ,name VARCHAR(50) NOT NULL COMMENT 'Failure description.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_scrap_reason` PRIMARY KEY (scrap_reason_id)
)
COMMENT 'Manufacturing failure reasons lookup table.';
