SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[person].[person_phone]') 
                      AND i.name = N'idx__person__person_phone_1_phone_number')
CREATE NONCLUSTERED INDEX [idx__person__person_phone_1_phone_number]
ON [person].[person_phone] (
 [phone_number] ASC
);
