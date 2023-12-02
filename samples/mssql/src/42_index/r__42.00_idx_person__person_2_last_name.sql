SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[person].[person]') 
                      AND i.name = N'idx__person__person_2_last_name')
CREATE NONCLUSTERED INDEX [idx__person__person_2_last_name]
ON [person].[person] (
 [last_name] ASC, [first_name] ASC, [middle_name] ASC
);
