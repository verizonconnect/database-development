
IF OBJECT_ID('[person].[df_state_province_is_only_state_province_flag]', 'D') IS NULL
    BEGIN
        ALTER TABLE [person].[state_province]
        ADD CONSTRAINT [df_state_province_is_only_state_province_flag]
        DEFAULT ((1))
        FOR [is_only_state_province_flag];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'state_province'
                                              , N'CONSTRAINT',N'df_state_province_is_only_state_province_flag'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of 1 (TRUE)'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'state_province'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_state_province_is_only_state_province_flag'
GO
