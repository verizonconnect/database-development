SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER TRIGGER [sales].[u_sales_order_header] ON [sales].[sales_order_header] 
AFTER UPDATE NOT FOR REPLICATION AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
        -- Update revision_number for modification of any field EXCEPT the status.
        IF NOT UPDATE([status])
        BEGIN
            UPDATE [sales].[sales_order_header]
            SET [sales].[sales_order_header].[revision_number] = 
                [sales].[sales_order_header].[revision_number] + 1
            WHERE [sales].[sales_order_header].[sales_order_id] IN 
                (SELECT inserted.[sales_order_id] FROM inserted);
        END;

        -- Update the sales_person sales_ytd when sub_total is updated
        IF UPDATE([sub_total])
        BEGIN
            DECLARE @start_date datetime,
                    @end_date datetime

            SET @start_date = [common].[ufnGetAccountingstart_date]();
            SET @end_date = [common].[get_accounting_end_date]();

            UPDATE [sales].[sales_person]
            SET [sales].[sales_person].[sales_ytd] = 
                (SELECT SUM([sales].[sales_order_header].[sub_total])
                FROM [sales].[sales_order_header] 
                WHERE [sales].[sales_person].[business_entity_id] = [sales].[sales_order_header].[sales_person_id]
                    AND ([sales].[sales_order_header].[status] = 5) -- Shipped
                    AND [sales].[sales_order_header].[order_date] BETWEEN @start_date AND @end_date)
            WHERE [sales].[sales_person].[business_entity_id] 
                IN (SELECT DISTINCT inserted.[sales_person_id] FROM inserted 
                    WHERE inserted.[order_date] BETWEEN @start_date AND @end_date);

            -- Update the sales_territory sales_ytd when sub_total is updated
            UPDATE [sales].[sales_territory]
            SET [sales].[sales_territory].[sales_ytd] = 
                (SELECT SUM([sales].[sales_order_header].[sub_total])
                FROM [sales].[sales_order_header] 
                WHERE [sales].[sales_territory].[territory_id] = [sales].[sales_order_header].[territory_id]
                    AND ([sales].[sales_order_header].[status] = 5) -- Shipped
                    AND [sales].[sales_order_header].[order_date] BETWEEN @start_date AND @end_date)
            WHERE [sales].[sales_territory].[territory_id] 
                IN (SELECT DISTINCT inserted.[territory_id] FROM inserted 
                    WHERE inserted.[order_date] BETWEEN @start_date AND @end_date);
        END;
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
ALTER TABLE [sales].[sales_order_header] ENABLE TRIGGER [u_sales_order_header]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_header', N'TRIGGER',N'u_sales_order_header'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AFTER UPDATE trigger that updates the revision_number and modified_date columns in the sales_order_header table.Updates the sales_ytd column in the sales_person and sales_territory tables.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_header', @level2type=N'TRIGGER',@level2name=N'u_sales_order_header'
GO
