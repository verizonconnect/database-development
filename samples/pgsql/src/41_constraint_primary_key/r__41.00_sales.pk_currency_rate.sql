DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'currency_rate'
                           AND tc.constraint_name = 'pk_currency_rate'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE sales.currency_rate
        ADD CONSTRAINT "pk_currency_rate"
        PRIMARY KEY (currency_rate_id);
    END IF;
END$$
