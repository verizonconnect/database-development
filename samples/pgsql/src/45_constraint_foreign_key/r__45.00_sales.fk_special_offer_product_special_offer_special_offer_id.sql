DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'special_offer_product'
                           AND tc.constraint_name = 'fk_special_offer_product_special_offer_special_offer_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE sales.special_offer_product
        ADD CONSTRAINT "fk_special_offer_product_special_offer_special_offer_id"
        FOREIGN KEY (special_offer_id)
        REFERENCES sales.special_offer(special_offer_id);
    END IF;
END$$
