
IF OBJECT_ID('[purchasing].[pk_product_vendor_product_id_business_entity_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [purchasing].[product_vendor]
        ADD CONSTRAINT [pk_product_vendor_product_id_business_entity_id]
        PRIMARY KEY CLUSTERED (product_id ASC, business_entity_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'purchasing'
                                              , N'TABLE',N'product_vendor'
                                              , N'CONSTRAINT',N'pk_product_vendor_product_id_business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'purchasing'
                                  , @level1type=N'TABLE',@level1name=N'product_vendor'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_product_vendor_product_id_business_entity_id'
GO
