
IF OBJECT_ID('[sales].[df_special_offer_product_modified_date]', 'D') IS NULL
    BEGIN
        ALTER TABLE [sales].[special_offer_product]
        ADD CONSTRAINT [df_special_offer_product_modified_date]
        DEFAULT (getdate())
        FOR [modified_date];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'special_offer_product'
                                              , N'CONSTRAINT',N'df_special_offer_product_modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of GETDATE()'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'special_offer_product'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_special_offer_product_modified_date'
GO
