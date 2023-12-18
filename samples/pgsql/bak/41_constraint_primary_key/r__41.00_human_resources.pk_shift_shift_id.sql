
IF OBJECT_ID('[human_resources].[pk_shift_shift_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [human_resources].[shift]
        ADD CONSTRAINT [pk_shift_shift_id]
        PRIMARY KEY CLUSTERED (shift_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'human_resources'
                                              , N'TABLE',N'shift'
                                              , N'CONSTRAINT',N'pk_shift_shift_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'human_resources'
                                  , @level1type=N'TABLE',@level1name=N'shift'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_shift_shift_id'
GO
