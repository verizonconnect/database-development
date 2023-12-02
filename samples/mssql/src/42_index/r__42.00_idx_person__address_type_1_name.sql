SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[person].[address_type]') 
                      AND i.name = N'idx__person__address_type_1_name')
CREATE UNIQUE NONCLUSTERED INDEX [idx__person__address_type_1_name]
ON [person].[address_type] (
 [name] ASC
);
