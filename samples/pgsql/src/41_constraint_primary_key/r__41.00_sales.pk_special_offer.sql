DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'special_offer'
                           AND tc.constraint_name = 'pk_special_offer'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE sales.special_offer
        ADD CONSTRAINT "pk_special_offer"
        PRIMARY KEY (special_offer_id);
    END IF;
END$$
