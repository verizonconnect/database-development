﻿SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[production].[product_model]') 
                      AND i.name = N'idx__production__product_model_2_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [idx__production__product_model_2_rowguid]
ON [production].[product_model] (
 [rowguid] ASC
);
