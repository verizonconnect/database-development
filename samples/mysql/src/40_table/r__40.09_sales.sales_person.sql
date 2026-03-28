CREATE TABLE IF NOT EXISTS sales.sales_person(
    business_entity_id INT NOT NULL COMMENT 'Primary key for sales_person records. foreign key to employee.business_entity_id'
   ,territory_id INT NULL COMMENT 'Territory currently assigned to. foreign key to sales_territory.sales_territory_id.'
   ,sales_quota DECIMAL(19,4) NULL COMMENT 'Projected yearly sales.'
   ,bonus DECIMAL(19,4) NOT NULL DEFAULT (0.00) COMMENT 'Bonus due if quota is met.'
   ,commission_pct DECIMAL(19,4) NOT NULL DEFAULT (0.00) COMMENT 'Commision percent received per sale.'
   ,sales_ytd DECIMAL(19,4) NOT NULL DEFAULT (0.00) COMMENT 'Sales total year to date.'
   ,sales_last_year DECIMAL(19,4) NOT NULL DEFAULT (0.00) COMMENT 'Sales total of previous year.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_sales_person` PRIMARY KEY (business_entity_id)
)
COMMENT 'Sales representative current information.';
