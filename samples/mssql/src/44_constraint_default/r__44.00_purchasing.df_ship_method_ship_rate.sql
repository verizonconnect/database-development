
IF OBJECT_ID('[purchasing].[df_ship_method_ship_rate]', 'D') IS NULL
    BEGIN
        ALTER TABLE [purchasing].[ship_method]
        ADD CONSTRAINT [df_ship_method_ship_rate]
        DEFAULT ((0.00))
        FOR [ship_rate];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'purchasing'
                                              , N'TABLE',N'ship_method'
                                              , N'CONSTRAINT',N'df_ship_method_ship_rate'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of 0.0'
                                  , @level0type=N'SCHEMA',@level0name=N'purchasing'
                                  , @level1type=N'TABLE',@level1name=N'ship_method'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_ship_method_ship_rate'
GO
