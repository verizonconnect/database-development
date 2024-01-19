CREATE TABLE IF NOT EXISTS production.document(
    document_node VARCHAR NOT NULL DEFAULT ('/')
   ,title VARCHAR(50) NOT NULL
   ,owner INT NOT NULL
   ,folder_flag common.flag NOT NULL DEFAULT (false)
   ,file_name VARCHAR(400) NOT NULL
   ,file_extension VARCHAR(8) NULL
   ,revision char(5) NOT NULL
   ,change_number INT NOT NULL DEFAULT (0)
   ,status SMALLINT NOT NULL
   ,document_summary text NULL
   ,document bytea  NULL
   ,rowguid uuid NOT NULL UNIQUE DEFAULT (common.uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
  
COMMENT ON TABLE production.document IS 'product maintenance documents.';
COMMENT ON COLUMN production.document.document_node IS 'Primary key for document records.';
COMMENT ON COLUMN production.document.title IS 'title of the document.';
COMMENT ON COLUMN production.document.owner IS 'employee who controls the document.  foreign key to employee.business_entity_id';
COMMENT ON COLUMN production.document.folder_flag IS '0 = this is a folder, 1 = this is a document.';
COMMENT ON COLUMN production.document.file_name IS 'File name of the document';
COMMENT ON COLUMN production.document.file_extension IS 'File extension indicating the document type. for example, .doc or .txt.';
COMMENT ON COLUMN production.document.revision IS 'revision number of the document.';
COMMENT ON COLUMN production.document.change_number IS 'Engineering change approval number.';
COMMENT ON COLUMN production.document.status IS '1 = pending approval, 2 = approved, 3 = obsolete';
COMMENT ON COLUMN production.document.document_summary IS 'document abstract.';
COMMENT ON COLUMN production.document.document IS 'Complete document.';
COMMENT ON COLUMN production.document.rowguid IS 'ROWGUIDCOL number uniquely identifying the record. required for file_stream.';