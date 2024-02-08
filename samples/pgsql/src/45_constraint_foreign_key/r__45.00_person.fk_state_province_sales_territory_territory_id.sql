DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'person'
                           AND tc.table_name = 'state_province'
                           AND tc.constraint_name = 'fk_state_province_sales_territory_territory_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE person.state_province
        ADD CONSTRAINT "fk_state_province_sales_territory_territory_id"
        FOREIGN KEY (territory_id)
        REFERENCES sales.sales_territory(territory_id);
    END IF;
END$$
