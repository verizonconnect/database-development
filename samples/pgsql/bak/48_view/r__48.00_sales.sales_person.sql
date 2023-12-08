SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.views WHERE object_id = OBJECT_ID(N'[sales].[sales_person_contact]'))
EXEC sys.sp_executesql @statement = N'
CREATE VIEW [sales].[sales_person_contact] 
AS 
SELECT 
    s.[business_entity_id]
    ,p.[title]
    ,p.[first_name]
    ,p.[middle_name]
    ,p.[last_name]
    ,p.[suffix]
    ,e.[job_title]
    ,pp.[phone_number]
    ,pnt.[name] AS [phone_number_type]
    ,ea.[email_address]
    ,p.[email_promotion]
    ,a.[address_line_1]
    ,a.[address_line_2]
    ,a.[city]
    ,[state_province_name] = sp.[name]
    ,a.[postal_code]
    ,[country_region_name] = cr.[name]
    ,[territory_name] = st.[name]
    ,[territory_group] = st.[group]
    ,s.[sales_quota]
    ,s.[sales_ytd]
    ,s.[sales_last_year]
FROM [sales].[sales_person] s
    INNER JOIN [human_resources].[employee] e 
    ON e.[business_entity_id] = s.[business_entity_id]
    INNER JOIN [person].[person] p
    ON p.[business_entity_id] = s.[business_entity_id]
    INNER JOIN [person].[business_entity_address] bea 
    ON bea.[business_entity_id] = s.[business_entity_id] 
    INNER JOIN [person].[address] a 
    ON a.[address_id] = bea.[address_id]
    INNER JOIN [person].[state_province] sp 
    ON sp.[state_province_id] = a.[state_province_id]
    INNER JOIN [person].[country_region] cr 
    ON cr.[country_region_code] = sp.[country_region_code]
    LEFT OUTER JOIN [sales].[sales_territory] st 
    ON st.[territory_id] = s.[territory_id]
    LEFT OUTER JOIN [person].[email_address] ea
    ON ea.[business_entity_id] = p.[business_entity_id]
    LEFT OUTER JOIN [person].[person_phone] pp
    ON pp.[business_entity_id] = p.[business_entity_id]
    LEFT OUTER JOIN [person].[phone_number_type] pnt
    ON pnt.[phone_number_type_id] = pp.[phone_number_type_id];
' 
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'VIEW',N'sales_person_contact', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sales representiatives (names and addresses) and their sales-related information.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'VIEW',@level1name=N'sales_person_contact'
GO
