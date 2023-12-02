SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[sales].[sales_order_detail]') 
                      AND i.name = N'idx__sales__sales_order_detail_1_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [idx__sales__sales_order_detail_1_rowguid]
ON [sales].[sales_order_detail] (
 [rowguid] ASC
);
