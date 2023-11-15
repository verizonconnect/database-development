-- Copyright (c) 2020-2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('privacy_framework.obfuscation_column_configuration', 'U') IS NULL
    BEGIN
        CREATE TABLE privacy_framework.obfuscation_column_configuration (
            sch_nm                              SYSNAME      NOT NULL
           ,tbl_nm                              SYSNAME      NOT NULL
           ,col_nm                              SYSNAME      NOT NULL
           ,obfuscation_method_id               INT          NOT NULL
           ,obfuscated_subject_level_indicator  BIT          NOT NULL
           ,created_utc_when                    DATETIME2(3) NOT NULL
           ,modified_utc_when                   DATETIME2(3)     NULL  
        ) ON FRAMEWORK_UNPART
        WITH (DATA_COMPRESSION = PAGE);
    END
GO