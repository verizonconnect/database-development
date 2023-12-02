SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[person].[address]') 
                      AND i.name = N'idx__person__address_2_address_line_1')
CREATE UNIQUE NONCLUSTERED INDEX [idx__person__address_2_address_line_1]
ON [person].[address] (
 [address_line_1] ASC, [address_line_2] ASC, [city] ASC, [state_province_id] ASC, [postal_code] ASC
);
