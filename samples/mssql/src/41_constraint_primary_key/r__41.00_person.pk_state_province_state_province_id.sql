
IF OBJECT_ID('[person].[pk_state_province_state_province_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [person].[state_province]
        ADD CONSTRAINT [pk_state_province_state_province_id]
        PRIMARY KEY CLUSTERED (state_province_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'state_province'
                                              , N'CONSTRAINT',N'pk_state_province_state_province_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'state_province'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_state_province_state_province_id'
GO
