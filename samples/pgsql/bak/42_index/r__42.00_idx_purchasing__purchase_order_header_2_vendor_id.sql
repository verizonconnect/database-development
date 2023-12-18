SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[purchasing].[purchase_order_header]') 
                      AND i.name = N'idx__purchasing__purchase_order_header_2_vendor_id')
CREATE NONCLUSTERED INDEX [idx__purchasing__purchase_order_header_2_vendor_id]
ON [purchasing].[purchase_order_header] (
 [vendor_id] ASC
);
