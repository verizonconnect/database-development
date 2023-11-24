SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [common].[get_manager__per_employee]
    @business_entity_id [int]
AS
BEGIN
    SET NOCOUNT ON;

    -- Use recursive query to list out all employees required for a particular Manager
    WITH [EMP_cte]([business_entity_id], [organization_node], [first_name], [last_name], [job_title], [Recursionlevel]) -- CTE name and columns
    AS (
        SELECT e.[business_entity_id], e.[organization_node], p.[first_name], p.[last_name], e.[job_title], 0 -- Get the initial employee
        FROM [human_resources].[employee] e 
            INNER JOIN [person].[person] as p
            ON p.[business_entity_id] = e.[business_entity_id]
        WHERE e.[business_entity_id] = @business_entity_id
        UNION ALL
        SELECT e.[business_entity_id], e.[organization_node], p.[first_name], p.[last_name], e.[job_title], [Recursionlevel] + 1 -- Join recursive member to anchor
        FROM [human_resources].[employee] e 
            INNER JOIN [EMP_cte]
            ON e.[organization_node] = [EMP_cte].[organization_node].GetAncestor(1)
            INNER JOIN [person].[person] p 
            ON p.[business_entity_id] = e.[business_entity_id]
    )
    -- Join back to employee to return the manager name 
    SELECT [EMP_cte].[Recursionlevel], [EMP_cte].[business_entity_id], [EMP_cte].[first_name], [EMP_cte].[last_name], 
        [EMP_cte].[organization_node].ToString() AS [organization_node], p.[first_name] AS 'Managerfirst_name', p.[last_name] AS 'Managerlast_name'  -- Outer select from the CTE
    FROM [EMP_cte] 
        INNER JOIN [human_resources].[employee] e 
        ON [EMP_cte].[organization_node].GetAncestor(1) = e.[organization_node]
        INNER JOIN [person].[person] p 
        ON p.[business_entity_id] = e.[business_entity_id]
    ORDER BY [Recursionlevel], [EMP_cte].[organization_node].ToString()
    OPTION (MAXRECURSION 25) 
END;
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'PROCEDURE',N'get_manager__per_employee', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'stored procedure using a recursive query to return the direct and indirect managers of the specified employee.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'PROCEDURE',@level1name=N'get_manager__per_employee'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'PROCEDURE',N'get_manager__per_employee', N'PARAMETER',N'@business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure get_manager__per_employee. Enter a valid business_entity_id from the human_resources.employee table.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'PROCEDURE',@level1name=N'get_manager__per_employee', @level2type=N'PARAMETER',@level2name=N'@business_entity_id'
GO
