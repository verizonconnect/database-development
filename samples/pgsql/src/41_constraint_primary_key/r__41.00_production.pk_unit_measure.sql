DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'unit_measure'
                           AND tc.constraint_name = 'pk_unit_measure'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.unit_measure
        ADD CONSTRAINT "pk_unit_measure"
        PRIMARY KEY (unit_measure_code);
    END IF;
END$$
