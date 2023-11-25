
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.views WHERE object_id = OBJECT_ID(N'[sales].[individual_customer]'))
EXEC sys.sp_executesql @statement = N'
CREATE VIEW [sales].[individual_customer] 
AS 
SELECT 
    p.[business_entity_id]
    ,p.[title]
    ,p.[first_name]
    ,p.[middle_name]
    ,p.[last_name]
    ,p.[suffix]
    ,pp.[phone_number]
    ,pnt.[name] AS [phone_number_type]
    ,ea.[email_address]
    ,p.[email_promotion]
    ,at.[name] AS [address_type]
    ,a.[address_line_1]
    ,a.[address_line_2]
    ,a.[city]
    ,[state_province_name] = sp.[name]
    ,a.[postal_code]
    ,[country_region_name] = cr.[name]
    ,p.[demographics]
FROM [person].[person] p
    INNER JOIN [person].[business_entity_address] bea 
    ON bea.[business_entity_id] = p.[business_entity_id] 
    INNER JOIN [person].[address] a 
    ON a.[address_id] = bea.[address_id]
    INNER JOIN [person].[state_province] sp 
    ON sp.[state_province_id] = a.[state_province_id]
    INNER JOIN [person].[country_region] cr 
    ON cr.[country_region_code] = sp.[country_region_code]
    INNER JOIN [person].[address_type] at 
    ON at.[address_type_id] = bea.[address_type_id]
    INNER JOIN [sales].[customer] c
    ON c.[person_id] = p.[business_entity_id]
    LEFT OUTER JOIN [person].[email_address] ea
    ON ea.[business_entity_id] = p.[business_entity_id]
    LEFT OUTER JOIN [person].[person_phone] pp
    ON pp.[business_entity_id] = p.[business_entity_id]
    LEFT OUTER JOIN [person].[phone_number_type] pnt
    ON pnt.[phone_number_type_id] = pp.[phone_number_type_id]
WHERE c.store_id IS NULL;
' 
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'VIEW',N'individual_customer', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Individual customers (names and addresses) that purchase Adventure Works Cycles products online.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'VIEW',@level1name=N'individual_customer'
GO
