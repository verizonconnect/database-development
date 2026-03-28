CREATE TABLE IF NOT EXISTS sales.sales_territory(
    territory_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for sales_territory records.'
   ,name VARCHAR(50) NOT NULL COMMENT 'Sales territory description'
   ,country_region_code varchar(3) NOT NULL COMMENT 'ISO standard country or region code. foreign key to country_region.country_region_code.'
   ,`group` varchar(50) NOT NULL
   ,sales_ytd DECIMAL(19,4) NOT NULL DEFAULT (0.00) COMMENT 'Sales in the territory year to date.'
   ,sales_last_year DECIMAL(19,4) NOT NULL DEFAULT (0.00) COMMENT 'Sales in the territory the previous year.'
   ,cost_ytd DECIMAL(19,4) NOT NULL DEFAULT (0.00) COMMENT 'Business costs in the territory year to date.'
   ,cost_last_year DECIMAL(19,4) NOT NULL DEFAULT (0.00) COMMENT 'Business costs in the territory the previous year.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_sales_territory` PRIMARY KEY (territory_id)
)
COMMENT 'Sales territory lookup table.';
