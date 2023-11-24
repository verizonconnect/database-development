
IF OBJECT_ID('[production].[ck_product_class]', 'C') IS NULL
    BEGIN
        ALTER TABLE [production].[product]
        WITH NOCHECK
        ADD CONSTRAINT [ck_product_class]
        CHECK (upper([class])='H' OR upper([class])='M' OR upper([class])='L' OR [class] IS NULL);
    END;
GO

ALTER TABLE [production].[product] 
CHECK CONSTRAINT [ck_product_class]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product'
                                              , N'CONSTRAINT',N'ck_product_class'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [class]=''h'' OR [class]=''m'' OR [class]=''l'' OR [class]=''H'' OR [class]=''M'' OR [class]=''L'' OR [class] IS NULL'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_product_class'
GO
