﻿
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.views WHERE object_id = OBJECT_ID(N'[sales].[store_with_contacts]'))
EXEC sys.sp_executesql @statement = N'
CREATE VIEW [sales].[store_with_contacts] AS 
SELECT 
    s.[business_entity_id] 
    ,s.[name] 
    ,ct.[name] AS [contact_type] 
    ,p.[title] 
    ,p.[first_name] 
    ,p.[middle_name] 
    ,p.[last_name] 
    ,p.[suffix] 
    ,pp.[phone_number] 
    ,pnt.[name] AS [phone_number_type]
    ,ea.[email_address] 
    ,p.[email_promotion] 
FROM [sales].[store] s
    INNER JOIN [person].[business_entity_contact] bec 
    ON bec.[business_entity_id] = s.[business_entity_id]
    INNER JOIN [person].[contact_type] ct
    ON ct.[contact_type_id] = bec.[contact_type_id]
    INNER JOIN [person].[person] p
    ON p.[business_entity_id] = bec.[person_id]
    LEFT OUTER JOIN [person].[email_address] ea
    ON ea.[business_entity_id] = p.[business_entity_id]
    LEFT OUTER JOIN [person].[person_phone] pp
    ON pp.[business_entity_id] = p.[business_entity_id]
    LEFT OUTER JOIN [person].[phone_number_type] pnt
    ON pnt.[phone_number_type_id] = pp.[phone_number_type_id];
' 
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'VIEW',N'store_with_contacts', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'stores (including store contacts) that sell Adventure Works Cycles products to consumers.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'VIEW',@level1name=N'store_with_contacts'
GO
