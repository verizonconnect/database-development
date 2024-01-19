CREATE TABLE IF NOT EXISTS sales.customer(
    customer_id SERIAL NOT NULL
   ,person_id INT NULL
   ,store_id INT NULL
   ,territory_id INT NULL
   ,account_number VARCHAR
   ,rowguid uuid NOT NULL DEFAULT (common.uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);
COMMENT ON TABLE sales.customer IS 'Current customer information. also see the person and store tables.';
COMMENT ON COLUMN sales.customer.customer_id IS 'Primary key.';
COMMENT ON COLUMN sales.customer.person_id IS 'Foreign key to person.business_entity_id';
COMMENT ON COLUMN sales.customer.store_id IS 'Foreign key to store.business_entity_id';
COMMENT ON COLUMN sales.customer.territory_id IS 'ID of the territory in which the customer is located. foreign key to sales_territory.sales_territory_id.';