
IF OBJECT_ID('[production].[df_location_Availability]', 'D') IS NULL
    BEGIN
        ALTER TABLE [production].[location]
        ADD CONSTRAINT [df_location_Availability]
        DEFAULT ((0.00))
        FOR [availability];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'location'
                                              , N'CONSTRAINT',N'df_location_Availability'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of 0.00'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'location'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_location_Availability'
GO
