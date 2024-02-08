DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'product'
                           AND tc.constraint_name = 'fk_product_unit_measure_weight_unit_measure_code'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE production.product
        ADD CONSTRAINT "fk_product_unit_measure_weight_unit_measure_code"
        FOREIGN KEY (weight_unit_measure_code)
        REFERENCES production.unit_measure(unit_measure_code);
    END IF;
END$$
