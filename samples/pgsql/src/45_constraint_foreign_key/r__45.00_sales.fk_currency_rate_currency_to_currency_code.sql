DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'currency_rate'
                           AND tc.constraint_name = 'fk_currency_rate_currency_to_currency_code'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE sales.currency_rate
        ADD CONSTRAINT "fk_currency_rate_currency_to_currency_code"
        FOREIGN KEY (to_currency_code)
        REFERENCES sales.currency(currency_code);
    END IF;
END$$
