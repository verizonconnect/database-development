CREATE TABLE IF NOT EXISTS production.location(
    location_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for location records.'
   ,name VARCHAR(50) NOT NULL COMMENT 'location description.'
   ,cost_rate DECIMAL(19,4) NOT NULL DEFAULT (0.00) COMMENT 'Standard hourly cost of the manufacturing location.'
   ,availability DECIMAL(8, 2) NOT NULL DEFAULT (0.00) COMMENT 'Work capacity (in hours) of the manufacturing location.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_location` PRIMARY KEY (location_id)
)
COMMENT 'product inventory and manufacturing locations.';
