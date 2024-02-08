DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'sales_order_header'
                           AND tc.constraint_name = 'fk_sales_order_header_credit_card_credit_card_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE sales.sales_order_header
        ADD CONSTRAINT "fk_sales_order_header_credit_card_credit_card_id"
        FOREIGN KEY (credit_card_id)
        REFERENCES sales.credit_card(credit_card_id);
    END IF;
END$$
