
IF OBJECT_ID('[sales].[ck_sales_tax_rate_tax_type]', 'C') IS NULL
    BEGIN
        ALTER TABLE [sales].[sales_tax_rate]
        WITH NOCHECK
        ADD CONSTRAINT [ck_sales_tax_rate_tax_type]
        CHECK ([tax_type]>=(1) AND [tax_type]<=(3));
    END;
GO

ALTER TABLE [sales].[sales_tax_rate] 
CHECK CONSTRAINT [ck_sales_tax_rate_tax_type]
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_tax_rate'
                                              , N'CONSTRAINT',N'ck_sales_tax_rate_tax_type'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Check constraint [tax_type] BETWEEN (1) AND (3)'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_tax_rate'
                                  , @level2type=N'CONSTRAINT',@level2name=N'ck_sales_tax_rate_tax_type'
GO
