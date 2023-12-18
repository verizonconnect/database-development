
IF OBJECT_ID('[production].[ck_location_cost_rate]', 'C') IS NULL
    BEGIN
        ALTER TABLE [production].[location]
        WITH NOCHECK
        ADD CONSTRAINT [ck_location_cost_rate]
        CHECK ([cost_rate]>=(0.00));
    END;
GO

ALTER TABLE [production].[location] 
CHECK CONSTRAINT [ck_location_cost_rate]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'location'
                                              , N'CONSTRAINT',N'ck_location_cost_rate'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [cost_rate] >= (0.00)'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'location'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_location_cost_rate'
GO
