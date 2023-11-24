
IF OBJECT_ID('[production].[pk_work_order_routing_work_order_id_product_id_operation_sequence]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [production].[work_order_routing]
        ADD CONSTRAINT [pk_work_order_routing_work_order_id_product_id_operation_sequence]
        PRIMARY KEY CLUSTERED (work_order_id ASC, product_id ASC, operation_sequence ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'work_order_routing'
                                              , N'CONSTRAINT',N'pk_work_order_routing_work_order_id_product_id_operation_sequence'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'work_order_routing'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_work_order_routing_work_order_id_product_id_operation_sequence'
GO
