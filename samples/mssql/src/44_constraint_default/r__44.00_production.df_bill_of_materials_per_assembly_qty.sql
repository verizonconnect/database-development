
IF OBJECT_ID('[production].[df_bill_of_materials_per_assembly_qty]', 'D') IS NULL
    BEGIN
        ALTER TABLE [production].[bill_of_materials]
        ADD CONSTRAINT [df_bill_of_materials_per_assembly_qty]
        DEFAULT ((1.00))
        FOR [per_assembly_qty];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'bill_of_materials'
                                              , N'CONSTRAINT',N'df_bill_of_materials_per_assembly_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of 1.0'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'bill_of_materials'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_bill_of_materials_per_assembly_qty'
GO
