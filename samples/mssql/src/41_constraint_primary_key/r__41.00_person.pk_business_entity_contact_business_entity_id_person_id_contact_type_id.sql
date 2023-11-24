
IF OBJECT_ID('[person].[pk_business_entity_contact_business_entity_id_person_id_contact_type_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [person].[business_entity_contact]
        ADD CONSTRAINT [pk_business_entity_contact_business_entity_id_person_id_contact_type_id]
        PRIMARY KEY CLUSTERED (business_entity_id ASC, person_id ASC, contact_type_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'business_entity_contact'
                                              , N'CONSTRAINT',N'pk_business_entity_contact_business_entity_id_person_id_contact_type_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'business_entity_contact'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_business_entity_contact_business_entity_id_person_id_contact_type_id'
GO
