-- Copyright (c) 2023. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_dml_delete_all_parent_tables_have_condition_defined__data
AS
BEGIN
   
    CREATE TABLE #actual (
        sch_nm          SYSNAME       NOT NULL
       ,tbl_nm          SYSNAME       NOT NULL
       ,PRIMARY KEY (sch_nm, tbl_nm)
    );

    CREATE TABLE #parent_tables (
        sch_nm              sysname NOT NULL
       ,tbl_nm              sysname NOT NULL
    );

    INSERT INTO #parent_tables(
        sch_nm
       ,tbl_nm
    )
    SELECT  drc.sch_nm
           ,drc.tbl_nm
    FROM    privacy_framework.dml_retention_configuration AS drc 
    WHERE  NOT EXISTS(SELECT   1 --Do not want any kids in here. adults only
                      FROM    privacy_framework.dml_hierarchy_configuration AS dhc
                      WHERE   dhc.child_sch_nm = drc.sch_nm
                              AND dhc.child_tbl_nm = drc.tbl_nm);

    INSERT INTO #parent_tables(
        sch_nm
       ,tbl_nm
    )
    SELECT  drc.sch_nm
           ,drc.tbl_nm 
    FROM    privacy_framework.dml_retention_configuration AS drc
    WHERE   NOT EXISTS (SELECT  1 --one ticket only allowed
                        FROM    #parent_tables AS po
                        WHERE   po.sch_nm = drc.sch_nm
                                AND po.tbl_nm = drc.tbl_nm)
            AND NOT EXISTS(SELECT   1 --Do not want any kids in here. adults only
                            FROM    privacy_framework.dml_hierarchy_configuration AS dhc
                            WHERE   dhc.child_sch_nm = drc.sch_nm
                                    AND dhc.child_tbl_nm = drc.tbl_nm)
            AND drc.sch_nm IS NOT NULL;
            
    INSERT INTO #actual(
        sch_nm
       ,tbl_nm
    )
    SELECT  pt.sch_nm
           ,pt.tbl_nm
    FROM    #parent_tables AS pt
            LEFT JOIN privacy_framework.dml_drp_condition AS ddc ON ddc.sch_nm = pt.sch_nm
                    AND ddc.tbl_nm = pt.tbl_nm
    WHERE   ddc.sch_nm IS NULL
 
    EXEC tSQLt.AssertEmptyTable  @TableName  = N'#actual'
                                ,@Message = N'all parent/standalone tables should have a drp condition defined';
END;
GO