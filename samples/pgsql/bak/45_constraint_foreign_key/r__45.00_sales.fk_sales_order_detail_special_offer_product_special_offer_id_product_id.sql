
IF OBJECT_ID('[sales].[fk_sales_order_detail_special_offer_product_special_offer_id_product_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [sales].[sales_order_detail]  
    ADD CONSTRAINT [fk_sales_order_detail_special_offer_product_special_offer_id_product_id] 
    FOREIGN KEY (special_offer_id, product_id)
    REFERENCES [sales].[special_offer_product] (special_offer_id, product_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [sales].[sales_order_detail] 
CHECK CONSTRAINT [fk_sales_order_detail_special_offer_product_special_offer_id_product_id];
GO

IF OBJECT_ID('[sales].[fk_sales_order_detail_special_offer_product_special_offer_id_product_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [sales].[sales_order_detail]  
    ADD CONSTRAINT [fk_sales_order_detail_special_offer_product_special_offer_id_product_id] 
    FOREIGN KEY (special_offer_id, product_id)
    REFERENCES [sales].[special_offer_product] (special_offer_id, product_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [sales].[sales_order_detail] 
CHECK CONSTRAINT [fk_sales_order_detail_special_offer_product_special_offer_id_product_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_order_detail'
                                              , N'CONSTRAINT',N'fk_sales_order_detail_special_offer_product_special_offer_id_product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing special_offer_product.special_offer_id_product_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_order_detail'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_sales_order_detail_special_offer_product_special_offer_id_product_id'
GO
