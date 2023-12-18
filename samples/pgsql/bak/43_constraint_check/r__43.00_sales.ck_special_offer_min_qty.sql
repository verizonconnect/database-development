
IF OBJECT_ID('[sales].[ck_special_offer_min_qty]', 'C') IS NULL
    BEGIN
        ALTER TABLE [sales].[special_offer]
        WITH NOCHECK
        ADD CONSTRAINT [ck_special_offer_min_qty]
        CHECK ([min_qty]>=(0));
    END;
GO

ALTER TABLE [sales].[special_offer] 
CHECK CONSTRAINT [ck_special_offer_min_qty]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'special_offer'
                                              , N'CONSTRAINT',N'ck_special_offer_min_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [min_qty] >= (0)'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'special_offer'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_special_offer_min_qty'
GO
