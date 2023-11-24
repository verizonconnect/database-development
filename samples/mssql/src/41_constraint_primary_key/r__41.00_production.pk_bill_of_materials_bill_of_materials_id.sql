
IF OBJECT_ID('[production].[pk_bill_of_materials_bill_of_materials_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [production].[bill_of_materials]
        ADD CONSTRAINT [pk_bill_of_materials_bill_of_materials_id]
        PRIMARY KEY NONCLUSTERED (bill_of_materials_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'bill_of_materials'
                                              , N'CONSTRAINT',N'pk_bill_of_materials_bill_of_materials_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'bill_of_materials'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_bill_of_materials_bill_of_materials_id'
GO
