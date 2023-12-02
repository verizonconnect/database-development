SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[sales].[credit_card]') 
                      AND i.name = N'idx__sales__credit_card_1_card_number')
CREATE UNIQUE NONCLUSTERED INDEX [idx__sales__credit_card_1_card_number]
ON [sales].[credit_card] (
 [card_number] ASC
);
