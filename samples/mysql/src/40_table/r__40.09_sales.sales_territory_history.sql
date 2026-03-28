CREATE TABLE IF NOT EXISTS sales.sales_territory_history(
    business_entity_id INT NOT NULL COMMENT 'Primary key. the sales rep.  foreign key to sales_person.business_entity_id.'
   ,territory_id INT NOT NULL COMMENT 'Primary key. territory identification number. foreign key to sales_territory.sales_territory_id.'
   ,start_date DATETIME NOT NULL COMMENT 'Primary key. date the sales representive started work in the territory.'
   ,end_date DATETIME NULL COMMENT 'Date the sales representative left work in the territory.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_sales_territory_history` PRIMARY KEY (business_entity_id,start_date, territory_id)
)
COMMENT 'Sales representative transfers to other sales territories.';
