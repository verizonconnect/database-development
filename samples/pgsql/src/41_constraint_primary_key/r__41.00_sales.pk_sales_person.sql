DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'sales_person'
                           AND tc.constraint_name = 'pk_sales_person'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE sales.sales_person
        ADD CONSTRAINT "pk_sales_person"
        PRIMARY KEY (business_entity_id);
    END IF;
END$$
