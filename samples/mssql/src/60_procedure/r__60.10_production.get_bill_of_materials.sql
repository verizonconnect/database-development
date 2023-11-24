SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [production].[get_bill_of_materials]
    @Startproduct_id [int],
    @CheckDate [datetime]
AS
BEGIN
    SET NOCOUNT ON;

    -- Use recursive query to generate a multi-level Bill of Material (i.e. all level 1 
    -- components of a level 0 assembly, all level 2 components of a level 1 assembly)
    -- The CheckDate eliminates any components that are no longer used in the product on this date.
    WITH [BOM_cte]([product_assembly_id], [component_id], [componentDesc], [per_assembly_qty], [standard_cost], [list_price], [bom_level], [Recursionlevel]) -- CTE name and columns
    AS (
        SELECT b.[product_assembly_id], b.[component_id], p.[name], b.[per_assembly_qty], p.[standard_cost], p.[list_price], b.[bom_level], 0 -- Get the initial list of components for the bike assembly
        FROM [production].[bill_of_materials] b
            INNER JOIN [production].[product] p 
            ON b.[component_id] = p.[product_id] 
        WHERE b.[product_assembly_id] = @Startproduct_id 
            AND @CheckDate >= b.[start_date] 
            AND @CheckDate <= ISNULL(b.[end_date], @CheckDate)
        UNION ALL
        SELECT b.[product_assembly_id], b.[component_id], p.[name], b.[per_assembly_qty], p.[standard_cost], p.[list_price], b.[bom_level], [Recursionlevel] + 1 -- Join recursive member to anchor
        FROM [BOM_cte] cte
            INNER JOIN [production].[bill_of_materials] b 
            ON b.[product_assembly_id] = cte.[component_id]
            INNER JOIN [production].[product] p 
            ON b.[component_id] = p.[product_id] 
        WHERE @CheckDate >= b.[start_date] 
            AND @CheckDate <= ISNULL(b.[end_date], @CheckDate)
        )
    -- Outer select from the CTE
    SELECT b.[product_assembly_id], b.[component_id], b.[componentDesc], SUM(b.[per_assembly_qty]) AS [Totalquantity] , b.[standard_cost], b.[list_price], b.[bom_level], b.[Recursionlevel]
    FROM [BOM_cte] b
    GROUP BY b.[component_id], b.[componentDesc], b.[product_assembly_id], b.[bom_level], b.[Recursionlevel], b.[standard_cost], b.[list_price]
    ORDER BY b.[bom_level], b.[product_assembly_id], b.[component_id]
    OPTION (MAXRECURSION 25) 
END;
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'PROCEDURE',N'get_bill_of_materials', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'stored procedure using a recursive query to return a multi-level bill of material for the specified product_id.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'PROCEDURE',@level1name=N'get_bill_of_materials'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'PROCEDURE',N'get_bill_of_materials', N'PARAMETER',N'@Startproduct_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure get_bill_of_materials. Enter a valid product_id from the production.product table.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'PROCEDURE',@level1name=N'get_bill_of_materials', @level2type=N'PARAMETER',@level2name=N'@Startproduct_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'PROCEDURE',N'get_bill_of_materials', N'PARAMETER',N'@CheckDate'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure get_bill_of_materials used to eliminate components not used after that date. Enter a valid date.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'PROCEDURE',@level1name=N'get_bill_of_materials', @level2type=N'PARAMETER',@level2name=N'@CheckDate'
GO
