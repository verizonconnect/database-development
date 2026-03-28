CREATE TABLE IF NOT EXISTS purchasing.ship_method(
    ship_method_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for ship_method records.'
   ,name VARCHAR(50) NOT NULL COMMENT 'Shipping company name.'
   ,ship_base DECIMAL(19,4) NOT NULL DEFAULT (0.00) COMMENT 'Minimum shipping charge.'
   ,ship_rate DECIMAL(19,4) NOT NULL DEFAULT (0.00) COMMENT 'Shipping charge per pound.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_ship_method` PRIMARY KEY (ship_method_id)
)
COMMENT 'Shipping company lookup table.';
