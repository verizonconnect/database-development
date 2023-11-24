/****** Object:  storedProcedure [common].[uspGetWhereUsedproduct_id]    Script Date: 16/11/2023 08:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[common].[uspGetWhereUsedproduct_id]') AND type in (N'P', N'PC'))
BEGIN
EXEC sys.sp_executesql @statement = N'CREATE PROCEDURE [common].[uspGetWhereUsedproduct_id] AS' 
END
GO

ALTER PROCEDURE [common].[uspGetWhereUsedproduct_id]
    @Startproduct_id [int],
    @CheckDate [datetime]
AS
BEGIN
    SET NOCOUNT ON;

    --Use recursive query to generate a multi-level Bill of Material (i.e. all level 1 components of a level 0 assembly, all level 2 components of a level 1 assembly)
    WITH [BOM_cte]([product_assembly_id], [component_id], [componentDesc], [per_assembly_qty], [standard_cost], [list_price], [bom_level], [Recursionlevel]) -- CTE name and columns
    AS (
        SELECT b.[product_assembly_id], b.[component_id], p.[name], b.[per_assembly_qty], p.[standard_cost], p.[list_price], b.[bom_level], 0 -- Get the initial list of components for the bike assembly
        FROM [production].[bill_of_materials] b
            INNER JOIN [production].[product] p 
            ON b.[product_assembly_id] = p.[product_id] 
        WHERE b.[component_id] = @Startproduct_id 
            AND @CheckDate >= b.[start_date] 
            AND @CheckDate <= ISNULL(b.[end_date], @CheckDate)
        UNION ALL
        SELECT b.[product_assembly_id], b.[component_id], p.[name], b.[per_assembly_qty], p.[standard_cost], p.[list_price], b.[bom_level], [Recursionlevel] + 1 -- Join recursive member to anchor
        FROM [BOM_cte] cte
            INNER JOIN [production].[bill_of_materials] b 
            ON cte.[product_assembly_id] = b.[component_id]
            INNER JOIN [production].[product] p 
            ON b.[product_assembly_id] = p.[product_id] 
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
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'PROCEDURE',N'uspGetWhereUsedproduct_id', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'stored procedure using a recursive query to return all components or assemblies that directly or indirectly use the specified product_id.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'PROCEDURE',@level1name=N'uspGetWhereUsedproduct_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'PROCEDURE',N'uspGetWhereUsedproduct_id', N'PARAMETER',N'@Startproduct_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure uspGetWhereUsedproduct_id. Enter a valid product_id from the production.product table.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'PROCEDURE',@level1name=N'uspGetWhereUsedproduct_id', @level2type=N'PARAMETER',@level2name=N'@Startproduct_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'PROCEDURE',N'uspGetWhereUsedproduct_id', N'PARAMETER',N'@CheckDate'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the stored procedure uspGetWhereUsedproduct_id used to eliminate components not used after that date. Enter a valid date.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'PROCEDURE',@level1name=N'uspGetWhereUsedproduct_id', @level2type=N'PARAMETER',@level2name=N'@CheckDate'
GO
