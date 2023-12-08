
IF OBJECT_ID('[sales].[df_special_offer_min_qty]', 'D') IS NULL
    BEGIN
        ALTER TABLE [sales].[special_offer]
        ADD CONSTRAINT [df_special_offer_min_qty]
        DEFAULT ((0))
        FOR [min_qty];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'special_offer'
                                              , N'CONSTRAINT',N'df_special_offer_min_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of 0.0'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'special_offer'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_special_offer_min_qty'
GO
