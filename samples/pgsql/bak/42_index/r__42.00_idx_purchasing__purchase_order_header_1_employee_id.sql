SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[purchasing].[purchase_order_header]') 
                      AND i.name = N'idx__purchasing__purchase_order_header_1_employee_id')
CREATE NONCLUSTERED INDEX [idx__purchasing__purchase_order_header_1_employee_id]
ON [purchasing].[purchase_order_header] (
 [employee_id] ASC
);
