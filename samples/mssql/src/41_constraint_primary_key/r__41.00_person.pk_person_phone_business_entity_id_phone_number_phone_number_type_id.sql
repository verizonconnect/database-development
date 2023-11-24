
IF OBJECT_ID('[person].[pk_person_phone_business_entity_id_phone_number_phone_number_type_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [person].[person_phone]
        ADD CONSTRAINT [pk_person_phone_business_entity_id_phone_number_phone_number_type_id]
        PRIMARY KEY CLUSTERED (business_entity_id ASC, phone_number ASC, phone_number_type_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'person_phone'
                                              , N'CONSTRAINT',N'pk_person_phone_business_entity_id_phone_number_phone_number_type_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'person_phone'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_person_phone_business_entity_id_phone_number_phone_number_type_id'
GO
