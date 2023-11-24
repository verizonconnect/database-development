
IF OBJECT_ID('[person].[df_person_phone_modified_date]', 'D') IS NULL
    BEGIN
        ALTER TABLE [person].[person_phone]
        ADD CONSTRAINT [df_person_phone_modified_date]
        DEFAULT (getdate())
        FOR [modified_date];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'person_phone'
                                              , N'CONSTRAINT',N'df_person_phone_modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of GETDATE()'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'person_phone'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_person_phone_modified_date'
GO
