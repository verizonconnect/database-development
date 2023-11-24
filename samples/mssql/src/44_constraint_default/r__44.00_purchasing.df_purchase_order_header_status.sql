﻿
IF OBJECT_ID('[purchasing].[df_purchase_order_header_status]', 'D') IS NULL
    BEGIN
        ALTER TABLE [purchasing].[purchase_order_header]
        ADD CONSTRAINT [df_purchase_order_header_status]
        DEFAULT ((1))
        FOR [status];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'purchasing'
                                              , N'TABLE',N'purchase_order_header'
                                              , N'CONSTRAINT',N'df_purchase_order_header_status'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of 1'
                                  , @level0type=N'SCHEMA',@level0name=N'purchasing'
                                  , @level1type=N'TABLE',@level1name=N'purchase_order_header'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_purchase_order_header_status'
GO
