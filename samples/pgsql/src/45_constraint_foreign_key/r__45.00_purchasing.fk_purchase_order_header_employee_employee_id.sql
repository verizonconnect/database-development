DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'purchasing'
                           AND tc.table_name = 'purchase_order_header'
                           AND tc.constraint_name = 'fk_purchase_order_header_employee_employee_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE purchasing.purchase_order_header
        ADD CONSTRAINT "fk_purchase_order_header_employee_employee_id"
        FOREIGN KEY (employee_id)
        REFERENCES human_resources.employee(business_entity_id);
    END IF;
END$$
