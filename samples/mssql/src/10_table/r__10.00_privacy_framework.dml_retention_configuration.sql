-- Copyright (c) 2023. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('[privacy_framework].[dml_retention_configuration]', 'U') IS NULL
BEGIN
    CREATE TABLE [privacy_framework].[dml_retention_configuration](
        sch_nm                  sysname      NOT NULL
       ,tbl_nm                  sysname      NOT NULL
       ,retention_period_type   CHAR(2)      NOT NULL
       ,retention_period_value  SMALLINT     NOT NULL
       ,days_to_process         SMALLINT     NOT NULL
       ,created_utc_when        DATETIME2(3) NOT NULL
       ,modified_utc_when       DATETIME2(3)     NULL
    ) ON [FRAMEWORK_UNPART]
    WITH (DATA_COMPRESSION = PAGE);
END;
GO