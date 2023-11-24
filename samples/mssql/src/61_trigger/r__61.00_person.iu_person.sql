SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER TRIGGER [person].[iu_person] ON [person].[person] 
AFTER INSERT, UPDATE NOT FOR REPLICATION AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    IF UPDATE([business_entity_id]) OR UPDATE([demographics]) 
    BEGIN
        UPDATE [person].[person] 
        SET [person].[person].[demographics] = N'<IndividualSurvey xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"> 
            <TotalPurchaseYTD>0.00</TotalPurchaseYTD> 
            </IndividualSurvey>' 
        FROM inserted 
        WHERE [person].[person].[business_entity_id] = inserted.[business_entity_id] 
            AND inserted.[demographics] IS NULL;
        
        UPDATE [person].[person] 
        SET [demographics].modify(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
            insert <TotalPurchaseYTD>0.00</TotalPurchaseYTD> 
            as first 
            into (/IndividualSurvey)[1]') 
        FROM inserted 
        WHERE [person].[person].[business_entity_id] = inserted.[business_entity_id] 
            AND inserted.[demographics] IS NOT NULL 
            AND inserted.[demographics].exist(N'declare default element namespace 
                "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
                /IndividualSurvey/TotalPurchaseYTD') <> 1;
    END;
END;
GO
ALTER TABLE [person].[person] ENABLE TRIGGER [iu_person]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'person', N'TRIGGER',N'iu_person'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AFTER INSERT, UPDATE trigger inserting Individual only if the customer does not exist in the store table and setting the modified_date column in the person table to the current date.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'person', @level2type=N'TRIGGER',@level2name=N'iu_person'
GO
