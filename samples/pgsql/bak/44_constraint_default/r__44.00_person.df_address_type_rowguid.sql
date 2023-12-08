﻿
IF OBJECT_ID('[person].[df_address_type_rowguid]', 'D') IS NULL
    BEGIN
        ALTER TABLE [person].[address_type]
        ADD CONSTRAINT [df_address_type_rowguid]
        DEFAULT (newid())
        FOR [rowguid];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'person'
                                              , N'TABLE',N'address_type'
                                              , N'CONSTRAINT',N'df_address_type_rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Default constraint value of NEW_id()'
                                  , @level0type=N'SCHEMA',@level0name=N'person'
                                  , @level1type=N'TABLE',@level1name=N'address_type'
                                  , @level2type=N'CONSTRAINT',@level2name=N'df_address_type_rowguid'
GO
