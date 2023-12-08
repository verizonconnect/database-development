
IF OBJECT_ID('[production].[fk_product_document_document_document_node]', 'F') IS NULL
BEGIN
    ALTER TABLE [production].[product_document]  
    ADD CONSTRAINT [fk_product_document_document_document_node] 
    FOREIGN KEY (document_node)
    REFERENCES [production].[document] (document_node)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [production].[product_document] 
CHECK CONSTRAINT [fk_product_document_document_document_node];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product_document'
                                              , N'CONSTRAINT',N'fk_product_document_document_document_node'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing document.document_node.'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product_document'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_product_document_document_document_node'
GO
