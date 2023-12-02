
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.views WHERE object_id = OBJECT_ID(N'[human_resources].[job_candidate_education]'))
EXEC sys.sp_executesql @statement = N'
CREATE VIEW [human_resources].[job_candidate_education] 
AS 
SELECT 
    jc.[job_candidate_id] 
    ,[education].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Level)[1]'', ''nvarchar(max)'') AS [edu.level]
    ,CONVERT(datetime, REPLACE([education].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.StartDate)[1]'', ''nvarchar(20)'') ,''Z'', ''''), 101) AS [edu.start_date] 
    ,CONVERT(datetime, REPLACE([education].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.EndDate)[1]'', ''nvarchar(20)'') ,''Z'', ''''), 101) AS [edu.end_date] 
    ,[education].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Degree)[1]'', ''nvarchar(50)'') AS [edu.degree]
    ,[education].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Major)[1]'', ''nvarchar(50)'') AS [edu.major]
    ,[education].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Minor)[1]'', ''nvarchar(50)'') AS [edu.minor]
    ,[education].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.GPA)[1]'', ''nvarchar(5)'') AS [edu.gpa]
    ,[education].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.GPAScale)[1]'', ''nvarchar(5)'') AS [edu.gpa_scale]
    ,[education].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.School)[1]'', ''nvarchar(100)'') AS [edu.school]
    ,[education].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Location/Location/Loc.CountryRegion)[1]'', ''nvarchar(100)'') AS [edu.loc.country_region]
    ,[education].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Location/Location/Loc.State)[1]'', ''nvarchar(100)'') AS [edu.loc.state]
    ,[education].ref.value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Location/Location/Loc.City)[1]'', ''nvarchar(100)'') AS [edu.loc.city]
FROM [human_resources].[job_candidate] jc 
CROSS APPLY jc.[resume].nodes(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
    /Resume/Education'') AS [education](ref);
' 
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'VIEW',N'job_candidate_education', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Displays the content from each education related element in the xml column resume in the human_resources.job_candidate table. The content has been localized into French, Simplified Chinese and Thai. Some data may not display correctly unless supplemental language support is installed.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'VIEW',@level1name=N'job_candidate_education'
GO
