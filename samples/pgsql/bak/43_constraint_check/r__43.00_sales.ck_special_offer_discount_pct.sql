
IF OBJECT_ID('[sales].[ck_special_offer_discount_pct]', 'C') IS NULL
    BEGIN
        ALTER TABLE [sales].[special_offer]
        WITH NOCHECK
        ADD CONSTRAINT [ck_special_offer_discount_pct]
        CHECK ([discount_pct]>=(0.00));
    END;
GO

ALTER TABLE [sales].[special_offer] 
CHECK CONSTRAINT [ck_special_offer_discount_pct]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'special_offer'
                                              , N'CONSTRAINT',N'ck_special_offer_discount_pct'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [discount_pct] >= (0.00)'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'special_offer'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_special_offer_discount_pct'
GO
