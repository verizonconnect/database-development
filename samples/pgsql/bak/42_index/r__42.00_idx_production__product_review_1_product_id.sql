SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes AS i 
               WHERE  i.object_id = OBJECT_ID(N'[production].[product_review]') 
                      AND i.name = N'idx__production__product_review_1_product_id')
CREATE NONCLUSTERED INDEX [idx__production__product_review_1_product_id]
ON [production].[product_review] (
 [product_id] ASC, [reviewer_name] ASC
)
INCLUDE ( 
 [comments]
);
