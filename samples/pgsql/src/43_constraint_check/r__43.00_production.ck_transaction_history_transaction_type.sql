DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'production'
                           AND ccu.table_name = 'transaction_history'
                           AND ccu.column_name = 'transaction_type'
                           AND ccu.constraint_name = 'ck_transaction_history_transaction_type')
    THEN
        ALTER TABLE production.transaction_history
        ADD CONSTRAINT ck_transaction_history_transaction_type
        CHECK (UPPER(transaction_type) IN ('W','S','P'));
    END IF;
END$$
