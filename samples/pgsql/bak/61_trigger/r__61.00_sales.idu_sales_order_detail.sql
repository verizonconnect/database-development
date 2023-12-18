SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER TRIGGER [sales].[idu_sales_order_detail] ON [sales].[sales_order_detail] 
AFTER INSERT, DELETE, UPDATE AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
        -- If inserting or updating these columns
        IF UPDATE([product_id]) OR UPDATE([order_qty]) OR UPDATE([unit_price]) OR UPDATE([unit_price_discount]) 
        -- Insert record into transaction_history
        BEGIN
            INSERT INTO [production].[transaction_history]
                ([product_id]
                ,[reference_order_id]
                ,[reference_order_line_id]
                ,[transaction_type]
                ,[transaction_date]
                ,[quantity]
                ,[actual_cost])
            SELECT 
                inserted.[product_id]
                ,inserted.[sales_order_id]
                ,inserted.[sales_order_detail_id]
                ,'S'
                ,GETDATE()
                ,inserted.[order_qty]
                ,inserted.[unit_price]
            FROM inserted 
                INNER JOIN [sales].[sales_order_header] 
                ON inserted.[sales_order_id] = [sales].[sales_order_header].[sales_order_id];

            UPDATE [person].[person] 
            SET [demographics].modify('declare default element namespace 
                "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
                replace value of (/IndividualSurvey/TotalPurchaseYTD)[1] 
                with data(/IndividualSurvey/TotalPurchaseYTD)[1] + sql:column ("inserted.line_total")') 
            FROM inserted 
                INNER JOIN [sales].[sales_order_header] AS SOH
                ON inserted.[sales_order_id] = SOH.[sales_order_id] 
                INNER JOIN [sales].[customer] AS C
                ON SOH.[customer_id] = C.[customer_id]
            WHERE C.[person_id] = [person].[person].[business_entity_id];
        END;

        -- Update sub_total in sales_order_header record. Note that this causes the 
        -- sales_order_header trigger to fire which will update the revision_number.
        UPDATE [sales].[sales_order_header]
        SET [sales].[sales_order_header].[sub_total] = 
            (SELECT SUM([sales].[sales_order_detail].[line_total])
                FROM [sales].[sales_order_detail]
                WHERE [sales].[sales_order_header].[sales_order_id] = [sales].[sales_order_detail].[sales_order_id])
        WHERE [sales].[sales_order_header].[sales_order_id] IN (SELECT inserted.[sales_order_id] FROM inserted);

        UPDATE [person].[person] 
        SET [demographics].modify('declare default element namespace 
            "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
            replace value of (/IndividualSurvey/TotalPurchaseYTD)[1] 
            with data(/IndividualSurvey/TotalPurchaseYTD)[1] - sql:column("deleted.line_total")') 
        FROM deleted 
            INNER JOIN [sales].[sales_order_header] 
            ON deleted.[sales_order_id] = [sales].[sales_order_header].[sales_order_id] 
            INNER JOIN [sales].[customer]
            ON [sales].[customer].[customer_id] = [sales].[sales_order_header].[customer_id]
        WHERE [sales].[customer].[person_id] = [person].[person].[business_entity_id];
    END TRY
    BEGIN CATCH
        EXECUTE [common].[print_error];

        -- Rollback any active or uncommittable transactions before
        -- inserting information in the error_log
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END

        EXECUTE [common].[add_log__error];
    END CATCH;
END;
GO
ALTER TABLE [sales].[sales_order_detail] ENABLE TRIGGER [idu_sales_order_detail]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'TRIGGER',N'idu_sales_order_detail'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AFTER INSERT, DELETE, UPDATE trigger that inserts a row in the transaction_history table, updates modified_date in sales_order_detail and updates the sales_order_header.sub_total column.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'TRIGGER',@level2name=N'idu_sales_order_detail'
GO
