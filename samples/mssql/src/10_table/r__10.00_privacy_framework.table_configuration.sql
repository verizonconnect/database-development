-- Copyright (c) 2020-2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('privacy_framework.table_configuration') IS NULL
    CREATE TABLE privacy_framework.table_configuration (
        sch_nm                          SYSNAME       NOT NULL
       ,tbl_nm                          SYSNAME       NOT NULL
       ,batch_size                      INT           NOT NULL  -- This is just for SQL SERVER
       ,where_clause_column_name        NVARCHAR(128) NOT NULL
       ,obfuscated_by_fk_indicator      BIT           NOT NULL  --?This is just for SQL SERVER
       ,modified_date_column_name       NVARCHAR(128) NOT NULL  -- Is NOT NULL for SQL Server
       ,is_obfuscated_column_name       NVARCHAR(128) NOT NULL  -- Is NOT NULL for SQL Server
       ,created_utc_when                DATETIME2(3)  NOT NULL
       ,modified_utc_when               DATETIME2(3)      NULL
    ) ON FRAMEWORK_UNPART
    WITH (DATA_COMPRESSION = PAGE);
GO

IF COLUMNPROPERTY(OBJECT_ID('privacy_framework.table_configuration'), 'where_clause_column_name', 'ColumnId') IS NOT NULL
    EXEC sp_rename 'privacy_framework.table_configuration.where_clause_column_name', 'account_id_column_name', 'COLUMN';
    
IF COLUMNPROPERTY(OBJECT_ID('privacy_framework.table_configuration'), 'modified_date_column_name', 'ColumnId') IS NOT NULL
    EXEC sp_rename 'privacy_framework.table_configuration.modified_date_column_name', 'modified_utc_when_column_name', 'COLUMN';
    
IF COLUMNPROPERTY(OBJECT_ID('privacy_framework.table_configuration'), 'is_obfuscated_column_name', 'ColumnId') IS NOT NULL
    EXEC sp_rename 'privacy_framework.table_configuration.is_obfuscated_column_name', 'obfuscated_ind_column_name', 'COLUMN';
    
IF COLUMNPROPERTY(OBJECT_ID('privacy_framework.table_configuration'), 'subject_id_column_name', 'ColumnId') IS NULL
    ALTER TABLE privacy_framework.table_configuration
    ADD subject_id_column_name SYSNAME NULL;
GO

IF COLUMNPROPERTY(OBJECT_ID('privacy_framework.table_configuration'), 'obfuscated_by_fk_indicator', 'ColumnId') IS NOT NULL
    ALTER TABLE privacy_framework.table_configuration
    DROP COLUMN obfuscated_by_fk_indicator;
GO
