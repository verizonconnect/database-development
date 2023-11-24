
IF OBJECT_ID('[production].[df_product_description_rowguid]', 'D') IS NULL
    BEGIN
        ALTER TABLE [production].[product_description]
        ADD CONSTRAINT [df_product_description_rowguid]
        DEFAULT (newid())
        FOR [rowguid];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product_description'
                                              , N'CONSTRAINT',N'df_product_description_rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of NEW_id()'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product_description'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_product_description_rowguid'
GO
