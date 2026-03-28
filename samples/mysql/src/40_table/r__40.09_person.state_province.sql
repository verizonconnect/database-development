CREATE TABLE IF NOT EXISTS person.state_province(
    state_province_id INT AUTO_INCREMENT COMMENT 'Primary key for state_province records.'
   ,state_province_code char(3) NOT NULL COMMENT 'ISO standard state or province code.'
   ,country_region_code VARCHAR(3) NOT NULL COMMENT 'ISO standard country or region code. foreign key to country_region.country_region_code.'
   ,is_only_state_province_flag BOOLEAN NOT NULL DEFAULT (true) COMMENT '0 = state_province_code exists. 1 = state_province_code unavailable, using country_region_code.'
   ,name VARCHAR(50) NOT NULL COMMENT 'State or province description.'
   ,territory_id INT NOT NULL COMMENT 'ID of the territory in which the state or province is located. foreign key to sales_territory.sales_territory_id.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID()) 
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_state_province` PRIMARY KEY (state_province_id)
)
COMMENT 'State and province lookup table.';
