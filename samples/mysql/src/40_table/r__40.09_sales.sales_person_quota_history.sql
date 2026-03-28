CREATE TABLE IF NOT EXISTS sales.sales_person_quota_history(
    business_entity_id INT NOT NULL COMMENT 'Sales person identification number. foreign key to sales_person.business_entity_id.'
   ,quota_date DATETIME NOT NULL COMMENT 'Sales quota date.'
   ,sales_quota DECIMAL(19,4) NOT NULL COMMENT 'Sales quota amount.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_sales_person_quota_history` PRIMARY KEY (business_entity_id, quota_date)
)
COMMENT 'Sales performance tracking.';
