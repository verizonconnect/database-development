/* Copyright 2022. Verizon Connect Ireland Limited. All rights reserved. */
CREATE OR ALTER PROCEDURE [privacy_framework].[extract_subject_error]
(	@account_id INT,
    @subject_type_id INT,
    @subject_id INT,
    @schema_name sysname,
    @table_name sysname,
    @column_name sysname,
    @sqlerrm NVARCHAR(4000)
)
AS
BEGIN
	SET NOCOUNT ON;
    --return
    DECLARE @return_value INT = -1;
  
    THROW 50000, @sqlerrm, 1;
    
    RETURN @return_value;      
END;
GO
