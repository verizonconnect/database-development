
IF OBJECT_ID('[sales].[ck_sales_person_commission_pct]', 'C') IS NULL
    BEGIN
        ALTER TABLE [sales].[sales_person]
        WITH NOCHECK
        ADD CONSTRAINT [ck_sales_person_commission_pct]
        CHECK ([commission_pct]>=(0.00));
    END;
GO

ALTER TABLE [sales].[sales_person] 
CHECK CONSTRAINT [ck_sales_person_commission_pct]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_person'
                                              , N'CONSTRAINT',N'ck_sales_person_commission_pct'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [commission_pct] >= (0.00)'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_person'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_sales_person_commission_pct'
GO
