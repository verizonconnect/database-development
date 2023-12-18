
IF OBJECT_ID('[production].[ck_product_product_line]', 'C') IS NULL
    BEGIN
        ALTER TABLE [production].[product]
        WITH NOCHECK
        ADD CONSTRAINT [ck_product_product_line]
        CHECK (upper([product_line])='R' OR upper([product_line])='M' OR upper([product_line])='T' OR upper([product_line])='S' OR [product_line] IS NULL);
    END;
GO

ALTER TABLE [production].[product] 
CHECK CONSTRAINT [ck_product_product_line]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product'
                                              , N'CONSTRAINT',N'ck_product_product_line'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [product_line]=''r'' OR [product_line]=''m'' OR [product_line]=''t'' OR [product_line]=''s'' OR [product_line]=''R'' OR [product_line]=''M'' OR [product_line]=''T'' OR [product_line]=''S'' OR [product_line] IS NULL'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_product_product_line'
GO
