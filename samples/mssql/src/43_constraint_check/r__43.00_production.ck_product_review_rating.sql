
IF OBJECT_ID('[production].[ck_product_review_rating]', 'C') IS NULL
    BEGIN
        ALTER TABLE [production].[product_review]
        WITH NOCHECK
        ADD CONSTRAINT [ck_product_review_rating]
        CHECK ([rating]>=(1) AND [rating]<=(5));
    END;
GO

ALTER TABLE [production].[product_review] 
CHECK CONSTRAINT [ck_product_review_rating]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product_review'
                                              , N'CONSTRAINT',N'ck_product_review_rating'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [rating] BETWEEN (1) AND (5)'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product_review'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_product_review_rating'
GO
