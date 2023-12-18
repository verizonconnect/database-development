SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[sales].[sales_territory]') 
                      AND i.name = N'idx__sales__sales_territory_1_name')
CREATE UNIQUE NONCLUSTERED INDEX [idx__sales__sales_territory_1_name]
ON [sales].[sales_territory] (
 [name] ASC
);
