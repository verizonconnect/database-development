IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'common')
EXEC sys.sp_executesql N'CREATE SCHEMA [common]'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', NULL,NULL, NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains objects shared across multiple schemas.' , @level0type=N'SCHEMA',@level0name=N'common'
GO
