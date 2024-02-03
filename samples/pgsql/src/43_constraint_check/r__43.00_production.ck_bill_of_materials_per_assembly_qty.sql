﻿DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'production'
                           AND ccu.table_name = 'bill_of_materials'
                           AND ccu.column_name = 'per_assembly_qty'
                           AND ccu.constraint_name = 'ck_bill_of_materials_per_assembly_qty')
    THEN
        ALTER TABLE production.bill_of_materials
        ADD CONSTRAINT ck_bill_of_materials_per_assembly_qty
        CHECK (per_assembly_qty >= 1.00);
    END IF;
END$$
