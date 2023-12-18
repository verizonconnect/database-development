﻿SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[production].[transaction_history]') 
                      AND i.name = N'idx__production__transaction_history_1_product_id')
CREATE NONCLUSTERED INDEX [idx__production__transaction_history_1_product_id]
ON [production].[transaction_history] (
 [product_id] ASC
);
