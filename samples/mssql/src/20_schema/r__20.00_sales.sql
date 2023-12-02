
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'sales')
EXEC sys.sp_executesql N'CREATE SCHEMA [sales]'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', NULL,NULL, NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains objects related to customers, sales orders, and sales territories.' , @level0type=N'SCHEMA',@level0name=N'sales'
GO
