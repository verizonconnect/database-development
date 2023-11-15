-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('privacy_framework.obfuscation_account_table_status') IS NULL
    CREATE TABLE privacy_framework.obfuscation_account_table_status (
        account_id              INT           NOT NULL,
        sch_nm                  SYSNAME       NOT NULL,
        tbl_nm                  SYSNAME       NOT NULL,       
        obfuscation_row_count   INT           NOT NULL,
        status_id               SMALLINT      NOT NULL,
        created_utc_when        DATETIME2(3)  NOT NULL,
        modified_utc_when       DATETIME2(3)      NULL
    ) ON FRAMEWORK_UNPART
    WITH (DATA_COMPRESSION = PAGE);
GO