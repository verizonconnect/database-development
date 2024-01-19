CREATE TABLE IF NOT EXISTS sales.store(
    business_entity_id INT NOT NULL
   ,name common.name NOT NULL
   ,sales_person_id INT NULL
   ,demographics XML NULL
   ,rowguid uuid NOT NULL DEFAULT (common.uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);
COMMENT ON TABLE sales.store IS 'Customers (resellers) of adventure works products.';
COMMENT ON COLUMN sales.store.business_entity_id IS 'Primary key. foreign key to customer.business_entity_id.';
COMMENT ON COLUMN sales.store.name IS 'name of the store.';
COMMENT ON COLUMN sales.store.sales_person_id IS 'ID of the sales person assigned to the customer. foreign key to sales_person.business_entity_id.';
COMMENT ON COLUMN sales.store.demographics IS 'Demographic informationg about the store such as the number of employees, annual sales and store type.';