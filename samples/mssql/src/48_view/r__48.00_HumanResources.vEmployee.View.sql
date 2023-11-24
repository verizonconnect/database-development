/****** Object:  View [human_resources].[employee_contact]    Script Date: 16/11/2023 08:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.views WHERE object_id = OBJECT_ID(N'[human_resources].[employee_contact]'))
EXEC sys.sp_executesql @statement = N'
CREATE VIEW [human_resources].[employee_contact] 
AS 
SELECT 
    e.[business_entity_id]
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
    ,sp.[name] AS [state_province_name] 
    ,a.[postal_code]
    ,cr.[name] AS [country_region_name] 
    ,p.[additional_contact_info]
FROM [human_resources].[employee] e
    INNER JOIN [person].[person] p
    ON p.[business_entity_id] = e.[business_entity_id]
    INNER JOIN [person].[business_entity_address] bea 
    ON bea.[business_entity_id] = e.[business_entity_id] 
    INNER JOIN [person].[address] a 
    ON a.[address_id] = bea.[address_id]
    INNER JOIN [person].[state_province] sp 
    ON sp.[state_province_id] = a.[state_province_id]
    INNER JOIN [person].[country_region] cr 
    ON cr.[country_region_code] = sp.[country_region_code]
    LEFT OUTER JOIN [person].[person_phone] pp
    ON pp.business_entity_id = p.[business_entity_id]
    LEFT OUTER JOIN [person].[phone_number_type] pnt
    ON pp.[phone_number_type_id] = pnt.[phone_number_type_id]
    LEFT OUTER JOIN [person].[email_address] ea
    ON p.[business_entity_id] = ea.[business_entity_id];
' 
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'VIEW',N'employee_contact', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'employee names and addresses.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'VIEW',@level1name=N'employee_contact'
GO
