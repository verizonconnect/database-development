/****** Object:  View [sales].[sales_person_sales_by_fiscal_years]    Script Date: 16/11/2023 08:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.views WHERE object_id = OBJECT_ID(N'[sales].[sales_person_sales_by_fiscal_years]'))
EXEC sys.sp_executesql @statement = N'
CREATE VIEW [sales].[sales_person_sales_by_fiscal_years] 
AS 
SELECT 
    pvt.[sales_person_id]
    ,pvt.[full_name]
    ,pvt.[job_title]
    ,pvt.[sales_territory]
    ,pvt.[2002]
    ,pvt.[2003]
    ,pvt.[2004] 
FROM (SELECT 
        soh.[sales_person_id]
        ,p.[first_name] + '' '' + COALESCE(p.[middle_name], '''') + '' '' + p.[last_name] AS [full_name]
        ,e.[job_title]
        ,st.[name] AS [sales_territory]
        ,soh.[sub_total]
        ,YEAR(DATEADD(m, 6, soh.[order_date])) AS [FiscalYear] 
    FROM [sales].[sales_person] sp 
        INNER JOIN [sales].[sales_order_header] soh 
        ON sp.[business_entity_id] = soh.[sales_person_id]
        INNER JOIN [sales].[sales_territory] st 
        ON sp.[territory_id] = st.[territory_id] 
        INNER JOIN [human_resources].[employee] e 
        ON soh.[sales_person_id] = e.[business_entity_id] 
        INNER JOIN [person].[person] p
        ON p.[business_entity_id] = sp.[business_entity_id]
     ) AS soh 
PIVOT 
(
    SUM([sub_total]) 
    FOR [FiscalYear] 
    IN ([2002], [2003], [2004])
) AS pvt;
' 
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'VIEW',N'sales_person_sales_by_fiscal_years', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Uses PIVOT to return aggregated sales information for each sales representative.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'VIEW',@level1name=N'sales_person_sales_by_fiscal_years'
GO
