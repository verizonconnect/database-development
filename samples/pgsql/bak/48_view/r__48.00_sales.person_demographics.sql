SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.views WHERE object_id = OBJECT_ID(N'[sales].[person_demographics]'))
EXEC sys.sp_executesql @statement = N'
CREATE VIEW [sales].[person_demographics] 
AS 
SELECT 
    p.[business_entity_id] 
    ,[IndividualSurvey].[ref].[value](N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        TotalPurchaseYTD[1]'', ''money'') AS [TotalpurchaseYTD] 
    ,CONVERT(datetime, REPLACE([IndividualSurvey].[ref].[value](N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        DateFirstPurchase[1]'', ''nvarchar(20)'') ,''Z'', ''''), 101) AS [DateFirstpurchase] 
    ,CONVERT(datetime, REPLACE([IndividualSurvey].[ref].[value](N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        BirthDate[1]'', ''nvarchar(20)'') ,''Z'', ''''), 101) AS [birth_date] 
    ,[IndividualSurvey].[ref].[value](N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        MaritalStatus[1]'', ''nvarchar(1)'') AS [marital_status] 
    ,[IndividualSurvey].[ref].[value](N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        YearlyIncome[1]'', ''nvarchar(30)'') AS [yearly_income] 
    ,[IndividualSurvey].[ref].[value](N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        Gender[1]'', ''nvarchar(1)'') AS [gender] 
    ,[IndividualSurvey].[ref].[value](N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        TotalChildren[1]'', ''integer'') AS [total_children] 
    ,[IndividualSurvey].[ref].[value](N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        NumberChildrenAtHome[1]'', ''integer'') AS [number_children_at_home] 
    ,[IndividualSurvey].[ref].[value](N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        Education[1]'', ''nvarchar(30)'') AS [education] 
    ,[IndividualSurvey].[ref].[value](N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        Occupation[1]'', ''nvarchar(30)'') AS [occupation] 
    ,[IndividualSurvey].[ref].[value](N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        HomeOwnerFlag[1]'', ''bit'') AS [home_owner_flag] 
    ,[IndividualSurvey].[ref].[value](N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        NumberCarsOwned[1]'', ''integer'') AS [number_cars_owned] 
FROM [person].[person] p 
CROSS APPLY p.[Demographics].nodes(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
    /IndividualSurvey'') AS [IndividualSurvey](ref) 
WHERE [Demographics] IS NOT NULL;
' 
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'VIEW',N'person_demographics', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Displays the content from each element in the xml column demographics for each customer in the person.person table.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'VIEW',@level1name=N'person_demographics'
GO
