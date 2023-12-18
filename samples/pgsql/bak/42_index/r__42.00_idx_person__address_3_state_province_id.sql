﻿SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[person].[address]') 
                      AND i.name = N'idx__person__address_3_state_province_id')
CREATE NONCLUSTERED INDEX [idx__person__address_3_state_province_id]
ON [person].[address] (
 [state_province_id] ASC
);