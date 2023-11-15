-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_backup_schemata_created
AS
BEGIN
 
    SELECT cast(substring(schema_name, 26, len(schema_name)-25) as sysname) as sch_nm 
    INTO #actual_backup_schemata
    FROM information_schema.schemata
    WHERE schema_name LIKE 'privacy_framework_backup_%';

    SELECT distinct tc.sch_nm
    INTO #expected_backup_schemata
    FROM privacy_framework.table_configuration tc
    INNER JOIN privacy_framework.obfuscation_column_configuration cc
            ON tc.sch_nm = cc.sch_nm AND tc.tbl_nm = cc.tbl_nm
                
    EXEC tSQLt.AssertEqualsTable @Expected = N'#expected_backup_schemata'
                                ,@Actual = N'#actual_backup_schemata'
                                ,@Message = N'Every schema with a table for obfuscation must have a backup schema created (privacy_framework_backup_*)';
    
END;
GO
