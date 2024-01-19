CREATE TABLE IF NOT EXISTS sales.sales_territory(
    territory_id SERIAL NOT NULL
   ,name common.name NOT NULL
   ,country_region_code varchar(3) NOT NULL
   ,"group" varchar(50) NOT NULL
   ,sales_ytd NUMERIC NOT NULL DEFAULT (0.00)
   ,sales_last_year NUMERIC NOT NULL DEFAULT (0.00)
   ,cost_ytd NUMERIC NOT NULL DEFAULT (0.00)
   ,cost_last_year NUMERIC NOT NULL DEFAULT (0.00)
   ,rowguid uuid NOT NULL DEFAULT (uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);
COMMENT ON TABLE sales.sales_territory IS 'Sales territory lookup table.';
COMMENT ON COLUMN sales.sales_territory.territory_id IS 'Primary key for sales_territory records.';
COMMENT ON COLUMN sales.sales_territory.name IS 'Sales territory description';
COMMENT ON COLUMN sales.sales_territory.country_region_code IS 'ISO standard country or region code. foreign key to country_region.country_region_code.';
COMMENT ON COLUMN sales.sales_territory.group IS 'Geographic area to which the sales territory belong.';
COMMENT ON COLUMN sales.sales_territory.sales_ytd IS 'Sales in the territory year to date.';
COMMENT ON COLUMN sales.sales_territory.sales_last_year IS 'Sales in the territory the previous year.';
COMMENT ON COLUMN sales.sales_territory.cost_ytd IS 'Business costs in the territory year to date.';
COMMENT ON COLUMN sales.sales_territory.cost_last_year IS 'Business costs in the territory the previous year.';