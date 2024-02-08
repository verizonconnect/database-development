DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'person'
                           AND tc.table_name = 'state_province'
                           AND tc.constraint_name = 'fk_state_province_country_region_country_region_code'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE person.state_province
        ADD CONSTRAINT "fk_state_province_country_region_country_region_code"
        FOREIGN KEY (country_region_code)
        REFERENCES person.country_region(country_region_code);
    END IF;
END$$
