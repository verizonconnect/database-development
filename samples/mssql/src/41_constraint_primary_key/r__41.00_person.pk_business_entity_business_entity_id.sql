
IF OBJECT_ID('[person].[pk_business_entity_business_entity_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [person].[business_entity]
        ADD CONSTRAINT [pk_business_entity_business_entity_id]
        PRIMARY KEY CLUSTERED (business_entity_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'business_entity'
                                              , N'CONSTRAINT',N'pk_business_entity_business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'business_entity'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_business_entity_business_entity_id'
GO
