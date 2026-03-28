CREATE TABLE IF NOT EXISTS production.illustration(
    illustration_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for illustration records.'
   ,diagram TEXT NULL COMMENT 'illustrations used in manufacturing instructions. stored as XML.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_illustration` PRIMARY KEY (illustration_id)
)
COMMENT 'Bicycle assembly diagrams.';
