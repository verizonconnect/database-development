SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[purchasing].[vendor]') 
                      AND i.name = N'idx__purchasing__vendor_1_account_number')
CREATE UNIQUE NONCLUSTERED INDEX [idx__purchasing__vendor_1_account_number]
ON [purchasing].[vendor] (
 [account_number] ASC
);
