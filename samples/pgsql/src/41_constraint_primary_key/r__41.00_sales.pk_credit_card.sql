DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'credit_card'
                           AND tc.constraint_name = 'pk_credit_card'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE sales.credit_card
        ADD CONSTRAINT "pk_credit_card"
        PRIMARY KEY (credit_card_id);
    END IF;
END$$
