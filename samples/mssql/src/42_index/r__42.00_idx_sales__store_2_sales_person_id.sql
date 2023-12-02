SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[sales].[store]') 
                      AND i.name = N'idx__sales__store_2_sales_person_id')
CREATE NONCLUSTERED INDEX [idx__sales__store_2_sales_person_id]
ON [sales].[store] (
 [sales_person_id] ASC
);
