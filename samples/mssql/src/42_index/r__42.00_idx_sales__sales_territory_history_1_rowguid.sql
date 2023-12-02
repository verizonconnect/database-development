SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[sales].[sales_territory_history]') 
                      AND i.name = N'idx__sales__sales_territory_history_1_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [idx__sales__sales_territory_history_1_rowguid]
ON [sales].[sales_territory_history] (
 [rowguid] ASC
);
