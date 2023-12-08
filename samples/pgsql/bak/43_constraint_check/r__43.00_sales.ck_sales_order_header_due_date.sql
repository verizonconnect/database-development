
IF OBJECT_ID('[sales].[ck_sales_order_header_due_date]', 'C') IS NULL
    BEGIN
        ALTER TABLE [sales].[sales_order_header]
        WITH NOCHECK
        ADD CONSTRAINT [ck_sales_order_header_due_date]
        CHECK ([due_date]>=[order_date]);
    END;
GO

ALTER TABLE [sales].[sales_order_header] 
CHECK CONSTRAINT [ck_sales_order_header_due_date]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_order_header'
                                              , N'CONSTRAINT',N'ck_sales_order_header_due_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [due_date] >= [order_date]'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_order_header'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_sales_order_header_due_date'
GO
