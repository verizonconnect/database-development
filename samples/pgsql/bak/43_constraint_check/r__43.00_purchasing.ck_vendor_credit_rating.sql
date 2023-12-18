
IF OBJECT_ID('[purchasing].[ck_vendor_credit_rating]', 'C') IS NULL
    BEGIN
        ALTER TABLE [purchasing].[vendor]
        WITH NOCHECK
        ADD CONSTRAINT [ck_vendor_credit_rating]
        CHECK ([credit_rating]>=(1) AND [credit_rating]<=(5));
    END;
GO

ALTER TABLE [purchasing].[vendor] 
CHECK CONSTRAINT [ck_vendor_credit_rating]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'purchasing'
                                              , N'TABLE',N'vendor'
                                              , N'CONSTRAINT',N'ck_vendor_credit_rating'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [credit_rating] BETWEEN (1) AND (5)'
                                  , @level0type=N'SCHEMA',@level0name=N'purchasing'
                                  , @level1type=N'TABLE',@level1name=N'vendor'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_vendor_credit_rating'
GO
