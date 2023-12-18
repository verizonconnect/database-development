
IF OBJECT_ID('[person].[df_business_entity_contact_modified_date]', 'D') IS NULL
    BEGIN
        ALTER TABLE [person].[business_entity_contact]
        ADD CONSTRAINT [df_business_entity_contact_modified_date]
        DEFAULT (getdate())
        FOR [modified_date];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'business_entity_contact'
                                              , N'CONSTRAINT',N'df_business_entity_contact_modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of GETDATE()'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'business_entity_contact'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_business_entity_contact_modified_date'
GO
