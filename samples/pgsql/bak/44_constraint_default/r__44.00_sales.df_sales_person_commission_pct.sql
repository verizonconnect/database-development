
IF OBJECT_ID('[sales].[df_sales_person_commission_pct]', 'D') IS NULL
    BEGIN
        ALTER TABLE [sales].[sales_person]
        ADD CONSTRAINT [df_sales_person_commission_pct]
        DEFAULT ((0.00))
        FOR [commission_pct];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_person'
                                              , N'CONSTRAINT',N'df_sales_person_commission_pct'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of 0.0'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_person'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_sales_person_commission_pct'
GO
