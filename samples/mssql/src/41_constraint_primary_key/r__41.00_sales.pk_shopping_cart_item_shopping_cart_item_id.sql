
IF OBJECT_ID('[sales].[pk_shopping_cart_item_shopping_cart_item_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [sales].[shopping_cart_item]
        ADD CONSTRAINT [pk_shopping_cart_item_shopping_cart_item_id]
        PRIMARY KEY CLUSTERED (shopping_cart_item_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'shopping_cart_item'
                                              , N'CONSTRAINT',N'pk_shopping_cart_item_shopping_cart_item_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'shopping_cart_item'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_shopping_cart_item_shopping_cart_item_id'
GO
