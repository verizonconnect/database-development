DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'special_offer_product'
                           AND tc.constraint_name = 'pk_special_offer_product'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE sales.special_offer_product
        ADD CONSTRAINT "pk_special_offer_product"
        PRIMARY KEY (special_offer_id, product_id);
    END IF;
END$$
