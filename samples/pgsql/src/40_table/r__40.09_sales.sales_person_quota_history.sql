CREATE TABLE IF NOT EXISTS sales.sales_person_quota_history(
    business_entity_id INT NOT NULL
   ,quota_date TIMESTAMP NOT NULL
   ,sales_quota NUMERIC NOT NULL
   ,rowguid uuid NOT NULL DEFAULT (uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);
COMMENT ON TABLE sales.sales_person_quota_history IS 'Sales performance tracking.';
COMMENT ON COLUMN sales.sales_person_quota_history.business_entity_id IS 'Sales person identification number. foreign key to sales_person.business_entity_id.';
COMMENT ON COLUMN sales.sales_person_quota_history.quota_date IS 'Sales quota date.';
COMMENT ON COLUMN sales.sales_person_quota_history.sales_quota IS 'Sales quota amount.';