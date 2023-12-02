SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[person].[email_address]') 
                      AND i.name = N'idx__person__email_address_1_email_address')
CREATE NONCLUSTERED INDEX [idx__person__email_address_1_email_address]
ON [person].[email_address] (
 [email_address] ASC
);
