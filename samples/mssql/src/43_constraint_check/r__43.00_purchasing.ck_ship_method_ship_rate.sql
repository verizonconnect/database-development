
IF OBJECT_ID('[purchasing].[ck_ship_method_ship_rate]', 'C') IS NULL
    BEGIN
        ALTER TABLE [purchasing].[ship_method]
        WITH NOCHECK
        ADD CONSTRAINT [ck_ship_method_ship_rate]
        CHECK ([ship_rate]>(0.00));
    END;
GO

ALTER TABLE [purchasing].[ship_method] 
CHECK CONSTRAINT [ck_ship_method_ship_rate]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'purchasing'
                                              , N'TABLE',N'ship_method'
                                              , N'CONSTRAINT',N'ck_ship_method_ship_rate'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [ship_rate] > (0.00)'
                                  , @level0type=N'SCHEMA',@level0name=N'purchasing'
                                  , @level1type=N'TABLE',@level1name=N'ship_method'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_ship_method_ship_rate'
GO
