
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = N'human_resources')
EXEC sys.sp_executesql N'CREATE SCHEMA [human_resources]'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', NULL,NULL, NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contains objects related to employees and departments.' , @level0type=N'SCHEMA',@level0name=N'human_resources'
GO
