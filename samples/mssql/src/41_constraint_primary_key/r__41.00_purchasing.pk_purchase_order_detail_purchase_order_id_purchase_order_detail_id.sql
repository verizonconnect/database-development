
IF OBJECT_ID('[purchasing].[pk_purchase_order_detail_purchase_order_id_purchase_order_detail_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [purchasing].[purchase_order_detail]
        ADD CONSTRAINT [pk_purchase_order_detail_purchase_order_id_purchase_order_detail_id]
        PRIMARY KEY CLUSTERED (purchase_order_id ASC, purchase_order_detail_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'purchasing'
                                              , N'TABLE',N'purchase_order_detail'
                                              , N'CONSTRAINT',N'pk_purchase_order_detail_purchase_order_id_purchase_order_detail_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'purchasing'
                                  , @level1type=N'TABLE',@level1name=N'purchase_order_detail'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_purchase_order_detail_purchase_order_id_purchase_order_detail_id'
GO
