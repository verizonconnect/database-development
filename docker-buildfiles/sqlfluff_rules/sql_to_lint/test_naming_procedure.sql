-- test_procedures.sql

-- This name is VALID
CREATE PROCEDURE dbo.get_object AS
BEGIN
    SELECT 1;
END;
GO

-- This name is INVALID
CREATE PROCEDURE dbo.this_proc_is_invalid AS
BEGIN
    SELECT 1;
END;
GO
