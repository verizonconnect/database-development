CREATE TABLE IF NOT EXISTS purchasing.vendor(
    business_entity_id INT NOT NULL COMMENT 'Primary key for vendor records.  foreign key to business_entity.business_entity_id'
   ,account_number VARCHAR(15) NOT NULL COMMENT 'Vendor account (identification) number.'
   ,name VARCHAR(50) NOT NULL COMMENT 'Company name.'
   ,credit_rating SMALLINT NOT NULL COMMENT '1 = superior, 2 = excellent, 3 = above average, 4 = average, 5 = below average'
   ,preferred_vendor_status BOOLEAN NOT NULL DEFAULT (true) COMMENT '0 = do not use if another vendor is available. 1 = preferred over other vendors supplying the same product.'
   ,active_flag BOOLEAN NOT NULL DEFAULT (true) COMMENT '0 = vendor no longer used. 1 = vendor is actively used.'
   ,purchasing_web_service_url varchar(1024) NULL COMMENT 'Vendor url.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_vendor` PRIMARY KEY (business_entity_id)
)
COMMENT 'Companies from whom adventure works cycles purchase_s parts or other goods.';
