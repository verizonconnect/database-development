
IF OBJECT_ID('[production].[df_product_product_photo_Primary]', 'D') IS NULL
    BEGIN
        ALTER TABLE [production].[product_product_photo]
        ADD CONSTRAINT [df_product_product_photo_Primary]
        DEFAULT ((0))
        FOR [primary];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product_product_photo'
                                              , N'CONSTRAINT',N'df_product_product_photo_Primary'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of 0 (FALSE)'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product_product_photo'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_product_product_photo_Primary'
GO
