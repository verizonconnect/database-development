
IF OBJECT_ID('[person].[df_person_email_promotion]', 'D') IS NULL
    BEGIN
        ALTER TABLE [person].[person]
        ADD CONSTRAINT [df_person_email_promotion]
        DEFAULT ((0))
        FOR [email_promotion];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'person'
                                              , N'CONSTRAINT',N'df_person_email_promotion'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of 0'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'person'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_person_email_promotion'
GO
