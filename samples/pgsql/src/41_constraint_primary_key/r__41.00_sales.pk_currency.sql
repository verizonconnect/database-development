DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'currency'
                           AND tc.constraint_name = 'pk_currency'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE sales.currency
        ADD CONSTRAINT "pk_currency"
        PRIMARY KEY (currency_code);
    END IF;
END$$
