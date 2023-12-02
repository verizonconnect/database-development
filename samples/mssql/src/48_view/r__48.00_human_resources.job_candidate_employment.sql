
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.views WHERE object_id = OBJECT_ID(N'[human_resources].[job_candidate_employment]'))
EXEC sys.sp_executesql @statement = N'
CREATE VIEW [human_resources].[job_candidate_employment] 
AS 
SELECT 
    jc.[job_candidate_id] 
    ,CONVERT(datetime, REPLACE([employment].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.StartDate)[1]'', ''nvarchar(20)'') ,''Z'', ''''), 101) AS [emp.start_date] 
    ,CONVERT(datetime, REPLACE([employment].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.EndDate)[1]'', ''nvarchar(20)'') ,''Z'', ''''), 101) AS [emp.end_date] 
    ,[employment].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.OrgName)[1]'', ''nvarchar(100)'') AS [emp.org_name]
    ,[employment].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.JobTitle)[1]'', ''nvarchar(100)'') AS [emp.job_title]
    ,[employment].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.Responsibility)[1]'', ''nvarchar(max)'') AS [emp.responsibility]
    ,[employment].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.FunctionCategory)[1]'', ''nvarchar(max)'') AS [emp.function_category]
    ,[employment].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.IndustryCategory)[1]'', ''nvarchar(max)'') AS [emp.industry_category]
    ,[employment].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.Location/Location/Loc.CountryRegion)[1]'', ''nvarchar(max)'') AS [emp.loc.country_region]
    ,[employment].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.Location/Location/Loc.State)[1]'', ''nvarchar(max)'') AS [emp.loc.state]
    ,[employment].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.Location/Location/Loc.City)[1]'', ''nvarchar(max)'') AS [emp.loc.city]
FROM [human_resources].[job_candidate] jc 
CROSS APPLY jc.[resume].nodes(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
    /Resume/Employment'') AS employment(ref);
' 
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'VIEW',N'job_candidate_employment', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Displays the content from each employement history related element in the xml column resume in the human_resources.job_candidate table. The content has been localized into French, Simplified Chinese and Thai. Some data may not display correctly unless supplemental language support is installed.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'VIEW',@level1name=N'job_candidate_employment'
GO
