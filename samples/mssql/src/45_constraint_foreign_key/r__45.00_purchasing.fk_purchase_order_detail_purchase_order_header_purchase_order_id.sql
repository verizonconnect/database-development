
IF OBJECT_ID('[purchasing].[fk_purchase_order_detail_purchase_order_header_purchase_order_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [purchasing].[purchase_order_detail]  
    ADD CONSTRAINT [fk_purchase_order_detail_purchase_order_header_purchase_order_id] 
    FOREIGN KEY (purchase_order_id)
    REFERENCES [purchasing].[purchase_order_header] (purchase_order_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [purchasing].[purchase_order_detail] 
CHECK CONSTRAINT [fk_purchase_order_detail_purchase_order_header_purchase_order_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'purchasing'
                                              , N'TABLE',N'purchase_order_detail'
                                              , N'CONSTRAINT',N'fk_purchase_order_detail_purchase_order_header_purchase_order_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing purchase_order_header.purchase_order_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'purchasing'
                                  , @level1type=N'TABLE',@level1name=N'purchase_order_detail'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_purchase_order_detail_purchase_order_header_purchase_order_id'
GO
