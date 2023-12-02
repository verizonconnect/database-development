SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.views WHERE object_id = OBJECT_ID(N'[sales].[store_with_demographics]'))
EXEC sys.sp_executesql @statement = N'
CREATE VIEW [sales].[store_with_demographics] AS 
SELECT 
    s.[business_entity_id] 
    ,s.[name] 
    ,s.[demographics].value(''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/AnnualSales)[1]'', ''money'') AS [annual_sales] 
    ,s.[demographics].value(''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/AnnualRevenue)[1]'', ''money'') AS [annual_revenue] 
    ,s.[demographics].value(''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/BankName)[1]'', ''nvarchar(50)'') AS [bank_name] 
    ,s.[demographics].value(''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/BusinessType)[1]'', ''nvarchar(5)'') AS [business_type] 
    ,s.[demographics].value(''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/YearOpened)[1]'', ''integer'') AS [year_opened] 
    ,s.[demographics].value(''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/Specialty)[1]'', ''nvarchar(50)'') AS [specialty] 
    ,s.[demographics].value(''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/SquareFeet)[1]'', ''integer'') AS [square_feet] 
    ,s.[demographics].value(''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/Brands)[1]'', ''nvarchar(30)'') AS [brands] 
    ,s.[demographics].value(''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/Internet)[1]'', ''nvarchar(30)'') AS [internet] 
    ,s.[demographics].value(''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/NumberEmployees)[1]'', ''integer'') AS [number_employees] 
FROM [sales].[store] s;
' 
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'VIEW',N'store_with_demographics', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'stores (including demographics) that sell Adventure Works Cycles products to consumers.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'VIEW',@level1name=N'store_with_demographics'
GO
