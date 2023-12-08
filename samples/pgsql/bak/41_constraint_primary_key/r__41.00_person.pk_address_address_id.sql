
IF OBJECT_ID('[person].[pk_address_address_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [person].[address]
        ADD CONSTRAINT [pk_address_address_id]
        PRIMARY KEY CLUSTERED (address_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'address'
                                              , N'CONSTRAINT',N'pk_address_address_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'address'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_address_address_id'
GO
