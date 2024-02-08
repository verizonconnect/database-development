DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'sales_order_header'
                           AND tc.constraint_name = 'fk_sales_order_header_address_bill_to_address_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE sales.sales_order_header
        ADD CONSTRAINT "fk_sales_order_header_address_bill_to_address_id"
        FOREIGN KEY (bill_to_address_id)
        REFERENCES person.address(address_id);
    END IF;
END$$
