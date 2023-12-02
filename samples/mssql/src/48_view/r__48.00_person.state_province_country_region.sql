
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.views WHERE object_id = OBJECT_ID(N'[person].[state_province_country_region]'))
EXEC sys.sp_executesql @statement = N'
CREATE VIEW [person].[state_province_country_region] 
WITH SCHEMABINDING 
AS 
SELECT 
    sp.[state_province_id] 
    ,sp.[state_province_code] 
    ,sp.[is_only_state_province_flag] 
    ,sp.[name] AS [state_province_name] 
    ,sp.[territory_id] 
    ,cr.[country_region_code] 
    ,cr.[name] AS [country_region_name]
FROM [person].[state_province] sp 
    INNER JOIN [person].[country_region] cr 
    ON sp.[country_region_code] = cr.[country_region_code];
' 
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[person].[state_province_country_region]') AND name = N'IX_state_province_country_region')
CREATE UNIQUE CLUSTERED INDEX [IX_state_province_country_region] ON [person].[state_province_country_region]
(
    [state_province_id] ASC,
    [country_region_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'VIEW',N'state_province_country_region', N'INDEX',N'IX_state_province_country_region'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Clustered index on the view state_province_country_region.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'VIEW',@level1name=N'state_province_country_region', @level2type=N'INDEX',@level2name=N'IX_state_province_country_region'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'VIEW',N'state_province_country_region', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Joins state_province table with country_region table.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'VIEW',@level1name=N'state_province_country_region'
GO
