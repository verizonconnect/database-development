
CREATE OR ALTER PROCEDURE test_schema_validation.test_product__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[product_tsqlt](
        [product_id] int NOT NULL
       ,[name] [common].[name] NOT NULL
       ,[product_number] nvarchar(25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[make_flag] flag NOT NULL
       ,[finished_goods_flag] flag NOT NULL
       ,[colour] nvarchar(15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[safety_stock_level] smallint NOT NULL
       ,[reorder_point] smallint NOT NULL
       ,[standard_cost] money NOT NULL
       ,[list_price] money NOT NULL
       ,[size] nvarchar(5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[size_unit_measure_code] nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[weight_unit_measure_code] nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[weight] decimal(8,2) NULL
       ,[days_to_manufacture] int NOT NULL
       ,[product_line] nchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[class] nchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[style] nchar(2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
       ,[product_sub_category_id] int NULL
       ,[product_model_id] int NULL
       ,[sell_start_date] datetime NOT NULL
       ,[sell_end_date] datetime NULL
       ,[discontinued_date] datetime NULL
       ,[rowguid] uniqueidentifier NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.product_tsqlt'
                                      ,@Actual = N'production.product'
                                      ,@Message = N'Column definitions do not match';
END;
GO
