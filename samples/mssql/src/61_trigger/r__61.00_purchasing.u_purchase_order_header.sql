SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER TRIGGER [purchasing].[u_purchase_order_header] ON [purchasing].[purchase_order_header] 
AFTER UPDATE AS 
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
            UPDATE [purchasing].[purchase_order_header]
            SET [purchasing].[purchase_order_header].[revision_number] = 
                [purchasing].[purchase_order_header].[revision_number] + 1
            WHERE [purchasing].[purchase_order_header].[purchase_order_id] IN 
                (SELECT inserted.[purchase_order_id] FROM inserted);
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
ALTER TABLE [purchasing].[purchase_order_header] ENABLE TRIGGER [u_purchase_order_header]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_header', N'TRIGGER',N'u_purchase_order_header'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AFTER UPDATE trigger that updates the revision_number and modified_date columns in the purchase_order_header table.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_header', @level2type=N'TRIGGER',@level2name=N'u_purchase_order_header'
GO
