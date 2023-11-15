/* Copyright 2022. Verizon Connect Ireland Limited. All rights reserved. */
CREATE OR ALTER PROCEDURE [privacy_framework].[drop_old_backup_tables]
(	@days_to_keep INT
)
AS
BEGIN
	SET NOCOUNT ON;
    DECLARE @Error_Message NVARCHAR(4000);
    DECLARE @Error_Number INT;
   	DECLARE @THROW_ERROR_MESSAGE NVARCHAR(2048);


    DECLARE @sql_drop         NVARCHAR(MAX) = '';
    DECLARE @loop_schema_name sysname;
    DECLARE @loop_table_name  sysname;


    -- Backup schema are named: privacy_framework_backup_<schemaname>
    -- Developer needs to create one for each schema with tables to be obfuscated
	DECLARE Schema_Loop CURSOR FOR
        SELECT schema_name
        FROM information_schema.schemata
        WHERE schema_name LIKE 'privacy_framework_backup_%'
        ORDER BY schema_name
	OPEN Schema_Loop;
	FETCH NEXT FROM Schema_Loop INTO @loop_schema_name;
	WHILE (@@fetch_Status = 0)
		BEGIN
        --And now loop through the tables in the schema that end with a date
        DECLARE Table_Loop CURSOR FOR
            SELECT table_name
            FROM information_schema.tables
            WHERE table_schema = @loop_schema_name
                AND isdate(RIGHT(table_name, 8)) = 1
            ORDER BY table_name
        OPEN Table_Loop;
        FETCH NEXT FROM Table_Loop INTO @loop_table_name;
        WHILE (@@fetch_Status = 0)
            BEGIN
            --First check that the date is older than the retention period
            IF (cast(RIGHT(@loop_table_name, 8) as date) < dateadd(day, (0-@days_to_keep), SYSUTCDATETIME()))
            BEGIN TRY
                SELECT @sql_drop = 'DROP TABLE ' + QUOTENAME(@loop_schema_name) + '.' + QUOTENAME(@loop_table_name);
                EXECUTE SP_executesql @sql_drop;
            END TRY        
            BEGIN CATCH
            	SELECT @Error_Number = ERROR_NUMBER();
		        SELECT @Error_Message = ERROR_MESSAGE();
      			SELECT @THROW_ERROR_MESSAGE = 'Error dropping backup tables: ' + @sql_drop + ' ERROR ' + ISNULL(CONVERT(VARCHAR(20), @Error_Number), '') + ': ' + ISNULL(@Error_Message, '');
    			THROW 50000, @THROW_ERROR_MESSAGE, 1;
            END CATCH;            
            FETCH NEXT FROM Table_Loop INTO @loop_table_name;
            END;
            CLOSE Table_Loop;
            DEALLOCATE Table_Loop;    
        FETCH NEXT FROM Schema_Loop INTO @loop_schema_name;
        END;  
    CLOSE Schema_Loop;
    DEALLOCATE Schema_Loop;    
END;
GO
