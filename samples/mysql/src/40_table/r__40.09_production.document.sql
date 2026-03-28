CREATE TABLE IF NOT EXISTS production.document(
    document_node VARCHAR(255) NOT NULL DEFAULT ('/') COMMENT 'Primary key for document records.'
   ,title VARCHAR(50) NOT NULL COMMENT 'title of the document.'
   ,owner INT NOT NULL COMMENT 'employee who controls the document.  foreign key to employee.business_entity_id'
   ,folder_flag BOOLEAN NOT NULL DEFAULT (false) COMMENT '0 = this is a folder, 1 = this is a document.'
   ,file_name VARCHAR(400) NOT NULL COMMENT 'File name of the document'
   ,file_extension VARCHAR(8) NULL COMMENT 'File extension indicating the document type. for example, .doc or .txt.'
   ,revision char(5) NOT NULL COMMENT 'revision number of the document.'
   ,change_number INT NOT NULL DEFAULT (0) COMMENT 'Engineering change approval number.'
   ,status SMALLINT NOT NULL COMMENT '1 = pending approval, 2 = approved, 3 = obsolete'
   ,document_summary text NULL COMMENT 'document abstract.'
   ,document BLOB  NULL COMMENT 'Complete document.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID()) COMMENT 'ROWGUIDCOL number uniquely identifying the record. required for file_stream.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_document` PRIMARY KEY (document_node)
)
COMMENT 'product maintenance documents.';
