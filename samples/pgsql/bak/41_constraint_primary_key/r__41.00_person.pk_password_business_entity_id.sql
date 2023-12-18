
IF OBJECT_ID('[person].[pk_password_business_entity_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [person].[password]
        ADD CONSTRAINT [pk_password_business_entity_id]
        PRIMARY KEY CLUSTERED (business_entity_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'password'
                                              , N'CONSTRAINT',N'pk_password_business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'password'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_password_business_entity_id'
GO
