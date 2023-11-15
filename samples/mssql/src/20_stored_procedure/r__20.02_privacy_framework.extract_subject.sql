/* Copyright 2022. Verizon Connect Ireland Limited. All rights reserved. */
CREATE OR ALTER PROCEDURE [privacy_framework].[extract_subject]
(	@account_id INT,
	@subject_type_id INT,
	@subject_id INT
)
AS
BEGIN

	SET NOCOUNT ON;
    DECLARE @Error_Message NVARCHAR(4000);
    DECLARE @Error_Number INT;
   	DECLARE @THROW_ERROR_MESSAGE NVARCHAR(2048);

    DECLARE @return_value INT = -1;

	DECLARE @loop_schema_name sysname;
	DECLARE @loop_table_name sysname;
	DECLARE @loop_column_name sysname;

	DECLARE @sql_extraction NVARCHAR(MAX);


	--Create the temp table which will be populated with the extracted data before being selected at the end
	CREATE TABLE #tmp_resultset 
	(
		col_nm              NVARCHAR(128)    NOT NULL,
		col_value           NVARCHAR(MAX)        NULL,
		subject_data_type   VARCHAR(100)    NOT NULL,
		translation_key     VARCHAR(100)    NOT NULL
	);

	-- Loop through the columns with data for the subject type to extract the data
	DECLARE Obfuscation_Column CURSOR FOR
	SELECT	cdd.sch_nm,
			cdd.tbl_nm,
			cdd.col_nm
	FROM    privacy_framework.column_data_dictionary AS cdd 
	INNER JOIN privacy_framework.table_configuration AS tc 
			ON cdd.sch_nm = tc.sch_nm AND cdd.tbl_nm = tc.tbl_nm AND cdd.subject_type_id = @subject_type_id
	WHERE   cdd.subject_type_id = @subject_type_id 
	AND		tc.subject_id_column_name IS NOT NULL --Only extract for tables with a subject id column defined (checked in unit test for subject data)
	ORDER BY cdd.sch_nm,
			cdd.tbl_nm,
			cdd.col_nm
	OPEN Obfuscation_Column;
	FETCH NEXT FROM Obfuscation_Column INTO @loop_schema_name, @loop_table_name, @loop_column_name;
	WHILE (@@fetch_Status = 0)
		BEGIN
		-- Get the details to build the insert SQL
		BEGIN TRY
			EXEC @return_value = [privacy_framework].[get_subject_extraction_sql] @temp_table_name = '#tmp_resultset', @subject_type_id = @subject_type_id, 
							@schema_name = @loop_schema_name, @table_name = @loop_table_name, @column_name = @loop_column_name, @sql_extraction = @sql_extraction OUTPUT;
		END TRY
		BEGIN CATCH
		    SELECT @Error_Number = ERROR_NUMBER();
            SELECT @Error_Message = ERROR_MESSAGE();
            SELECT @THROW_ERROR_MESSAGE = 'Error generating extract SQL: ' + ' ERROR ' + ISNULL(CONVERT(VARCHAR(20), @Error_Number), '') + ': ' + ISNULL(@Error_Message, '');
            EXEC @return_value = privacy_framework.extract_subject_error @account_id = @account_id, @subject_type_id = @subject_type_id, @subject_id = @subject_id, 
                                                        @schema_name = @loop_schema_name, @table_name = @loop_table_name, @column_name = @loop_column_name, @sqlerrm = @THROW_ERROR_MESSAGE;
            RETURN @return_value;
		END CATCH;

		-- Insert into the temp table
		BEGIN TRY
			EXECUTE SP_executesql @sql_extraction, N'@account_id int, @subject_id int', @account_id, @subject_id;
		END TRY
		BEGIN CATCH
		    SELECT @Error_Number = ERROR_NUMBER();
            SELECT @Error_Message = ERROR_MESSAGE();
            SELECT @THROW_ERROR_MESSAGE = 'Error running extract SQL: ' + ' ERROR ' + ISNULL(CONVERT(VARCHAR(20), @Error_Number), '') + ': ' + ISNULL(@Error_Message, '');
            EXEC @return_value = privacy_framework.extract_subject_error @account_id = @account_id, @subject_type_id = @subject_type_id, @subject_id = @subject_id, 
                                                        @schema_name = @loop_schema_name, @table_name = @loop_table_name, @column_name = @loop_column_name, @sqlerrm = @THROW_ERROR_MESSAGE;
            RETURN @return_value;
		END CATCH;
		FETCH NEXT FROM Obfuscation_Column INTO @loop_schema_name, @loop_table_name, @loop_column_name;
		END;

	CLOSE Obfuscation_Column;
	DEALLOCATE Obfuscation_Column;

	-- Select the data to return
	SELECT 	col_nm,
			col_value,
			subject_data_type,
			translation_key
	FROM #tmp_resultset;
END;
GO
