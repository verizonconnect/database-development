/* Copyright 2022. Verizon Connect Ireland Limited. All rights reserved. */
IF DATABASE_PRINCIPAL_ID('role_privacy_framework_aso') IS NOT NULL
    BEGIN
    ALTER ROLE role_privacy_framework_aso WITH NAME = db_role_privacy_framework_aso;
    EXEC sp_updateextendedproperty @name=N'DB Privacy Framework ASO Role', @value=N'Role for Privacy Framework ASO' , @level0type=N'USER',@level0name=N'db_role_privacy_framework_aso';
    END;

IF DATABASE_PRINCIPAL_ID('db_role_privacy_framework_aso') IS NULL
    BEGIN
    CREATE ROLE db_role_privacy_framework_aso
    EXEC sys.sp_addextendedproperty @name=N'DB Privacy Framework ASO Role', @value=N'Role for Privacy Framework ASO' , @level0type=N'USER',@level0name=N'db_role_privacy_framework_aso';
    END;

GRANT CREATE TABLE TO db_role_privacy_framework_aso;

--Grant permissions to the role on the SPs
GRANT EXECUTE ON [privacy_framework].[obfuscate_account] TO db_role_privacy_framework_aso;
GRANT EXECUTE ON [privacy_framework].[obfuscate_subject] TO db_role_privacy_framework_aso;
GRANT EXECUTE ON [privacy_framework].[extract_subject] TO db_role_privacy_framework_aso;
--If the CFT creates any additional SPs (e.g. for subject search) then these need to be added to the role here

--If any data is being obfuscated then the following is required on the schema and its backup schema
--GRANT INSERT, UPDATE, SELECT, DELETE ON SCHEMA::<schema_name> TO db_role_privacy_framework_aso;
--GRANT ALTER, INSERT, UPDATE, SELECT, DELETE ON SCHEMA::privacy_framework_backup_<schema_name> TO db_role_privacy_framework_aso;

--If a DDL trigger exists the role may need access to insert to the ddl log
DECLARE @ddl_log VARCHAR(200) = (SELECT  TOP  (1)
                                         CONCAT_WS('.',sed.referenced_schema_name,sed.referenced_entity_name)
                                 FROM    sys.sql_expression_dependencies AS sed
                                         INNER JOIN sys.triggers AS t ON t.object_id = sed.referencing_id
                                 WHERE   sed.referencing_class_desc = 'DATABASE_DDL_TRIGGER'
                                         AND t.parent_class_desc = 'DATABASE'
                                         AND t.is_disabled = 0);
IF @ddl_log IS NOT NULL
    EXEC ('GRANT INSERT ON OBJECT::'+@ddl_log+' TO db_role_privacy_framework_aso;');