DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'person'
                           AND tc.table_name = 'country_region'
                           AND tc.constraint_name = 'pk_country_region'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE person.country_region
        ADD CONSTRAINT "pk_country_region"
        PRIMARY KEY (country_region_code);
    END IF;
END$$
