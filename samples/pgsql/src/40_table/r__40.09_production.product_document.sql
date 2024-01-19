CREATE TABLE IF NOT EXISTS production.product_document(
    product_id INT NOT NULL
   ,document_node VARCHAR NOT NULL DEFAULT ('/')
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);


COMMENT ON TABLE production.product_document IS 'Cross-reference table mapping products to related product documents.';
COMMENT ON COLUMN production.product_document.product_id IS 'product identification number. foreign key to product.product_id.';
COMMENT ON COLUMN production.product_document.document_node IS 'document identification number. foreign key to document.document_node.';