
IF OBJECT_ID('[purchasing].[fk_purchase_order_header_vendor_vendor_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [purchasing].[purchase_order_header]  
    ADD CONSTRAINT [fk_purchase_order_header_vendor_vendor_id] 
    FOREIGN KEY (vendor_id)
    REFERENCES [purchasing].[vendor] (business_entity_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [purchasing].[purchase_order_header] 
CHECK CONSTRAINT [fk_purchase_order_header_vendor_vendor_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'purchasing'
                                              , N'TABLE',N'purchase_order_header'
                                              , N'CONSTRAINT',N'fk_purchase_order_header_vendor_vendor_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing vendor.vendor_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'purchasing'
                                  , @level1type=N'TABLE',@level1name=N'purchase_order_header'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_purchase_order_header_vendor_vendor_id'
GO
