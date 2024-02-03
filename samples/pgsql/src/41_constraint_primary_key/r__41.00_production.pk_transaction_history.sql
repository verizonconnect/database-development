DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'transaction_history'
                           AND tc.constraint_name = 'pk_transaction_history'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.transaction_history
        ADD CONSTRAINT "pk_transaction_history"
        PRIMARY KEY (transaction_id);
    END IF;
END$$
