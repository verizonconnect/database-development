-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_partition_drp_configuration__data
AS
BEGIN
 
    CREATE TABLE #expected (
        partition_object_name            sysname      NOT NULL
       ,cycle_period_type                CHAR(2)      NOT NULL
       ,cycle_retention_value            SMALLINT     NOT NULL
       ,cycle_future_count               SMALLINT     NOT NULL
       ,drop_staging_table_indicator     BIT          NOT NULL
       ,drop_index_indicator             BIT          NOT NULL
       ,cycle_filegroup_rotation_count   INT          NOT NULL
        PRIMARY KEY (partition_object_name)
    );

    --INSERT INTO #expected (
    --    partition_object_name
    --   ,cycle_period_type
    --   ,cycle_retention_value
    --   ,cycle_future_count
    --   ,drop_staging_table_indicator
    --   ,drop_index_indicator
    --   ,cycle_filegroup_rotation_count
    --) VALUES  
    --    (N'partition_object_name', 'MM', 13, 6, 0, 0, 14);

    SELECT  t.partition_object_name
           ,t.cycle_period_type
           ,t.cycle_retention_value
           ,t.cycle_future_count
           ,t.drop_staging_table_indicator
           ,t.drop_index_indicator
           ,t.cycle_filegroup_rotation_count
    INTO    #actual
    FROM    privacy_framework.partition_drp_configuration AS t;
 
    EXEC tSQLt.AssertEqualsTable @Expected = N'#expected'
                                ,@Actual = N'#actual'
                                ,@Message = N'partition_drp_configuration data not as expected';
END;
GO
