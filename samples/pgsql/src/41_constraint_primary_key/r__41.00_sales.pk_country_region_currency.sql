DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'country_region_currency'
                           AND tc.constraint_name = 'pk_country_region_currency'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE sales.country_region_currency
        ADD CONSTRAINT "pk_country_region_currency"
        PRIMARY KEY (country_region_code, currency_code);
    END IF;
END$$
