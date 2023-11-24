
IF OBJECT_ID('[person].[df_contact_type_modified_date]', 'D') IS NULL
    BEGIN
        ALTER TABLE [person].[contact_type]
        ADD CONSTRAINT [df_contact_type_modified_date]
        DEFAULT (getdate())
        FOR [modified_date];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'contact_type'
                                              , N'CONSTRAINT',N'df_contact_type_modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of GETDATE()'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'contact_type'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_contact_type_modified_date'
GO
