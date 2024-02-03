DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.check_constraints AS cc
                           INNER JOIN information_schema.constraint_column_usage AS ccu ON ccu.constraint_schema = cc.constraint_schema
                               AND ccu.constraint_name = cc.constraint_name
                   WHERE   ccu.constraint_schema = 'production'
                           AND ccu.table_name = 'document'
                           AND ccu.column_name = 'status'
                           AND ccu.constraint_name = 'ck_document_status')
    THEN
        ALTER TABLE production.document
        ADD CONSTRAINT ck_document_status
        CHECK (status BETWEEN 1 AND 3);
    END IF;
END$$
