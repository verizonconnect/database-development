/****** Object:  Schema [person]    Script Date: 16/11/2023 08:45:04 ******/
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'person')
EXEC sys.sp_executesql N'CREATE SCHEMA [person]'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', NULL,NULL, NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains objects related to names and addresses of customers, vendors, and employees' , @level0type=N'SCHEMA',@level0name=N'person'
GO
