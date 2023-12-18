
IF OBJECT_ID('[production].[ck_bill_of_materials_per_assembly_qty]', 'C') IS NULL
    BEGIN
        ALTER TABLE [production].[bill_of_materials]
        WITH NOCHECK
        ADD CONSTRAINT [ck_bill_of_materials_per_assembly_qty]
        CHECK ([per_assembly_qty]>=(1.00));
    END;
GO

ALTER TABLE [production].[bill_of_materials] 
CHECK CONSTRAINT [ck_bill_of_materials_per_assembly_qty]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'bill_of_materials'
                                              , N'CONSTRAINT',N'ck_bill_of_materials_per_assembly_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [per_assembly_qty] >= (1.00)'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'bill_of_materials'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_bill_of_materials_per_assembly_qty'
GO
