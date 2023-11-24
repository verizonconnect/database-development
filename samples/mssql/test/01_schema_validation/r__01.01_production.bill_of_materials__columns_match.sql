
CREATE OR ALTER PROCEDURE test_schema_validation.test_bill_of_materials__columns_match
AS
BEGIN
 
    CREATE TABLE [production].[bill_of_materials_tsqlt](
        [bill_of_materials_id] int NOT NULL
       ,[product_assembly_id] int NULL
       ,[component_id] int NOT NULL
       ,[start_date] datetime NOT NULL
       ,[end_date] datetime NULL
       ,[unit_measure_code] nchar(3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
       ,[bom_level] smallint NOT NULL
       ,[per_assembly_qty] decimal(8,2) NOT NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'production.bill_of_materials_tsqlt'
                                      ,@Actual = N'production.bill_of_materials'
                                      ,@Message = N'Column definitions do not match';
END;
GO
