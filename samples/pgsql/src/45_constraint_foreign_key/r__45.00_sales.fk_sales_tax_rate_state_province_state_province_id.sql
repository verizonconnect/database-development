DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'sales_tax_rate'
                           AND tc.constraint_name = 'fk_sales_tax_rate_state_province_state_province_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE sales.sales_tax_rate
        ADD CONSTRAINT "fk_sales_tax_rate_state_province_state_province_id"
        FOREIGN KEY (state_province_id)
        REFERENCES person.state_province(state_province_id);
    END IF;
END$$
