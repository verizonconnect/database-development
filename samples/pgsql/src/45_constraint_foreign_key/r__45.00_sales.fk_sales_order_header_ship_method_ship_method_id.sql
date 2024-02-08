DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'sales_order_header'
                           AND tc.constraint_name = 'fk_sales_order_header_ship_method_ship_method_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE sales.sales_order_header
        ADD CONSTRAINT "fk_sales_order_header_ship_method_ship_method_id"
        FOREIGN KEY (ship_method_id)
        REFERENCES purchasing.ship_method(ship_method_id);
    END IF;
END$$
