SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.views WHERE object_id = OBJECT_ID(N'[production].[product_model_instructions]'))
EXEC sys.sp_executesql @statement = N'
CREATE VIEW [production].[product_model_instructions] 
AS 
SELECT 
    [product_model_id] 
    ,[name] 
    ,[instructions].value(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions"; 
        (/root/text())[1]'', ''nvarchar(max)'') AS [instructions] 
    ,[MfgInstructions].ref.value(''@LocationID[1]'', ''int'') AS [location_id] 
    ,[MfgInstructions].ref.value(''@SetupHours[1]'', ''decimal(9, 4)'') AS [setup_hours] 
    ,[MfgInstructions].ref.value(''@MachineHours[1]'', ''decimal(9, 4)'') AS [machine_hours] 
    ,[MfgInstructions].ref.value(''@LaborHours[1]'', ''decimal(9, 4)'') AS [labor_hours] 
    ,[MfgInstructions].ref.value(''@LotSize[1]'', ''int'') AS [lot_size] 
    ,[Steps].ref.value(''string(.)[1]'', ''nvarchar(1024)'') AS [step] 
    ,[rowguid] 
    ,[modified_date]
FROM [production].[product_model] 
CROSS APPLY [Instructions].nodes(N''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions"; 
    /root/Location'') MfgInstructions(ref)
CROSS APPLY [MfgInstructions].ref.nodes(''declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions"; 
    step'') Steps(ref);
' 
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'VIEW',N'product_model_instructions', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Displays the content from each element in the xml column instructions for each product in the production.product_model table that has manufacturing instructions.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'VIEW',@level1name=N'product_model_instructions'
GO
