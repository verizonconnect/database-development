/****** Object:  Table [sales].[sales_order_detail]    Script Date: 16/11/2023 08:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[sales].[sales_order_detail]') AND type in (N'U'))
BEGIN
CREATE TABLE [sales].[sales_order_detail](
    [sales_order_id] [int] NOT NULL,
    [sales_order_detail_id] [int] IDENTITY(1,1) NOT NULL,
    [carrier_tracking_number] [nvarchar](25) NULL,
    [order_qty] [smallint] NOT NULL,
    [product_id] [int] NOT NULL,
    [special_offer_id] [int] NOT NULL,
    [unit_price] [money] NOT NULL,
    [unit_price_discount] [money] NOT NULL,
    [line_total]  AS (isnull(([unit_price]*((1.0)-[unit_price_discount]))*[order_qty],(0.0))),
    [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Index [AK_sales_order_detail_rowguid]    Script Date: 16/11/2023 08:45:05 ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[sales].[sales_order_detail]') AND name = N'AK_sales_order_detail_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [AK_sales_order_detail_rowguid] ON [sales].[sales_order_detail]
(
    [rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_sales_order_detail_product_id]    Script Date: 16/11/2023 08:45:05 ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[sales].[sales_order_detail]') AND name = N'IX_sales_order_detail_product_id')
CREATE NONCLUSTERED INDEX [IX_sales_order_detail_product_id] ON [sales].[sales_order_detail]
(
    [product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Trigger [sales].[idusales_order_detail]    Script Date: 16/11/2023 08:45:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.triggers WHERE object_id = OBJECT_ID(N'[sales].[idusales_order_detail]'))
EXEC sys.sp_executesql @statement = N'
CREATE TRIGGER [sales].[idusales_order_detail] ON [sales].[sales_order_detail] 
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
                ,''S''
                ,GETDATE()
                ,inserted.[order_qty]
                ,inserted.[unit_price]
            FROM inserted 
                INNER JOIN [sales].[sales_order_header] 
                ON inserted.[sales_order_id] = [sales].[sales_order_header].[sales_order_id];

            UPDATE [person].[person] 
            SET [demographics].modify(''declare default element namespace 
                "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
                replace value of (/IndividualSurvey/TotalPurchaseYTD)[1] 
                with data(/IndividualSurvey/TotalPurchaseYTD)[1] + sql:column ("inserted.line_total")'') 
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
        SET [demographics].modify(''declare default element namespace 
            "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
            replace value of (/IndividualSurvey/TotalPurchaseYTD)[1] 
            with data(/IndividualSurvey/TotalPurchaseYTD)[1] - sql:column("deleted.line_total")'') 
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
' 
GO
ALTER TABLE [sales].[sales_order_detail] ENABLE TRIGGER [idusales_order_detail]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'sales_order_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. Foreign key to sales_order_header.sales_order_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'sales_order_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'sales_order_detail_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key. One incremental unique number per product sold.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'sales_order_detail_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'carrier_tracking_number'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shipment tracking number supplied by the shipper.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'carrier_tracking_number'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'order_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'quantity ordered per product.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'order_qty'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product sold to customer. Foreign key to product.product_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'special_offer_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Promotional code. Foreign key to special_offer.special_offer_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'special_offer_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'unit_price'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Selling price of a single product.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'unit_price'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'unit_price_discount'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Discount amount.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'unit_price_discount'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'line_total'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Per product subtotal. Computed as unit_price * (1 - unit_price_discount) * order_qty.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'line_total'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'INDEX',N'AK_sales_order_detail_rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index. Used to support replication samples.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'INDEX',@level2name=N'AK_sales_order_detail_rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'INDEX',N'IX_sales_order_detail_product_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'INDEX',@level2name=N'IX_sales_order_detail_product_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Individual products associated with a specific sales order. See sales_order_header.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_order_detail', N'TRIGGER',N'idusales_order_detail'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'AFTER INSERT, DELETE, UPDATE trigger that inserts a row in the transaction_history table, updates modified_date in sales_order_detail and updates the sales_order_header.sub_total column.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_order_detail', @level2type=N'TRIGGER',@level2name=N'idusales_order_detail'
GO
