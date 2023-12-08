SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[person].[additional_contact_info]'))
EXEC sys.sp_executesql @statement = N'
CREATE VIEW [person].[additional_contact_info] 
AS 
SELECT 
    [business_entity_id] 
    ,[first_name]
    ,[middle_name]
    ,[last_name]
    ,[ContactInfo].ref.value(N''declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:telephoneNumber)[1]/act:number'', ''nvarchar(50)'') AS [telephone_number] 
    ,LTRIM(RTRIM([ContactInfo].ref.value(N''declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:telephoneNumber/act:SpecialInstructions/text())[1]'', ''nvarchar(max)''))) AS [telephone_special_instructions] 
    ,[ContactInfo].ref.value(N''declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes";
        (act:homePostalAddress/act:Street)[1]'', ''nvarchar(50)'') AS [street] 
    ,[ContactInfo].ref.value(N''declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:homePostalAddress/act:City)[1]'', ''nvarchar(50)'') AS [city] 
    ,[ContactInfo].ref.value(N''declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:homePostalAddress/act:StateProvince)[1]'', ''nvarchar(50)'') AS [state_province] 
    ,[ContactInfo].ref.value(N''declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:homePostalAddress/act:PostalCode)[1]'', ''nvarchar(50)'') AS [postal_code] 
    ,[ContactInfo].ref.value(N''declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:homePostalAddress/act:CountryRegion)[1]'', ''nvarchar(50)'') AS [country_region] 
    ,[ContactInfo].ref.value(N''declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:homePostalAddress/act:SpecialInstructions/text())[1]'', ''nvarchar(max)'') AS [home_address_special_instructions] 
    ,[ContactInfo].ref.value(N''declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:eMail/act:eMailAddress)[1]'', ''nvarchar(128)'') AS [email_address] 
    ,LTRIM(RTRIM([ContactInfo].ref.value(N''declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:eMail/act:SpecialInstructions/text())[1]'', ''nvarchar(max)''))) AS [email_special_instructions] 
    ,[ContactInfo].ref.value(N''declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (act:eMail/act:SpecialInstructions/act:telephoneNumber/act:number)[1]'', ''nvarchar(50)'') AS [email_telephone_number] 
    ,[rowguid] 
    ,[modified_date]
FROM [person].[person]
OUTER APPLY [additional_contact_info].nodes(
    ''declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
    /ci:AdditionalContactInfo'') AS ContactInfo(ref) 
WHERE [additional_contact_info] IS NOT NULL;
' 
GO
IF NOT EXISTS (SELECT * FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'VIEW',N'additional_contact_info', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Displays the contact name and content from each element in the xml column AdditionalContactInfo for that person.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'VIEW',@level1name=N'additional_contact_info'
GO
