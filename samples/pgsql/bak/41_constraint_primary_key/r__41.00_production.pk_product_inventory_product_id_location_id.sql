
IF OBJECT_ID('[production].[pk_product_inventory_product_id_location_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [production].[product_inventory]
        ADD CONSTRAINT [pk_product_inventory_product_id_location_id]
        PRIMARY KEY CLUSTERED (product_id ASC, location_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product_inventory'
                                              , N'CONSTRAINT',N'pk_product_inventory_product_id_location_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product_inventory'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_product_inventory_product_id_location_id'
GO
