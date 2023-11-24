
IF OBJECT_ID('[production].[pk_product_document_product_id_document_node]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [production].[product_document]
        ADD CONSTRAINT [pk_product_document_product_id_document_node]
        PRIMARY KEY CLUSTERED (product_id ASC, document_node ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product_document'
                                              , N'CONSTRAINT',N'pk_product_document_product_id_document_node'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product_document'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_product_document_product_id_document_node'
GO
