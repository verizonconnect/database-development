SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[sales].[sales_order_header]') 
                      AND i.name = N'idx__sales__sales_order_header_2_sales_order_number')
CREATE UNIQUE NONCLUSTERED INDEX [idx__sales__sales_order_header_2_sales_order_number]
ON [sales].[sales_order_header] (
 [sales_order_number] ASC
);
