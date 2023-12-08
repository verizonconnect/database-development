
IF OBJECT_ID('[production].[fk_work_order_routing_work_order_work_order_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [production].[work_order_routing]  
    ADD CONSTRAINT [fk_work_order_routing_work_order_work_order_id] 
    FOREIGN KEY (work_order_id)
    REFERENCES [production].[work_order] (work_order_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [production].[work_order_routing] 
CHECK CONSTRAINT [fk_work_order_routing_work_order_work_order_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'work_order_routing'
                                              , N'CONSTRAINT',N'fk_work_order_routing_work_order_work_order_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing work_order.work_order_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'work_order_routing'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_work_order_routing_work_order_work_order_id'
GO
