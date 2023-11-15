-- Copyright (c) 2020-2022. Verizon Connect Ireland Limited. All rights reserved. 
IF OBJECT_ID('privacy_framework.table_data_dictionary') IS NULL
    CREATE TABLE privacy_framework.table_data_dictionary (
        sch_nm                      SYSNAME       NOT NULL
       ,tbl_nm                      SYSNAME       NOT NULL
       ,transactional_indicator     BIT           NOT NULL
       ,partitioned_indicator       BIT           NOT NULL
       ,drp_type_desc               VARCHAR(20)   NOT NULL
       ,business_justification_id   TINYINT       NOT NULL
       ,created_utc_when            DATETIME2(3)  NOT NULL
       ,modified_utc_when           DATETIME2(3)      NULL
    ) ON FRAMEWORK_UNPART
    WITH (DATA_COMPRESSION = PAGE);
GO