-- Copyright (c) 2023. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('[privacy_framework].[dml_hierarchy_configuration]', 'U') IS NULL
BEGIN
    CREATE TABLE [privacy_framework].[dml_hierarchy_configuration](
        parent_sch_nm           sysname      NOT NULL
       ,parent_tbl_nm           sysname      NOT NULL
       ,parent_join_col_nm      sysname      NOT NULL
       ,child_sch_nm            sysname      NOT NULL
       ,child_tbl_nm            sysname      NOT NULL
       ,child_join_col_nm       sysname      NOT NULL
       ,created_utc_when        DATETIME2(3) NOT NULL
       ,modified_utc_when       DATETIME2(3)     NULL
    ) ON [FRAMEWORK_UNPART]
    WITH (DATA_COMPRESSION = PAGE);
END;
GO