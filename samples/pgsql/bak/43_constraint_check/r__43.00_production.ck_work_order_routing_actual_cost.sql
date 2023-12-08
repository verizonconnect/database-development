
IF OBJECT_ID('[production].[ck_work_order_routing_actual_cost]', 'C') IS NULL
    BEGIN
        ALTER TABLE [production].[work_order_routing]
        WITH NOCHECK
        ADD CONSTRAINT [ck_work_order_routing_actual_cost]
        CHECK ([actual_cost]>(0.00));
    END;
GO

ALTER TABLE [production].[work_order_routing] 
CHECK CONSTRAINT [ck_work_order_routing_actual_cost]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'work_order_routing'
                                              , N'CONSTRAINT',N'ck_work_order_routing_actual_cost'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [actual_cost] > (0.00)'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'work_order_routing'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_work_order_routing_actual_cost'
GO
