DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'bill_of_materials'
                           AND tc.constraint_name = 'fk_bill_of_materials_product_product_assembly_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE production.bill_of_materials
        ADD CONSTRAINT "fk_bill_of_materials_product_product_assembly_id"
        FOREIGN KEY (product_assembly_id)
        REFERENCES production.product(product_id);
    END IF;
END$$
