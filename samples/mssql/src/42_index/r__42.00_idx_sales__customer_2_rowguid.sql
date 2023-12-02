SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[sales].[customer]') 
                      AND i.name = N'idx__sales__customer_2_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [idx__sales__customer_2_rowguid]
ON [sales].[customer] (
 [rowguid] ASC
);
