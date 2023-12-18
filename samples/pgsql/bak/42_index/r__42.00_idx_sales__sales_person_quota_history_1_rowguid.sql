SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[sales].[sales_person_quota_history]') 
                      AND i.name = N'idx__sales__sales_person_quota_history_1_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [idx__sales__sales_person_quota_history_1_rowguid]
ON [sales].[sales_person_quota_history] (
 [rowguid] ASC
);
