
IF OBJECT_ID('[person].[pk_contact_type_contact_type_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [person].[contact_type]
        ADD CONSTRAINT [pk_contact_type_contact_type_id]
        PRIMARY KEY CLUSTERED (contact_type_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'contact_type'
                                              , N'CONSTRAINT',N'pk_contact_type_contact_type_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'contact_type'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_contact_type_contact_type_id'
GO
