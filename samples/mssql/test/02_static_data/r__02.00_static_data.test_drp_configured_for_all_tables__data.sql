-- Copyright (c) 2023. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_drp_configured_for_all_tables__data
AS
BEGIN
   
    CREATE TABLE #actual (
        sch_nm          SYSNAME       NOT NULL
       ,tbl_nm          SYSNAME       NOT NULL
       ,drp_type_desc   VARCHAR(20)   NOT NULL
       ,PRIMARY KEY (sch_nm, tbl_nm)
    );

    INSERT INTO #actual (
        sch_nm
       ,tbl_nm
       ,drp_type_desc
    )   
    SELECT  t.sch_nm
           ,t.tbl_nm
           ,t.drp_type_desc
    FROM    privacy_framework.table_data_dictionary AS t
            INNER JOIN privacy_framework.drp_type AS dt ON dt.drp_type_desc = t.drp_type_desc
    WHERE   dt.requires_drp_indicator = 1;

    DELETE  a
    FROM    #actual AS a
            INNER JOIN privacy_framework.dml_retention_configuration AS dml ON dml.sch_nm = a.sch_nm
                    AND dml.tbl_nm = a.tbl_nm;          

    WITH CTE AS (
        SELECT  OBJECT_SCHEMA_NAME(i.object_id) AS sch_nm
               ,OBJECT_NAME(i.object_id) AS tbl_nm
               ,pf.name AS partition_function
        FROM    sys.indexes AS i
                INNER JOIN sys.partition_schemes AS ps ON ps.data_space_id = i.data_space_id
                INNER JOIN sys.partition_functions AS pf ON pf.function_id = ps.function_id
        GROUP BY OBJECT_SCHEMA_NAME(i.object_id)
                ,OBJECT_NAME(i.object_id)
                ,pf.name    
    )
    DELETE  a
    FROM    #actual AS a            
            INNER JOIN cte AS c ON c.sch_nm = a.sch_nm
                    AND c.tbl_nm = a.tbl_nm
            INNER JOIN privacy_framework.partition_drp_configuration AS pdc ON pdc.partition_object_name = c.partition_function;
 
    EXEC tSQLt.AssertEmptyTable  @TableName  = N'#actual'
                                ,@Message = N'missing drp configuration on tables';
END;
GO