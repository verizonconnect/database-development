﻿
IF OBJECT_ID('[sales].[fk_sales_order_header_ship_method_ship_method_id]', 'F') IS NULL
BEGIN
    ALTER TABLE [sales].[sales_order_header]  
    ADD CONSTRAINT [fk_sales_order_header_ship_method_ship_method_id] 
    FOREIGN KEY (ship_method_id)
    REFERENCES [purchasing].[ship_method] (ship_method_id)
    ON DELETE NO ACTION;
END;
GO

ALTER TABLE [sales].[sales_order_header] 
CHECK CONSTRAINT [fk_sales_order_header_ship_method_ship_method_id];
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_order_header'
                                              , N'CONSTRAINT',N'fk_sales_order_header_ship_method_ship_method_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Foreign key constraint referencing ship_method.ship_method_id.'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_order_header'
                                  , @level2type=N'CONSTRAINT',@level2name=N'fk_sales_order_header_ship_method_ship_method_id'
GO
