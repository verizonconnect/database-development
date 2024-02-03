DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'document'
                           AND tc.constraint_name = 'pk_document'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.document
        ADD CONSTRAINT "pk_document"
        PRIMARY KEY (document_node);
    END IF;
END$$
