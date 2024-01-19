CREATE TABLE IF NOT EXISTS sales.sales_territory_history(
    business_entity_id INT NOT NULL
   ,territory_id INT NOT NULL
   ,start_date TIMESTAMP NOT NULL
   ,end_date TIMESTAMP NULL
   ,rowguid uuid NOT NULL DEFAULT (uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);
COMMENT ON TABLE sales.sales_territory_history IS 'Sales representative transfers to other sales territories.';
COMMENT ON COLUMN sales.sales_territory_history.business_entity_id IS 'Primary key. the sales rep.  foreign key to sales_person.business_entity_id.';
COMMENT ON COLUMN sales.sales_territory_history.territory_id IS 'Primary key. territory identification number. foreign key to sales_territory.sales_territory_id.';
COMMENT ON COLUMN sales.sales_territory_history.start_date IS 'Primary key. date the sales representive started work in the territory.';
COMMENT ON COLUMN sales.sales_territory_history.end_date IS 'Date the sales representative left work in the territory.';