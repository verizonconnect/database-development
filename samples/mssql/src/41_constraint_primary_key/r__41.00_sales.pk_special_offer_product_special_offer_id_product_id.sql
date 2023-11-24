
IF OBJECT_ID('[sales].[pk_special_offer_product_special_offer_id_product_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [sales].[special_offer_product]
        ADD CONSTRAINT [pk_special_offer_product_special_offer_id_product_id]
        PRIMARY KEY CLUSTERED (special_offer_id ASC, product_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'special_offer_product'
                                              , N'CONSTRAINT',N'pk_special_offer_product_special_offer_id_product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'special_offer_product'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_special_offer_product_special_offer_id_product_id'
GO
