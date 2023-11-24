/****** Object:  Schema [purchasing]    Script Date: 16/11/2023 08:45:04 ******/
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'purchasing')
EXEC sys.sp_executesql N'CREATE SCHEMA [purchasing]'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', NULL,NULL, NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains objects related to vendors and purchase orders.' , @level0type=N'SCHEMA',@level0name=N'purchasing'
GO
