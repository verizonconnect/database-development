SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[purchasing].[ship_method]') 
                      AND i.name = N'idx__purchasing__ship_method_2_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [idx__purchasing__ship_method_2_rowguid]
ON [purchasing].[ship_method] (
 [rowguid] ASC
);
