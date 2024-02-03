DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'bill_of_materials'
                           AND tc.constraint_name = 'pk_bill_of_materials'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.bill_of_materials
        ADD CONSTRAINT "pk_bill_of_materials"
        PRIMARY KEY (bill_of_materials_id);
    END IF;
END$$
