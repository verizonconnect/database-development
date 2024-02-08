DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'sales_order_detail'
                           AND tc.constraint_name = 'fk_sales_order_detail_special_offer_product_special_offer_idproduct_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE sales.sales_order_detail
        ADD CONSTRAINT "fk_sales_order_detail_special_offer_product_special_offer_idproduct_id"
        FOREIGN KEY (special_offer_id, product_id)
        REFERENCES sales.special_offer_product(special_offer_id, product_id);
    END IF;
END$$
