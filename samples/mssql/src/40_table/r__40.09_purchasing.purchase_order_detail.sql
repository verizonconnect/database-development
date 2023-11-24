/****** Object:  Table [purchasing].[purchase_order_detail]    Script Date: 16/11/2023 08:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[purchasing].[purchase_order_detail]') AND type in (N'U'))
BEGIN
CREATE TABLE [purchasing].[purchase_order_detail](
    [purchase_order_id] [int] NOT NULL,
    [purchase_order_detail_id] [int] IDENTITY(1,1) NOT NULL,
    [due_date] [datetime] NOT NULL,
    [order_qty] [smallint] NOT NULL,
    [product_id] [int] NOT NULL,
    [unit_price] [money] NOT NULL,
    [line_total]  AS (isnull([order_qty]*[unit_price],(0.00))),
    [received_qty] [decimal](8, 2) NOT NULL,
    [rejected_qty] [decimal](8, 2) NOT NULL,
    [stocked_qty]  AS (isnull([received_qty]-[rejected_qty],(0.00))),
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Index [IX_purchase_order_detail_product_id]    Script Date: 16/11/2023 08:45:05 ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[purchasing].[purchase_order_detail]') AND name = N'IX_purchase_order_detail_product_id')
CREATE NONCLUSTERED INDEX [IX_purchase_order_detail_product_id] ON [purchasing].[purchase_order_detail]
(
    [product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Trigger [purchasing].[ipurchase_order_detail]    Script Date: 16/11/2023 08:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE object_id = OBJECT_ID(N'[purchasing].[ipurchase_order_detail]'))
EXEC sys.sp_executesql @statement = N'
CREATE TRIGGER [purchasing].[ipurchase_order_detail] ON [purchasing].[purchase_order_detail] 
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
            ,''P''
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
' 
GO
ALTER TABLE [purchasing].[purchase_order_detail] ENABLE TRIGGER [ipurchase_order_detail]
GO
/****** Object:  Trigger [purchasing].[upurchase_order_detail]    Script Date: 16/11/2023 08:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE object_id = OBJECT_ID(N'[purchasing].[upurchase_order_detail]'))
EXEC sys.sp_executesql @statement = N'
CREATE TRIGGER [purchasing].[upurchase_order_detail] ON [purchasing].[purchase_order_detail] 
AFTER UPDATE AS 
BEGIN
    DECLARE @Count int;

    SET @Count = @@ROWCOUNT;
    IF @Count = 0 
        RETURN;

    SET NOCOUNT ON;

    BEGIN TRY
        IF UPDATE([product_id]) OR UPDATE([order_qty]) OR UPDATE([unit_price])
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
                ,inserted.[purchase_order_id]
                ,inserted.[purchase_order_detail_id]
                ,''P''
                ,GETDATE()
                ,inserted.[order_qty]
                ,inserted.[unit_price]
            FROM inserted 
                INNER JOIN [purchasing].[purchase_order_detail] 
                ON inserted.[purchase_order_id] = [purchasing].[purchase_order_detail].[purchase_order_id];

            -- Update sub_total in purchase_order_header record. Note that this causes the 
            -- purchase_order_header trigger to fire which will update the revision_number.
            UPDATE [purchasing].[purchase_order_header]
            SET [purchasing].[purchase_order_header].[sub_total] = 
                (SELECT SUM([purchasing].[purchase_order_detail].[line_total])
                    FROM [purchasing].[purchase_order_detail]
                    WHERE [purchasing].[purchase_order_header].[purchase_order_id] 
                        = [purchasing].[purchase_order_detail].[purchase_order_id])
            WHERE [purchasing].[purchase_order_header].[purchase_order_id] 
                IN (SELECT inserted.[purchase_order_id] FROM inserted);

            UPDATE [purchasing].[purchase_order_detail]
            SET [purchasing].[purchase_order_detail].[modified_date] = GETDATE()
            FROM inserted
            WHERE inserted.[purchase_order_id] = [purchasing].[purchase_order_detail].[purchase_order_id]
                AND inserted.[purchase_order_detail_id] = [purchasing].[purchase_order_detail].[purchase_order_detail_id];
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
' 
GO
ALTER TABLE [purchasing].[purchase_order_detail] ENABLE TRIGGER [upurchase_order_detail]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'purchase_order_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to purchase_order_header.purchase_order_id.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'purchase_order_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'purchase_order_detail_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. One line number per purchased product.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'purchase_order_detail_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'due_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the product is expected to be received.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'due_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'order_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'quantity ordered.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'order_qty'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product identification number. Foreign key to product.product_id.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'unit_price'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'vendor''s selling price of a single product.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'unit_price'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'line_total'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Per product subtotal. Computed as order_qty * unit_price.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'line_total'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'received_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'quantity actually received from the vendor.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'received_qty'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'rejected_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'quantity rejected during inspection.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'rejected_qty'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'stocked_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'quantity accepted into inventory. Computed as received_qty - rejected_qty.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'stocked_qty'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'INDEX',N'IX_purchase_order_detail_product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'INDEX',@level2name=N'IX_purchase_order_detail_product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Individual products associated with a specific purchase order. See purchase_order_header.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'TRIGGER',N'ipurchase_order_detail'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AFTER INSERT trigger that inserts a row in the transaction_history table and updates the purchase_order_header.sub_total column.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'TRIGGER',@level2name=N'ipurchase_order_detail'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'purchase_order_detail', N'TRIGGER',N'upurchase_order_detail'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AFTER UPDATE trigger that inserts a row in the transaction_history table, updates modified_date in purchase_order_detail and updates the purchase_order_header.sub_total column.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'purchase_order_detail', @level2type=N'TRIGGER',@level2name=N'upurchase_order_detail'
GO
