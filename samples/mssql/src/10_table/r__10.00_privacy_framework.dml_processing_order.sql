-- Copyright (c) 2023. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('[privacy_framework].[dml_processing_order]', 'U') IS NULL
BEGIN
    CREATE TABLE [privacy_framework].[dml_processing_order](
        sch_nm              sysname      NOT NULL
       ,tbl_nm              sysname      NOT NULL
       ,processing_order    SMALLINT     NOT NULL
       ,created_utc_when    DATETIME2(3) NOT NULL
       ,modified_utc_when   DATETIME2(3)     NULL
    ) ON [FRAMEWORK_UNPART]
    WITH (DATA_COMPRESSION = PAGE);
END;
GO