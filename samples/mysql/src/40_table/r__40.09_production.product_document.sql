CREATE TABLE IF NOT EXISTS production.product_document(
    product_id INT NOT NULL COMMENT 'product identification number. foreign key to product.product_id.'
   ,document_node VARCHAR(255) NOT NULL DEFAULT ('/') COMMENT 'document identification number. foreign key to document.document_node.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_product_document` PRIMARY KEY (product_id, document_node)
)
COMMENT 'Cross-reference table mapping products to related product documents.';
