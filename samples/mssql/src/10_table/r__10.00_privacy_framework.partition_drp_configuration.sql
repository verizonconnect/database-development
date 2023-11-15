-- Copyright (c) 2023. Verizon Connect Ireland Limited. All rights reserved.
IF OBJECT_ID('[privacy_framework].[partition_drp_configuration]', 'U') IS NULL
BEGIN
    CREATE TABLE [privacy_framework].[partition_drp_configuration](
        partition_object_name            sysname      NOT NULL
       ,cycle_period_type                CHAR(2)      NOT NULL
       ,cycle_retention_value            SMALLINT     NOT NULL
       ,cycle_future_count               SMALLINT     NOT NULL
       ,drop_staging_table_indicator     BIT          NOT NULL
       ,drop_index_indicator             BIT          NOT NULL
       ,cycle_filegroup_rotation_count   INT          NOT NULL
       ,created_utc_when                 DATETIME2(3) NOT NULL
       ,modified_utc_when                DATETIME2(3)     NULL
    ) ON [FRAMEWORK_UNPART];
END;
GO