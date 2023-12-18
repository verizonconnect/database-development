
IF OBJECT_ID('[production].[fk_transaction_history_product_product_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [production].[transaction_history]  
    ADD CONSTRAINT [fk_transaction_history_product_product_id] 
    FOREIGN KEY (product_id)
    REFERENCES [production].[product] (product_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [production].[transaction_history] 
CHECK CONSTRAINT [fk_transaction_history_product_product_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'transaction_history'
                                              , N'CONSTRAINT',N'fk_transaction_history_product_product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing product.product_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'transaction_history'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_transaction_history_product_product_id'
GO
