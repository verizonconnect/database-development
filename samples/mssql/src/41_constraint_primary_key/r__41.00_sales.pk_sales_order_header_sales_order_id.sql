
IF OBJECT_ID('[sales].[pk_sales_order_header_sales_order_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [sales].[sales_order_header]
        ADD CONSTRAINT [pk_sales_order_header_sales_order_id]
        PRIMARY KEY CLUSTERED (sales_order_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_order_header'
                                              , N'CONSTRAINT',N'pk_sales_order_header_sales_order_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_order_header'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_sales_order_header_sales_order_id'
GO
