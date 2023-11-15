-- Copyright 2023. Verizon Connect Ireland Limited. All rights reserved.
CREATE OR ALTER PROCEDURE privacy_framework.get_catalogue__table_level
AS
BEGIN
    SET NOCOUNT ON;

    WITH dml_duration AS (
        SELECT  drc.sch_nm
               ,drc.tbl_nm
               ,CAST(drc.retention_period_value AS VARCHAR(10)) +
                CASE WHEN drc.retention_period_type = 'DD' THEN ' Days'
                     WHEN drc.retention_period_type = 'YY' THEN ' Years'
                     ELSE ' Months'
                END AS drp_duration
        FROM    privacy_framework.dml_retention_configuration AS drc
    ), parition_duration AS (
        SELECT  OBJECT_SCHEMA_NAME(i.object_id) AS sch_nm
               ,OBJECT_NAME(i.object_id) AS tbl_nm
               ,CAST(pdc.cycle_retention_value AS VARCHAR(10)) +
                CASE WHEN pdc.cycle_period_type = 'DD' THEN ' Days'
                     WHEN pdc.cycle_period_type = 'YY' THEN ' Years'
                     ELSE ' Months'
                END AS drp_duration
        FROM    sys.indexes AS i
                INNER JOIN sys.partition_schemes AS ps ON ps.data_space_id = i.data_space_id
                INNER JOIN sys.partition_functions AS pf ON pf.function_id = ps.function_id
                INNER JOIN privacy_framework.partition_drp_configuration AS pdc ON pdc.partition_object_name = pf.name
        GROUP BY OBJECT_SCHEMA_NAME(i.object_id)
                ,OBJECT_NAME(i.object_id)
                ,CAST(pdc.cycle_retention_value AS VARCHAR(10)) + CASE
                WHEN pdc.cycle_period_type = 'DD' THEN ' Days'
                WHEN pdc.cycle_period_type = 'YY' THEN ' Years'
                ELSE ' Months'
                END
    ), non_drp AS (
        SELECT  tdd.sch_nm
               ,tdd.tbl_nm
               ,CASE WHEN tdd.drp_type_desc LIKE '%00' THEN 'Self-Cleaning'
                     WHEN tdd.drp_type_desc LIKE '%99' THEN 'Master Data'
                     WHEN tdd.drp_type_desc = 'RDT33'  THEN 'MIS Data Movement'
                     ELSE 'ERROR - DRP NOT CONFIGURED'
                END AS drp_duration
        FROM    privacy_framework.table_data_dictionary AS tdd
    ), duration AS (
        SELECT  tdd.sch_nm
               ,tdd.tbl_nm
               ,COALESCE(dd.drp_duration, pd.drp_duration, nd.drp_duration) AS drp_duration
        FROM    privacy_framework.table_data_dictionary AS tdd
                LEFT JOIN dml_duration AS dd ON dd.sch_nm = tdd.sch_nm
                        AND dd.tbl_nm = tdd.tbl_nm
                LEFT JOIN parition_duration AS pd ON pd.sch_nm = tdd.sch_nm
                        AND pd.tbl_nm = tdd.tbl_nm
                LEFT JOIN non_drp AS nd ON nd.sch_nm = tdd.sch_nm
                        AND nd.tbl_nm = tdd.tbl_nm
    )
    SELECT  LOWER(DB_NAME(DB_ID()) + '.'+ SCHEMA_NAME(t.schema_id) + '.' +  t.name) AS [key]
           ,bj.business_justification_desc AS [Business Justification]
           ,tdd.drp_type_desc AS [DRP Type]
           ,CASE WHEN tdd.drp_type_desc LIKE '%99'
                 THEN 'No'
                 WHEN tdd.drp_type_desc IS NULL
                 THEN NULL
                 ELSE 'Yes'
            END AS [Transactional]
           ,d.drp_duration AS [DRP Duration]
    FROM    sys.tables AS t
            LEFT JOIN privacy_framework.table_data_dictionary AS tdd ON tdd.sch_nm = SCHEMA_NAME(t.schema_id)
                    AND tdd.tbl_nm = t.name
            LEFT JOIN privacy_framework.business_justification AS bj ON bj.business_justification_id = tdd.business_justification_id
            LEFT JOIN duration AS d ON d.sch_nm = tdd.sch_nm
                    AND d.tbl_nm = tdd.tbl_nm
    WHERE   t.schema_id <> SCHEMA_ID('privacy_framework') --No need to inlcude the privacy framework
            AND t.name NOT IN ('flyway_schema_history'
                              ,'DBVersion'
                              ,'sysdiagrams'
                              ,'DDL_Log'
                              ,'tbl_DDL_Log'
                              ,'__RefactorLog') --No need to include these tables

END;
GO
