
IF OBJECT_ID('[sales].[fk_sales_order_header_sales_reason_sales_reason_sales_reason_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [sales].[sales_order_header_sales_reason]  
    ADD CONSTRAINT [fk_sales_order_header_sales_reason_sales_reason_sales_reason_id] 
    FOREIGN KEY (sales_reason_id)
    REFERENCES [sales].[sales_reason] (sales_reason_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [sales].[sales_order_header_sales_reason] 
CHECK CONSTRAINT [fk_sales_order_header_sales_reason_sales_reason_sales_reason_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_order_header_sales_reason'
                                              , N'CONSTRAINT',N'fk_sales_order_header_sales_reason_sales_reason_sales_reason_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing sales_reason.sales_reason_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_order_header_sales_reason'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_sales_order_header_sales_reason_sales_reason_sales_reason_id'
GO
