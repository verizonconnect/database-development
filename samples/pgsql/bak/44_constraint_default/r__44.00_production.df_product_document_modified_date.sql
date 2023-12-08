
IF OBJECT_ID('[production].[df_product_document_modified_date]', 'D') IS NULL
    BEGIN
        ALTER TABLE [production].[product_document]
        ADD CONSTRAINT [df_product_document_modified_date]
        DEFAULT (getdate())
        FOR [modified_date];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product_document'
                                              , N'CONSTRAINT',N'df_product_document_modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of GETDATE()'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product_document'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_product_document_modified_date'
GO
