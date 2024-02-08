DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'purchasing'
                           AND tc.table_name = 'product_vendor'
                           AND tc.constraint_name = 'fk_product_vendor_unit_measure_unit_measure_code'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE purchasing.product_vendor
        ADD CONSTRAINT "fk_product_vendor_unit_measure_unit_measure_code"
        FOREIGN KEY (unit_measure_code)
        REFERENCES production.unit_measure(unit_measure_code);
    END IF;
END$$
