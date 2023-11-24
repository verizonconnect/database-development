
IF OBJECT_ID('[production].[df_product_finished_goods_flag]', 'D') IS NULL
    BEGIN
        ALTER TABLE [production].[product]
        ADD CONSTRAINT [df_product_finished_goods_flag]
        DEFAULT ((1))
        FOR [finished_goods_flag];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product'
                                              , N'CONSTRAINT',N'df_product_finished_goods_flag'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of  1'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_product_finished_goods_flag'
GO
