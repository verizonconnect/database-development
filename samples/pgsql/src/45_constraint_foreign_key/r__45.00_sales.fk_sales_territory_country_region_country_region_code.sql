DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'sales_territory'
                           AND tc.constraint_name = 'fk_sales_territory_country_region_country_region_code'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE sales.sales_territory
        ADD CONSTRAINT "fk_sales_territory_country_region_country_region_code"
        FOREIGN KEY (country_region_code)
        REFERENCES person.country_region(country_region_code);
    END IF;
END$$
