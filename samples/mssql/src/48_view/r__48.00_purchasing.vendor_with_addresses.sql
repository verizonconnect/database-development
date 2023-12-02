SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [purchasing].[vendor_with_addresses] AS 
SELECT 
    v.[business_entity_id]
    ,v.[name]
    ,at.[name] AS [address_type]
    ,a.[address_line_1] 
    ,a.[address_line_2] 
    ,a.[city] 
    ,sp.[name] AS [state_province_name] 
    ,a.[postal_code] 
    ,cr.[name] AS [country_region_name] 
FROM [purchasing].[vendor] v
    INNER JOIN [person].[business_entity_address] bea 
    ON bea.[business_entity_id] = v.[business_entity_id] 
    INNER JOIN [person].[address] a 
    ON a.[address_id] = bea.[address_id]
    INNER JOIN [person].[state_province] sp 
    ON sp.[state_province_id] = a.[state_province_id]
    INNER JOIN [person].[country_region] cr 
    ON cr.[country_region_code] = sp.[country_region_code]
    INNER JOIN [person].[address_type] at 
    ON at.[address_type_id] = bea.[address_type_id];
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'VIEW',N'vendor_with_addresses', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'vendor (company) names and addresses .' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'VIEW',@level1name=N'vendor_with_addresses'
GO
