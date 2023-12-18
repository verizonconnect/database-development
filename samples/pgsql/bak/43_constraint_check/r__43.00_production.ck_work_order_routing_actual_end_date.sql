
IF OBJECT_ID('[production].[ck_work_order_routing_actual_end_date]', 'C') IS NULL
    BEGIN
        ALTER TABLE [production].[work_order_routing]
        WITH NOCHECK
        ADD CONSTRAINT [ck_work_order_routing_actual_end_date]
        CHECK ([actual_end_date]>=[actual_start_date] OR [actual_end_date] IS NULL OR [actual_start_date] IS NULL);
    END;
GO

ALTER TABLE [production].[work_order_routing] 
CHECK CONSTRAINT [ck_work_order_routing_actual_end_date]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'work_order_routing'
                                              , N'CONSTRAINT',N'ck_work_order_routing_actual_end_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [actual_end_date] >= [actual_start_date] OR [actual_end_date] IS NULL OR [actual_start_date] IS NULL'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'work_order_routing'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_work_order_routing_actual_end_date'
GO
