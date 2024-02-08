DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'country_region_currency'
                           AND tc.constraint_name = 'fk_country_region_currency_country_region_country_region_code'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE sales.country_region_currency
        ADD CONSTRAINT "fk_country_region_currency_country_region_country_region_code"
        FOREIGN KEY (country_region_code)
        REFERENCES person.country_region(country_region_code);
    END IF;
END$$
