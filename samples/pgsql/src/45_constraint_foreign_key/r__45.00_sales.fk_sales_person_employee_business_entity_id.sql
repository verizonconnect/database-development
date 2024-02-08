DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'sales_person'
                           AND tc.constraint_name = 'fk_sales_person_employee_business_entity_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE sales.sales_person
        ADD CONSTRAINT "fk_sales_person_employee_business_entity_id"
        FOREIGN KEY (business_entity_id)
        REFERENCES human_resources.employee(business_entity_id);
    END IF;
END$$
