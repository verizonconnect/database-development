
IF OBJECT_ID('[production].[df_location_cost_rate]', 'D') IS NULL
    BEGIN
        ALTER TABLE [production].[location]
        ADD CONSTRAINT [df_location_cost_rate]
        DEFAULT ((0.00))
        FOR [cost_rate];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'location'
                                              , N'CONSTRAINT',N'df_location_cost_rate'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of 0.0'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'location'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_location_cost_rate'
GO
