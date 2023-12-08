SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[production].[work_order]') 
                      AND i.name = N'idx__production__work_order_2_scrap_reason_id')
CREATE NONCLUSTERED INDEX [idx__production__work_order_2_scrap_reason_id]
ON [production].[work_order] (
 [scrap_reason_id] ASC
);
