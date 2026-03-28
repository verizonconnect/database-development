CREATE TABLE IF NOT EXISTS production.culture(
    culture_id CHAR(6) NOT NULL COMMENT 'Primary key for culture records.'
   ,name VARCHAR(50) NOT NULL COMMENT 'culture description.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_culture` PRIMARY KEY (culture_id)
)
COMMENT 'Lookup table containing the languages in which some adventure_works data is stored.';
