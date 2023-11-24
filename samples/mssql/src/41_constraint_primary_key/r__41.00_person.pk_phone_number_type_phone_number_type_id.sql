
IF OBJECT_ID('[person].[pk_phone_number_type_phone_number_type_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [person].[phone_number_type]
        ADD CONSTRAINT [pk_phone_number_type_phone_number_type_id]
        PRIMARY KEY CLUSTERED (phone_number_type_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'phone_number_type'
                                              , N'CONSTRAINT',N'pk_phone_number_type_phone_number_type_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'phone_number_type'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_phone_number_type_phone_number_type_id'
GO
