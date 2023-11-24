﻿
IF OBJECT_ID('[sales].[df_store_rowguid]', 'D') IS NULL
    BEGIN
        ALTER TABLE [sales].[store]
        ADD CONSTRAINT [df_store_rowguid]
        DEFAULT (newid())
        FOR [rowguid];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'sales'
                                              , N'TABLE',N'store'
                                              , N'CONSTRAINT',N'df_store_rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of NEW_id()'
                                  , @level0type=N'SCHEMA',@level0name=N'sales'
                                  , @level1type=N'TABLE',@level1name=N'store'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_store_rowguid'
GO
