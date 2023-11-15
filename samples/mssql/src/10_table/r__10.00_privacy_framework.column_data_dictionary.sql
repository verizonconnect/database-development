-- Copyright (c) 2020-2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('privacy_framework.column_data_dictionary', 'U') IS NULL
    BEGIN
        CREATE TABLE privacy_framework.column_data_dictionary (
            sch_nm                         SYSNAME      NOT NULL
           ,tbl_nm                         SYSNAME      NOT NULL
           ,col_nm                         SYSNAME      NOT NULL
           ,pii_indicator                  BIT          NOT NULL
           ,direct_pii_indicator           BIT          NOT NULL
           ,created_utc_when               DATETIME2(3) NOT NULL
           ,modified_utc_when              DATETIME2(3)     NULL  
        ) ON FRAMEWORK_UNPART
        WITH (DATA_COMPRESSION = PAGE);
    END
GO

IF COLUMNPROPERTY(OBJECT_ID('privacy_framework.column_data_dictionary'), 'subject_data_type_id', 'ColumnId') IS NULL
    ALTER TABLE privacy_framework.column_data_dictionary
    ADD subject_data_type_id SMALLINT NULL;
 
IF COLUMNPROPERTY(OBJECT_ID('privacy_framework.column_data_dictionary'), 'subject_type_id', 'ColumnId') IS NULL
    ALTER TABLE privacy_framework.column_data_dictionary
    ADD subject_type_id SMALLINT NULL; 
GO