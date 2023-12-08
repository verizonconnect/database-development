SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER TRIGGER [purchasing].[i_purchase_order_detail] ON [purchasing].[purchase_order_detail] 
AFTER INSERT AS
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
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
            ,inserted.[purchase_order_id]
            ,inserted.[purchase_order_detail_id]
            ,'P'
            ,GETDATE()
            ,inserted.[order_qty]
            ,inserted.[unit_price]
        FROM inserted 
            INNER JOIN [purchasing].[purchase_order_header] 
            ON inserted.[purchase_order_id] = [purchasing].[purchase_order_header].[purchase_order_id];

        -- Update sub_total in purchase_order_header record. Note that this causes the 
        -- purchase_order_header trigger to fire which will update the revision_number.
        UPDATE [purchasing].[purchase_order_header]
        SET [purchasing].[purchase_order_header].[sub_total] = 
            (SELECT SUM([purchasing].[purchase_order_detail].[line_total])
                FROM [purchasing].[purchase_order_detail]
                WHERE [purchasing].[purchase_order_header].[purchase_order_id] = [purchasing].[purchase_order_detail].[purchase_order_id])
        WHERE [purchasing].[purchase_order_header].[purchase_order_id] IN (SELECT inserted.[purchase_order_id] FROM inserted);
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
ALTER TABLE [purchasing].[purchase_order_detail] ENABLE TRIGGER [i_purchase_order_detail]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'TRIGGER',N'i_purchase_order_detail'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AFTER INSERT trigger that inserts a row in the transaction_history table and updates the purchase_order_header.sub_total column.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'TRIGGER',@level2name=N'i_purchase_order_detail'
GO
