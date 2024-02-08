DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'bill_of_materials'
                           AND tc.constraint_name = 'fk_bill_of_materials_unit_measure_unit_measure_code'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE production.bill_of_materials
        ADD CONSTRAINT "fk_bill_of_materials_unit_measure_unit_measure_code"
        FOREIGN KEY (unit_measure_code)
        REFERENCES production.unit_measure(unit_measure_code);
    END IF;
END$$
