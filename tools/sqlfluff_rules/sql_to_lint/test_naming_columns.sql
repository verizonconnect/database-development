-- test_naming_columns.sql

-- This is the standard T-SQL way to check if a table exists
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'tbl_new')
BEGIN
    CREATE TABLE dbo.tbl_new (
        test_id            INT          NOT NULL,  -- This name is VALID
        invalid_class      DATETIME2(3) NOT NULL,  -- This name is INVALID -_class not permitted
        Invalid_when       DATETIME2(3) NOT NULL   -- This name is INVALID - Upper case I
    );
END;
GO
