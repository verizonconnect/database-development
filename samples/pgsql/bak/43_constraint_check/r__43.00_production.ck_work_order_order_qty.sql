
IF OBJECT_ID('[production].[ck_work_order_order_qty]', 'C') IS NULL
    BEGIN
        ALTER TABLE [production].[work_order]
        WITH NOCHECK
        ADD CONSTRAINT [ck_work_order_order_qty]
        CHECK ([order_qty]>(0));
    END;
GO

ALTER TABLE [production].[work_order] 
CHECK CONSTRAINT [ck_work_order_order_qty]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'work_order'
                                              , N'CONSTRAINT',N'ck_work_order_order_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [order_qty] > (0)'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'work_order'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_work_order_order_qty'
GO
