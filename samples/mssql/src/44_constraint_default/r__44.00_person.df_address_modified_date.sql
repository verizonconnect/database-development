
IF OBJECT_ID('[person].[df_address_modified_date]', 'D') IS NULL
    BEGIN
        ALTER TABLE [person].[address]
        ADD CONSTRAINT [df_address_modified_date]
        DEFAULT (getdate())
        FOR [modified_date];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'address'
                                              , N'CONSTRAINT',N'df_address_modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of GETDATE()'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'address'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_address_modified_date'
GO
