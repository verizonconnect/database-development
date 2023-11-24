
IF OBJECT_ID('[sales].[ck_sales_territory_cost_ytd]', 'C') IS NULL
    BEGIN
        ALTER TABLE [sales].[sales_territory]
        WITH NOCHECK
        ADD CONSTRAINT [ck_sales_territory_cost_ytd]
        CHECK ([cost_ytd]>=(0.00));
    END;
GO

ALTER TABLE [sales].[sales_territory] 
CHECK CONSTRAINT [ck_sales_territory_cost_ytd]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_territory'
                                              , N'CONSTRAINT',N'ck_sales_territory_cost_ytd'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [cost_ytd] >= (0.00)'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_territory'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_sales_territory_cost_ytd'
GO
