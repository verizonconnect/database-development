
IF OBJECT_ID('[sales].[df_sales_order_detail_modified_date]', 'D') IS NULL
    BEGIN
        ALTER TABLE [sales].[sales_order_detail]
        ADD CONSTRAINT [df_sales_order_detail_modified_date]
        DEFAULT (getdate())
        FOR [modified_date];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_order_detail'
                                              , N'CONSTRAINT',N'df_sales_order_detail_modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of GETDATE()'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_order_detail'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_sales_order_detail_modified_date'
GO
