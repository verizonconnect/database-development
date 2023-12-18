
IF OBJECT_ID('[production].[df_product_make_flag]', 'D') IS NULL
    BEGIN
        ALTER TABLE [production].[product]
        ADD CONSTRAINT [df_product_make_flag]
        DEFAULT ((1))
        FOR [make_flag];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product'
                                              , N'CONSTRAINT',N'df_product_make_flag'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of  1'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_product_make_flag'
GO
