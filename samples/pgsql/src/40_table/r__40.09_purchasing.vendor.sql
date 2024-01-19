CREATE TABLE IF NOT EXISTS purchasing.vendor(
    business_entity_id INT NOT NULL
   ,account_number common.account_number NOT NULL
   ,name common.name NOT NULL
   ,credit_rating SMALLINT NOT NULL
   ,preferred_vendor_status common.flag NOT NULL DEFAULT (true)
   ,active_flag common.flag NOT NULL DEFAULT (true)
   ,purchasing_web_service_url varchar(1024) NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);

COMMENT ON TABLE purchasing.vendor IS 'Companies from whom adventure works cycles purchase_s parts or other goods.';
COMMENT ON COLUMN purchasing.vendor.business_entity_id IS 'Primary key for vendor records.  foreign key to business_entity.business_entity_id';
COMMENT ON COLUMN purchasing.vendor.account_number IS 'Vendor account (identification) number.';
COMMENT ON COLUMN purchasing.vendor.name IS 'Company name.';
COMMENT ON COLUMN purchasing.vendor.credit_rating IS '1 = superior, 2 = excellent, 3 = above average, 4 = average, 5 = below average';
COMMENT ON COLUMN purchasing.vendor.preferred_vendor_status IS '0 = do not use if another vendor is available. 1 = preferred over other vendors supplying the same product.';
COMMENT ON COLUMN purchasing.vendor.active_flag IS '0 = vendor no longer used. 1 = vendor is actively used.';
COMMENT ON COLUMN purchasing.vendor.purchasing_web_service_url IS 'Vendor url.';