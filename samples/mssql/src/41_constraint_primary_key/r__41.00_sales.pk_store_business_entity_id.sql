
IF OBJECT_ID('[sales].[pk_store_business_entity_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [sales].[store]
        ADD CONSTRAINT [pk_store_business_entity_id]
        PRIMARY KEY CLUSTERED (business_entity_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'store'
                                              , N'CONSTRAINT',N'pk_store_business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'store'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_store_business_entity_id'
GO
