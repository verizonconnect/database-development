SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[production].[transaction_history_archive]') 
                      AND i.name = N'idx__production__transaction_history_archive_2_reference_order_id')
CREATE NONCLUSTERED INDEX [idx__production__transaction_history_archive_2_reference_order_id]
ON [production].[transaction_history_archive] (
 [reference_order_id] ASC, [reference_order_line_id] ASC
);
