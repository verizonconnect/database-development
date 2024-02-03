DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'product_document'
                           AND tc.constraint_name = 'pk_product_document'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE production.product_document
        ADD CONSTRAINT "pk_product_document"
        PRIMARY KEY (product_id, document_node);
    END IF;
END$$
