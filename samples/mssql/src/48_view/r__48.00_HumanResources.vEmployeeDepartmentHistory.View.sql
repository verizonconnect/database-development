
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.views WHERE object_id = OBJECT_ID(N'[human_resources].[employee_department_history_contact]'))
EXEC sys.sp_executesql @statement = N'
CREATE VIEW [human_resources].[employee_department_history_contact] 
AS 
SELECT 
    e.[business_entity_id] 
    ,p.[title] 
    ,p.[first_name] 
    ,p.[middle_name] 
    ,p.[last_name] 
    ,p.[suffix] 
    ,s.[name] AS [shift]
    ,d.[name] AS [department] 
    ,d.[group_name] 
    ,edh.[start_date] 
    ,edh.[end_date]
FROM [human_resources].[employee] e
    INNER JOIN [person].[person] p
    ON p.[business_entity_id] = e.[business_entity_id]
    INNER JOIN [human_resources].[employee_department_history] edh 
    ON e.[business_entity_id] = edh.[business_entity_id] 
    INNER JOIN [human_resources].[department] d 
    ON edh.[department_id] = d.[department_id] 
    INNER JOIN [human_resources].[shift] s
    ON s.[shift_id] = edh.[shift_id];
' 
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'VIEW',N'employee_department_history_contact', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Returns employee name and current and previous departments.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'VIEW',@level1name=N'employee_department_history_contact'
GO
