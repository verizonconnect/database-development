﻿
IF OBJECT_ID('[production].[pk_product_list_price_history_product_id_start_date]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [production].[product_list_price_history]
        ADD CONSTRAINT [pk_product_list_price_history_product_id_start_date]
        PRIMARY KEY CLUSTERED (product_id ASC, start_date ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product_list_price_history'
                                              , N'CONSTRAINT',N'pk_product_list_price_history_product_id_start_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product_list_price_history'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_product_list_price_history_product_id_start_date'
GO
