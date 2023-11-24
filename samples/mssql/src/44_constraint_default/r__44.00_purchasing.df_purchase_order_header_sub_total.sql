
IF OBJECT_ID('[purchasing].[df_purchase_order_header_sub_total]', 'D') IS NULL
    BEGIN
        ALTER TABLE [purchasing].[purchase_order_header]
        ADD CONSTRAINT [df_purchase_order_header_sub_total]
        DEFAULT ((0.00))
        FOR [sub_total];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'purchasing'
                                              , N'TABLE',N'purchase_order_header'
                                              , N'CONSTRAINT',N'df_purchase_order_header_sub_total'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of 0.0'
                                  , @level0type=N'SCHEMA',@level0name=N'purchasing'
                                  , @level1type=N'TABLE',@level1name=N'purchase_order_header'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_purchase_order_header_sub_total'
GO
