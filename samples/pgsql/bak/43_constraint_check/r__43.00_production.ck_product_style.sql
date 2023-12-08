
IF OBJECT_ID('[production].[ck_product_style]', 'C') IS NULL
    BEGIN
        ALTER TABLE [production].[product]
        WITH NOCHECK
        ADD CONSTRAINT [ck_product_style]
        CHECK (upper([style])='U' OR upper([style])='M' OR upper([style])='W' OR [style] IS NULL);
    END;
GO

ALTER TABLE [production].[product] 
CHECK CONSTRAINT [ck_product_style]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product'
                                              , N'CONSTRAINT',N'ck_product_style'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [style]=''u'' OR [style]=''m'' OR [style]=''w'' OR [style]=''U'' OR [style]=''M'' OR [style]=''W'' OR [style] IS NULL'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_product_style'
GO
