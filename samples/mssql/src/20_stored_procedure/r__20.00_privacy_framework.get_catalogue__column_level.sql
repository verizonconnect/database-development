-- Copyright 2023. Verizon Connect Ireland Limited. All rights reserved.
CREATE OR ALTER PROCEDURE privacy_framework.get_catalogue__column_level
AS
BEGIN
    SET NOCOUNT ON;

    SELECT LOWER(DB_NAME(DB_ID()) + '.' + SCHEMA_NAME(t.schema_id) + '.' +  t.name + '.' + c.name) AS [key]
           ,c.name AS [column_name]
           ,ic.index_column_id AS [PK Ordinal]
           ,CASE WHEN cdd.pii_indicator = 1 AND cdd.direct_pii_indicator = 1
                 THEN 'Direct PII'
                 WHEN cdd.pii_indicator = 1 AND cdd.direct_pii_indicator = 0
                 THEN 'PII'
                 WHEN cdd.pii_indicator = 0 AND cdd.direct_pii_indicator = 0
                 THEN 'Non PII'
                 ELSE ''
            END AS [Sensitive Data Indicator]
           ,st.subject_type_desc AS [Subject Type]
           ,sdt.subject_data_type_desc AS [Subject Data Type]
    FROM    sys.tables AS t
            INNER JOIN sys.columns AS c ON c.object_id = t.object_id
            LEFT JOIN sys.indexes AS i ON i.object_id = t.object_id
                    AND i.is_primary_key = 1
            LEFT JOIN sys.index_columns AS ic ON ic.index_id = i.index_id
                    AND ic.object_id = t.object_id
                    AND ic.column_id = c.column_id
            LEFT JOIN privacy_framework.table_data_dictionary AS tdd ON tdd.sch_nm = SCHEMA_NAME(t.schema_id)
                    AND tdd.tbl_nm = t.name
            LEFT JOIN privacy_framework.column_data_dictionary AS cdd ON cdd.sch_nm = tdd.sch_nm
                    AND cdd.tbl_nm = tdd.tbl_nm
                    AND cdd.col_nm = c.name
            LEFT JOIN privacy_framework.subject_data_type AS sdt ON sdt.subject_data_type_id = cdd.subject_data_type_id
            LEFT JOIN privacy_framework.subject_type AS st ON st.subject_type_id = cdd.subject_type_id
    WHERE   t.schema_id <> SCHEMA_ID('privacy_framework') --No need to inlcude the privacy framework
            AND t.name NOT IN ('flyway_schema_history'
                              ,'DBVersion'
                              ,'sysdiagrams'
                              ,'DDL_Log'
                              ,'tbl_DDL_Log'
                              ,'__RefactorLog'); --No need to include these tables

END;
GO