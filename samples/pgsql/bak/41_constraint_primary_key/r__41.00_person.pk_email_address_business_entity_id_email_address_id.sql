
IF OBJECT_ID('[person].[pk_email_address_business_entity_id_email_address_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [person].[email_address]
        ADD CONSTRAINT [pk_email_address_business_entity_id_email_address_id]
        PRIMARY KEY CLUSTERED (business_entity_id ASC, email_address_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'email_address'
                                              , N'CONSTRAINT',N'pk_email_address_business_entity_id_email_address_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'email_address'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_email_address_business_entity_id_email_address_id'
GO
