﻿
IF OBJECT_ID('[sales].[df_sales_tax_rate_tax_rate]', 'D') IS NULL
    BEGIN
        ALTER TABLE [sales].[sales_tax_rate]
        ADD CONSTRAINT [df_sales_tax_rate_tax_rate]
        DEFAULT ((0.00))
        FOR [tax_rate];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'sales_tax_rate'
                                              , N'CONSTRAINT',N'df_sales_tax_rate_tax_rate'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of 0.0'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'sales_tax_rate'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_sales_tax_rate_tax_rate'
GO
