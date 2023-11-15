-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_role_schemata_permissions
AS
BEGIN

    --Check that the aso role has the correct permissions 
    -- on any schema for obfuscation and also on its backup schema

    --First on the schema
    WITH obfuscate_schema AS
    (SELECT distinct tc.sch_nm
    FROM privacy_framework.table_configuration tc
    INNER JOIN privacy_framework.obfuscation_column_configuration cc
            ON tc.sch_nm = cc.sch_nm AND tc.tbl_nm = cc.tbl_nm),
    role_permissions AS
    (SELECT Perm.permission_name, SCHEMA_NAME(Perm.major_id) AS sch_nm 
            FROM sys.database_permissions AS Perm
            WHERE Perm.grantee_principal_id = DATABASE_PRINCIPAL_ID('db_role_privacy_framework_aso')
            AND Perm.state_desc = 'GRANT'
            AND Perm.class_desc = 'SCHEMA')
    SELECT o.sch_nm
    INTO #schema_permissions
    FROM obfuscate_schema o
    WHERE NOT EXISTS (SELECT 1 FROM role_permissions p WHERE p.sch_nm = o.sch_nm AND p.permission_name = 'DELETE')
    OR NOT EXISTS (SELECT 1 FROM role_permissions p WHERE p.sch_nm = o.sch_nm AND p.permission_name = 'INSERT')
    OR NOT EXISTS (SELECT 1 FROM role_permissions p WHERE p.sch_nm = o.sch_nm AND p.permission_name = 'SELECT')
    OR NOT EXISTS (SELECT 1 FROM role_permissions p WHERE p.sch_nm = o.sch_nm AND p.permission_name = 'UPDATE');

    --Then on the backup schema
    WITH obfuscate_schema AS
    (SELECT distinct 'privacy_framework_backup_' + tc.sch_nm as sch_nm
    FROM privacy_framework.table_configuration tc
    INNER JOIN privacy_framework.obfuscation_column_configuration cc
            ON tc.sch_nm = cc.sch_nm AND tc.tbl_nm = cc.tbl_nm),
    role_permissions AS
    (SELECT Perm.permission_name, SCHEMA_NAME(Perm.major_id) AS sch_nm 
            FROM sys.database_permissions AS Perm
            WHERE Perm.grantee_principal_id = DATABASE_PRINCIPAL_ID('db_role_privacy_framework_aso')
            AND Perm.state_desc = 'GRANT'
            AND Perm.class_desc = 'SCHEMA')
    SELECT o.sch_nm
    INTO #backup_schema_permissions
    FROM obfuscate_schema o
    WHERE NOT EXISTS (SELECT 1 FROM role_permissions p WHERE p.sch_nm = o.sch_nm AND p.permission_name = 'DELETE')
    OR NOT EXISTS (SELECT 1 FROM role_permissions p WHERE p.sch_nm = o.sch_nm AND p.permission_name = 'INSERT')
    OR NOT EXISTS (SELECT 1 FROM role_permissions p WHERE p.sch_nm = o.sch_nm AND p.permission_name = 'SELECT')
    OR NOT EXISTS (SELECT 1 FROM role_permissions p WHERE p.sch_nm = o.sch_nm AND p.permission_name = 'UPDATE')
    OR NOT EXISTS (SELECT 1 FROM role_permissions p WHERE p.sch_nm = o.sch_nm AND p.permission_name = 'ALTER');

    EXEC tsqlt.AssertEmptyTable @TableName = N'#schema_permissions'
                               ,@Message = N'db_role_privacy_framework_aso does not have permissions on all the schemas for obfuscation';

    EXEC tsqlt.AssertEmptyTable @TableName = N'#backup_schema_permissions'
                               ,@Message = N'db_role_privacy_framework_aso does not have permissions on all the schemas for backup';

    
END;
GO
