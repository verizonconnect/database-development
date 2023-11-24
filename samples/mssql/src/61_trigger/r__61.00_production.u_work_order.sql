SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER TRIGGER [production].[u_work_order] ON [production].[work_order] 
AFTER UPDATE AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
        IF UPDATE([product_id]) OR UPDATE([order_qty])
        BEGIN
            INSERT INTO [production].[transaction_history](
                [product_id]
                ,[reference_order_id]
                ,[transaction_type]
                ,[transaction_date]
                ,[quantity])
            SELECT 
                inserted.[product_id]
                ,inserted.[work_order_id]
                ,'W'
                ,GETDATE()
                ,inserted.[order_qty]
            FROM inserted;
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
ALTER TABLE [production].[work_order] ENABLE TRIGGER [u_work_order]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'work_order', N'TRIGGER',N'u_work_order'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AFTER UPDATE trigger that inserts a row in the transaction_history table, updates modified_date in the work_order table.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'work_order', @level2type=N'TRIGGER',@level2name=N'u_work_order'
GO
