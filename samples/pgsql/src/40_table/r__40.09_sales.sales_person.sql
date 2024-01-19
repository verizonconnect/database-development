CREATE TABLE IF NOT EXISTS sales.sales_person(
    business_entity_id INT NOT NULL
   ,territory_id INT NULL
   ,sales_quota NUMERIC NULL
   ,bonus NUMERIC NOT NULL DEFAULT (0.00)
   ,commission_pct NUMERIC NOT NULL DEFAULT (0.00)
   ,sales_ytd NUMERIC NOT NULL DEFAULT (0.00)
   ,sales_last_year NUMERIC NOT NULL DEFAULT (0.00)
   ,rowguid uuid NOT NULL DEFAULT (uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);
COMMENT ON TABLE sales.sales_person IS 'Sales representative current information.';
COMMENT ON COLUMN sales.sales_person.business_entity_id IS 'Primary key for sales_person records. foreign key to employee.business_entity_id';
COMMENT ON COLUMN sales.sales_person.territory_id IS 'Territory currently assigned to. foreign key to sales_territory.sales_territory_id.';
COMMENT ON COLUMN sales.sales_person.sales_quota IS 'Projected yearly sales.';
COMMENT ON COLUMN sales.sales_person.bonus IS 'Bonus due if quota is met.';
COMMENT ON COLUMN sales.sales_person.commission_pct IS 'Commision percent received per sale.';
COMMENT ON COLUMN sales.sales_person.sales_ytd IS 'Sales total year to date.';
COMMENT ON COLUMN sales.sales_person.sales_last_year IS 'Sales total of previous year.';