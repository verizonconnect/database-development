﻿
IF OBJECT_ID('[production].[df_product_cost_history_modified_date]', 'D') IS NULL
    BEGIN
        ALTER TABLE [production].[product_cost_history]
        ADD CONSTRAINT [df_product_cost_history_modified_date]
        DEFAULT (getdate())
        FOR [modified_date];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'production'
                                              , N'TABLE',N'product_cost_history'
                                              , N'CONSTRAINT',N'df_product_cost_history_modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of GETDATE()'
                                  , @level0type=N'SCHEMA',@level0name=N'production'
                                  , @level1type=N'TABLE',@level1name=N'product_cost_history'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_product_cost_history_modified_date'
GO
