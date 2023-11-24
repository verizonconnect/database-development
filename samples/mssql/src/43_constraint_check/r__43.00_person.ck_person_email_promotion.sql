
IF OBJECT_ID('[person].[ck_person_email_promotion]', 'C') IS NULL
    BEGIN
        ALTER TABLE [person].[person]
        WITH NOCHECK
        ADD CONSTRAINT [ck_person_email_promotion]
        CHECK ([email_promotion]>=(0) AND [email_promotion]<=(2));
    END;
GO

ALTER TABLE [person].[person] 
CHECK CONSTRAINT [ck_person_email_promotion]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'person'
                                              , N'CONSTRAINT',N'ck_person_email_promotion'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [email_promotion] >= (0) AND [email_promotion] <= (2)'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'person'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_person_email_promotion'
GO
