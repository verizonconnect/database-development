
IF OBJECT_ID('[person].[df_business_entity_rowguid]', 'D') IS NULL
    BEGIN
        ALTER TABLE [person].[business_entity]
        ADD CONSTRAINT [df_business_entity_rowguid]
        DEFAULT (newid())
        FOR [rowguid];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'business_entity'
                                              , N'CONSTRAINT',N'df_business_entity_rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of NEW_id()'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'business_entity'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_business_entity_rowguid'
GO
