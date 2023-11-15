-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_schema_validation.test_partition_drp_configuration__columns_match
AS
BEGIN
 
    CREATE TABLE [privacy_framework].[partition_drp_configuration_tsqlt](
        partition_object_name            sysname      NOT NULL
       ,cycle_period_type                CHAR(2)      NOT NULL
       ,cycle_retention_value            SMALLINT     NOT NULL
       ,cycle_future_count               SMALLINT     NOT NULL
       ,drop_staging_table_indicator     BIT          NOT NULL
       ,drop_index_indicator             BIT          NOT NULL
       ,cycle_filegroup_rotation_count   INT          NOT NULL
       ,created_utc_when                 DATETIME2(3) NOT NULL
       ,modified_utc_when                DATETIME2(3)     NULL
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'privacy_framework.partition_drp_configuration_tsqlt'
                                      ,@Actual = N'privacy_framework.partition_drp_configuration'
                                      ,@Message = N'Column definitions do not match';
END;
GO
