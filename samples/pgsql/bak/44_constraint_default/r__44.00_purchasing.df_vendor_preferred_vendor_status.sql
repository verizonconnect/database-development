
IF OBJECT_ID('[purchasing].[df_vendor_preferred_vendor_status]', 'D') IS NULL
    BEGIN
        ALTER TABLE [purchasing].[vendor]
        ADD CONSTRAINT [df_vendor_preferred_vendor_status]
        DEFAULT ((1))
        FOR [preferred_vendor_status];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'purchasing'
                                              , N'TABLE',N'vendor'
                                              , N'CONSTRAINT',N'df_vendor_preferred_vendor_status'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of 1 (TRUE)'
                                  , @level0type=N'SCHEMA',@level0name=N'purchasing'
                                  , @level1type=N'TABLE',@level1name=N'vendor'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_vendor_preferred_vendor_status'
GO
