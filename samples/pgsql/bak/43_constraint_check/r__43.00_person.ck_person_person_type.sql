
IF OBJECT_ID('[person].[ck_person_person_type]', 'C') IS NULL
    BEGIN
        ALTER TABLE [person].[person]
        WITH NOCHECK
        ADD CONSTRAINT [ck_person_person_type]
        CHECK ([person_type] IS NULL OR (upper([person_type])='GC' OR upper([person_type])='SP' OR upper([person_type])='EM' OR upper([person_type])='IN' OR upper([person_type])='VC' OR upper([person_type])='SC'));
    END;
GO

ALTER TABLE [person].[person] 
CHECK CONSTRAINT [ck_person_person_type]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'person'
                                              , N'CONSTRAINT',N'ck_person_person_type'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [person_type] is one of SC, VC, IN, EM or SP.'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'person'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_person_person_type'
GO
