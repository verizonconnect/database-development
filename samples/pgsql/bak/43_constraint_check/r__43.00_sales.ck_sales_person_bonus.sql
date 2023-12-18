
IF OBJECT_ID('[sales].[ck_sales_person_bonus]', 'C') IS NULL
    BEGIN
        ALTER TABLE [sales].[sales_person]
        WITH NOCHECK
        ADD CONSTRAINT [ck_sales_person_bonus]
        CHECK ([bonus]>=(0.00));
    END;
GO

ALTER TABLE [sales].[sales_person] 
CHECK CONSTRAINT [ck_sales_person_bonus]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_person'
                                              , N'CONSTRAINT',N'ck_sales_person_bonus'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [bonus] >= (0.00)'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_person'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_sales_person_bonus'
GO
