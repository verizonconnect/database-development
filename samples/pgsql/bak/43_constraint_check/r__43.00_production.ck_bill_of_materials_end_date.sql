
IF OBJECT_ID('[production].[ck_bill_of_materials_end_date]', 'C') IS NULL
    BEGIN
        ALTER TABLE [production].[bill_of_materials]
        WITH NOCHECK
        ADD CONSTRAINT [ck_bill_of_materials_end_date]
        CHECK ([end_date]>[start_date] OR [end_date] IS NULL);
    END;
GO

ALTER TABLE [production].[bill_of_materials] 
CHECK CONSTRAINT [ck_bill_of_materials_end_date]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'bill_of_materials'
                                              , N'CONSTRAINT',N'ck_bill_of_materials_end_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint end_date] > [start_date] OR [end_date] IS NULL'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'bill_of_materials'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_bill_of_materials_end_date'
GO
