
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[common].[get_contact_information]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute sys.sp_executesql @statement = N'
CREATE FUNCTION [common].[get_contact_information](@person_id int)
RETURNS @retcontact_information TABLE 
(
    -- Columns returned by the function
    [person_id] int NOT NULL, 
    [first_name] [nvarchar](50) NULL, 
    [last_name] [nvarchar](50) NULL, 
    [job_title] [nvarchar](50) NULL,
    [business_entitytype] [nvarchar](50) NULL
)
AS 
-- Returns the first name, last name, job title and business entity type for the specified contact.
-- Since a contact can serve multiple roles, more than one row may be returned.
BEGIN
    IF @person_id IS NOT NULL 
        BEGIN
        IF EXISTS(SELECT 1 FROM [human_resources].[employee] e 
                    WHERE e.[business_entity_id] = @person_id) 
            INSERT INTO @retcontact_information
                SELECT @person_id, p.first_name, p.last_name, e.[job_title], ''employee''
                FROM [human_resources].[employee] AS e
                    INNER JOIN [person].[person] p
                    ON p.[business_entity_id] = e.[business_entity_id]
                WHERE e.[business_entity_id] = @person_id;

        IF EXISTS(SELECT 1 FROM [purchasing].[vendor] AS v
                    INNER JOIN [person].[business_entity_contact] bec 
                    ON bec.[business_entity_id] = v.[business_entity_id]
                    WHERE bec.[person_id] = @person_id)
            INSERT INTO @retcontact_information
                SELECT @person_id, p.first_name, p.last_name, ct.[name], ''vendor Contact'' 
                FROM [purchasing].[vendor] AS v
                    INNER JOIN [person].[business_entity_contact] bec 
                    ON bec.[business_entity_id] = v.[business_entity_id]
                    INNER JOIN [person].contact_type ct
                    ON ct.[contact_type_id] = bec.[contact_type_id]
                    INNER JOIN [person].[person] p
                    ON p.[business_entity_id] = bec.[person_id]
                WHERE bec.[person_id] = @person_id;
        
        IF EXISTS(SELECT 1 FROM [sales].[store] AS s
                    INNER JOIN [person].[business_entity_contact] bec 
                    ON bec.[business_entity_id] = s.[business_entity_id]
                    WHERE bec.[person_id] = @person_id)
            INSERT INTO @retcontact_information
                SELECT @person_id, p.first_name, p.last_name, ct.[name], ''store Contact'' 
                FROM [sales].[store] AS s
                    INNER JOIN [person].[business_entity_contact] bec 
                    ON bec.[business_entity_id] = s.[business_entity_id]
                    INNER JOIN [person].contact_type ct
                    ON ct.[contact_type_id] = bec.[contact_type_id]
                    INNER JOIN [person].[person] p
                    ON p.[business_entity_id] = bec.[person_id]
                WHERE bec.[person_id] = @person_id;

        IF EXISTS(SELECT 1 FROM [person].[person] AS p
                    INNER JOIN [sales].[customer] AS c
                    ON c.[person_id] = p.[business_entity_id]
                    WHERE p.[business_entity_id] = @person_id AND c.[store_id] IS NULL) 
            INSERT INTO @retcontact_information
                SELECT @person_id, p.first_name, p.last_name, NULL, ''Consumer'' 
                FROM [person].[person] AS p
                    INNER JOIN [sales].[customer] AS c
                    ON c.[person_id] = p.[business_entity_id]
                    WHERE p.[business_entity_id] = @person_id AND c.[store_id] IS NULL; 
        END

    RETURN;
END;
' 
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'FUNCTION',N'get_contact_information', N'PARAMETER',N'@person_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Input parameter for the table value function get_contact_information. Enter a valid person_id from the person.Contact table.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'FUNCTION',@level1name=N'get_contact_information', @level2type=N'PARAMETER',@level2name=N'@person_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'FUNCTION',N'get_contact_information', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Table value function returning the first name, last name, job title and contact type for a given contact.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'FUNCTION',@level1name=N'get_contact_information'
GO
