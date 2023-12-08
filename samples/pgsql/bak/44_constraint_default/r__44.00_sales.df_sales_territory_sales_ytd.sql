
IF OBJECT_ID('[sales].[df_sales_territory_sales_ytd]', 'D') IS NULL
    BEGIN
        ALTER TABLE [sales].[sales_territory]
        ADD CONSTRAINT [df_sales_territory_sales_ytd]
        DEFAULT ((0.00))
        FOR [sales_ytd];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_territory'
                                              , N'CONSTRAINT',N'df_sales_territory_sales_ytd'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of 0.0'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_territory'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_sales_territory_sales_ytd'
GO
