DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'production'
                           AND tc.table_name = 'product_document'
                           AND tc.constraint_name = 'fk_product_document_document_document_node'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE production.product_document
        ADD CONSTRAINT "fk_product_document_document_document_node"
        FOREIGN KEY (document_node)
        REFERENCES production.document(document_node);
    END IF;
END$$
