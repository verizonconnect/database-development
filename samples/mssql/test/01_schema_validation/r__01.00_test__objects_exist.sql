-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved.
CREATE OR ALTER PROCEDURE test_schema_validation.test__objects_exist
AS
BEGIN
    CREATE TABLE #expected (
        obj_type    NVARCHAR(60) NOT NULL
       ,sch_nm      SYSNAME      NOT NULL
       ,obj_nm      SYSNAME      NOT NULL
    );

    INSERT INTO #expected (
        obj_type   
       ,sch_nm
       ,obj_nm
    ) VALUES 
     ('DEFAULT_CONSTRAINT','privacy_framework','df_business_justification__created_utc_when')
    ,('DEFAULT_CONSTRAINT','privacy_framework','df_column_data_dictionary__created_utc_when')
    ,('DEFAULT_CONSTRAINT','privacy_framework','df_drp_type__created_utc_when')
    ,('DEFAULT_CONSTRAINT','privacy_framework','df_obfuscation_account_status__created_utc_when')
    ,('DEFAULT_CONSTRAINT','privacy_framework','df_obfuscation_account_table_status__created_utc_when')
    ,('DEFAULT_CONSTRAINT','privacy_framework','df_obfuscation_column_configuration__created_utc_when')
    ,('DEFAULT_CONSTRAINT','privacy_framework','df_obfuscation_subject_status__created_utc_when')
    ,('DEFAULT_CONSTRAINT','privacy_framework','df_obfuscation_subject_table_status__created_utc_when')
    ,('DEFAULT_CONSTRAINT','privacy_framework','df_subject_data_type__created_utc_when')
    ,('DEFAULT_CONSTRAINT','privacy_framework','df_subject_type__created_utc_when')
    ,('DEFAULT_CONSTRAINT','privacy_framework','df_table_configuration__created_utc_when')
    ,('DEFAULT_CONSTRAINT','privacy_framework','df_table_data_dictionary__created_utc_when')
    ,('FOREIGN_KEY_CONSTRAINT','privacy_framework','fk_column_data_dictionary__subject_data_type')
    ,('FOREIGN_KEY_CONSTRAINT','privacy_framework','fk_column_data_dictionary__subject_type')
    ,('FOREIGN_KEY_CONSTRAINT','privacy_framework','fk_column_data_dictionary__table_data_dictionary')
    ,('FOREIGN_KEY_CONSTRAINT','privacy_framework','fk_obfuscation_account_status__status_id')
    ,('FOREIGN_KEY_CONSTRAINT','privacy_framework','fk_obfuscation_account_table_status__status_id')
    ,('FOREIGN_KEY_CONSTRAINT','privacy_framework','fk_obfuscation_column_configuration__column_data_dictionary')
    ,('FOREIGN_KEY_CONSTRAINT','privacy_framework','fk_obfuscation_column_configuration__obfuscation_method')
    ,('FOREIGN_KEY_CONSTRAINT','privacy_framework','fk_obfuscation_column_configuration__table_configuration')
    ,('FOREIGN_KEY_CONSTRAINT','privacy_framework','fk_obfuscation_subject_status__status_id')
    ,('FOREIGN_KEY_CONSTRAINT','privacy_framework','fk_obfuscation_subject_table_status__status_id')
    ,('FOREIGN_KEY_CONSTRAINT','privacy_framework','fk_table_configuration__table_data_dictionary')
    ,('FOREIGN_KEY_CONSTRAINT','privacy_framework','fk_table_data_dictionary__business_justification')
    ,('FOREIGN_KEY_CONSTRAINT','privacy_framework','fk_table_data_dictionary__drp_type')
    ,('PRIMARY_KEY_CONSTRAINT','privacy_framework','pk_business_justification')
    ,('PRIMARY_KEY_CONSTRAINT','privacy_framework','pk_column_data_dictionary')
    ,('PRIMARY_KEY_CONSTRAINT','privacy_framework','pk_drp_type')
    ,('PRIMARY_KEY_CONSTRAINT','privacy_framework','pk_obfuscation_account_status')
    ,('PRIMARY_KEY_CONSTRAINT','privacy_framework','pk_obfuscation_account_table_status')
    ,('PRIMARY_KEY_CONSTRAINT','privacy_framework','pk_obfuscation_column_configuration')
    ,('PRIMARY_KEY_CONSTRAINT','privacy_framework','pk_obfuscation_log')
    ,('PRIMARY_KEY_CONSTRAINT','privacy_framework','pk_obfuscation_method')
    ,('PRIMARY_KEY_CONSTRAINT','privacy_framework','pk_obfuscation_status')
    ,('PRIMARY_KEY_CONSTRAINT','privacy_framework','pk_obfuscation_subject_status')
    ,('PRIMARY_KEY_CONSTRAINT','privacy_framework','pk_obfuscation_subject_table_status')
    ,('PRIMARY_KEY_CONSTRAINT','privacy_framework','pk_subject_data_type')
    ,('PRIMARY_KEY_CONSTRAINT','privacy_framework','pk_subject_type')
    ,('PRIMARY_KEY_CONSTRAINT','privacy_framework','pk_table_configuration')
    ,('PRIMARY_KEY_CONSTRAINT','privacy_framework','pk_table_data_dictionary')
    ,('SQL_STORED_PROCEDURE','privacy_framework','add_obfuscation_log')
    ,('SQL_STORED_PROCEDURE','privacy_framework','drop_old_backup_tables')
    ,('SQL_STORED_PROCEDURE','privacy_framework','extract_subject')
    ,('SQL_STORED_PROCEDURE','privacy_framework','extract_subject_error')
    ,('SQL_STORED_PROCEDURE','privacy_framework','get_backup_sql')
    ,('SQL_STORED_PROCEDURE','privacy_framework','get_obfuscation_sql')
    ,('SQL_STORED_PROCEDURE','privacy_framework','get_subject_backup_sql')
    ,('SQL_STORED_PROCEDURE','privacy_framework','get_subject_extraction_sql')
    ,('SQL_STORED_PROCEDURE','privacy_framework','get_subject_obfuscation_sql')
    ,('SQL_STORED_PROCEDURE','privacy_framework','obfuscate_account')
    ,('SQL_STORED_PROCEDURE','privacy_framework','obfuscate_account_error')
    ,('SQL_STORED_PROCEDURE','privacy_framework','obfuscate_main_error')
    ,('SQL_STORED_PROCEDURE','privacy_framework','obfuscate_subject')
    ,('SQL_STORED_PROCEDURE','privacy_framework','obfuscate_subject_error')
    ,('SQL_STORED_PROCEDURE','privacy_framework','set_obfuscation_account_status')
    ,('SQL_STORED_PROCEDURE','privacy_framework','set_obfuscation_account_table_status')
    ,('SQL_STORED_PROCEDURE','privacy_framework','set_obfuscation_subject_status')
    ,('SQL_STORED_PROCEDURE','privacy_framework','set_obfuscation_subject_table_status')
    ,('SQL_STORED_PROCEDURE','privacy_framework','search_subject')
    ,('USER_TABLE','privacy_framework','business_justification')
    ,('USER_TABLE','privacy_framework','column_data_dictionary')
    ,('USER_TABLE','privacy_framework','drp_type')
    ,('USER_TABLE','privacy_framework','obfuscation_account_status')
    ,('USER_TABLE','privacy_framework','obfuscation_account_table_status')
    ,('USER_TABLE','privacy_framework','obfuscation_column_configuration')
    ,('USER_TABLE','privacy_framework','obfuscation_log')
    ,('USER_TABLE','privacy_framework','obfuscation_method')
    ,('USER_TABLE','privacy_framework','obfuscation_status')
    ,('USER_TABLE','privacy_framework','obfuscation_subject_status')
    ,('USER_TABLE','privacy_framework','obfuscation_subject_table_status')
    ,('USER_TABLE','privacy_framework','subject_data_type')
    ,('USER_TABLE','privacy_framework','subject_type')
    ,('USER_TABLE','privacy_framework','table_configuration')
    ,('USER_TABLE','privacy_framework','table_data_dictionary');

    INSERT INTO #expected (
        obj_type   
       ,sch_nm
       ,obj_nm
    ) VALUES 
     ('USER_TABLE','privacy_framework','partition_drp_configuration')
    ,('USER_TABLE','privacy_framework','dml_retention_configuration')
    ,('USER_TABLE','privacy_framework','dml_drp_condition')
    ,('USER_TABLE','privacy_framework','dml_hierarchy_configuration')
    ,('USER_TABLE','privacy_framework','dml_processing_order')
    ,('PRIMARY_KEY_CONSTRAINT','privacy_framework','pk_partition_drp_configuration')
    ,('PRIMARY_KEY_CONSTRAINT','privacy_framework','pk_dml_drp_condition')
    ,('PRIMARY_KEY_CONSTRAINT','privacy_framework','pk_dml_retention_configuration')
    ,('PRIMARY_KEY_CONSTRAINT','privacy_framework','pk_dml_processing_order')
    ,('DEFAULT_CONSTRAINT','privacy_framework','df_dml_drp_condition__created_utc_when')
    ,('DEFAULT_CONSTRAINT','privacy_framework','df_dml_hierarchy_configuration__created_utc_when')
    ,('DEFAULT_CONSTRAINT','privacy_framework','df_dml_retention_configuration__created_utc_when')
    ,('DEFAULT_CONSTRAINT','privacy_framework','df_dml_retention_configuration__days_to_process')
    ,('DEFAULT_CONSTRAINT','privacy_framework','df_partition_drp_configuration__created_utc_when')
    ,('DEFAULT_CONSTRAINT','privacy_framework','df_partition_drp_configuration__drop_staging_table_indicator')
    ,('DEFAULT_CONSTRAINT','privacy_framework','df_partition_drp_configuration__drop_index_indicator')
    ,('CHECK_CONSTRAINT','privacy_framework','ck_dml_retention_configuration__retention_period_type')
    ,('CHECK_CONSTRAINT','privacy_framework','ck_partition_drp_configuration__cycle_period_type')
    ,('FOREIGN_KEY_CONSTRAINT','privacy_framework','fk_dml_drp_condition__dml_retention_configuration')
    ,('FOREIGN_KEY_CONSTRAINT','privacy_framework','fk_dml_retention_configuration__table_data_dictionary')
    ,('FOREIGN_KEY_CONSTRAINT','privacy_framework','fk_dml_hierarchy_configuration__dml_retention_configuration_parent')
    ,('FOREIGN_KEY_CONSTRAINT','privacy_framework','fk_dml_hierarchy_configuration__dml_retention_configuration_child')
    ,('SQL_STORED_PROCEDURE','privacy_framework','get_catalogue__table_level')
    ,('SQL_STORED_PROCEDURE','privacy_framework','get_catalogue__column_level');

    CREATE TABLE #actual (
        obj_type    NVARCHAR(60) NOT NULL
       ,sch_nm      SYSNAME      NOT NULL
       ,obj_nm      SYSNAME      NOT NULL
    );
    
    DECLARE @exclude_schema TABLE (
        schema_id INT NOT NULL
    );

    INSERT INTO @exclude_schema (
        schema_id
    ) VALUES (ISNULL(SCHEMA_ID('tsqlt'), -1))
            ,(ISNULL(SCHEMA_ID('sys'), -1))
            ,(ISNULL(SCHEMA_ID('flyway'), -1))
            ,(ISNULL(SCHEMA_ID('flyway_test'), -1));
    
    INSERT INTO #actual(
        obj_type
       ,sch_nm
       ,obj_nm
    )
    SELECT  o.type_desc 
           ,SCHEMA_NAME(o.schema_id)
           ,o.name
    FROM    sys.objects AS o
    WHERE   1 = 1
            AND NOT EXISTS (SELECT 1 FROM @exclude_schema AS e
                            WHERE   e.schema_id = o.schema_id)
            AND SCHEMA_NAME(o.schema_id) NOT LIKE 'test_%'
            AND o.type_desc IN ('CLR_STORED_PROCEDURE'
                               ,'VIEW'
                               ,'SQL_TABLE_VALUED_FUNCTION'
                               ,'DEFAULT_CONSTRAINT'
                               ,'SQL_STORED_PROCEDURE'
                               ,'CLR_TABLE_VALUED_FUNCTION'
                               ,'FOREIGN_KEY_CONSTRAINT'
                               ,'SQL_INLINE_TABLE_VALUED_FUNCTION'
                               ,'UNIQUE_CONSTRAINT'
                               ,'CHECK_CONSTRAINT'
                               ,'USER_TABLE'
                               ,'PRIMARY_KEY_CONSTRAINT'
                               ,'TYPE_TABLE'
                               ,'SQL_TRIGGER'
                               ,'SQL_SCALAR_FUNCTION'
                               ,'SEQUENCE_OBJECT');
                               
    EXEC tSQLt.AssertEqualsTable @Expected = N'#expected'
                                ,@Actual = N'#actual'
                                ,@Message = N'System objects not as expected';

END
GO
