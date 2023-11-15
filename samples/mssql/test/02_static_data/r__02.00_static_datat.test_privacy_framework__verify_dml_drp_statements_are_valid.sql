-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_programmable_object.test_privacy_framework__verify_dml_drp_statements_are_valid
AS
BEGIN

    /*
        Delete this test at your own risk!
        
        The logic in this proc will validate if the metadata for DML DRP 
        will generate valid SQL statements. 
        Trying to ignore it will cause you a world of pain in production.    
    */
    EXEC tSQLt.ExpectNoException;
    
    --First we need to ensure tables impacted are faked
    SELECT  drc.sch_nm + '.' + drc.tbl_nm AS tbl
    INTO    #tbls
    FROM    privacy_framework.dml_retention_configuration AS drc;
    WHILE EXISTS (SELECT 1 FROM #tbls)
    BEGIN
        DECLARE @tbl NVARCHAR(256) = (SELECT TOP(1) tbl FROM #tbls);
        EXEC tsqlt.FakeTable @TableName = @tbl; 
        DELETE FROM #tbls WHERE tbl = @tbl;
    END;

    DROP TABLE IF EXISTS #processing_order; 
    CREATE TABLE #processing_order (
        sch_nm              sysname NOT NULL
       ,tbl_nm              sysname NOT NULL
       ,processing_order    INT     NOT NULL
    );
    
    DECLARE @sql_processing_order NVARCHAR(4000) = N'
    --catch any definite parent config where a processing order is specified
    SELECT  dpo.sch_nm
           ,dpo.tbl_nm
           ,dpo.processing_order
    INTO    #parent_process_order
    FROM    privacy_framework.dml_processing_order AS dpo
            INNER JOIN privacy_framework.dml_retention_configuration AS drc ON drc.sch_nm = dpo.sch_nm
                    AND drc.tbl_nm = dpo.tbl_nm
            AND NOT EXISTS(SELECT   1 --Do not want any kids in here. adults only
                            FROM    privacy_framework.dml_hierarchy_configuration AS dhc
                            WHERE   dhc.child_sch_nm = drc.sch_nm
                                    AND dhc.child_tbl_nm = drc.tbl_nm);

    --catch any definite parent config where a processing order is not specified
    DECLARE @default NVARCHAR(2) = N''*'';

    SELECT  drc.sch_nm
           ,drc.tbl_nm
           ,dpo.processing_order 
    FROM    privacy_framework.dml_retention_configuration AS drc
            FULL OUTER JOIN privacy_framework.dml_processing_order AS dpo ON dpo.sch_nm = @default
                    AND dpo.tbl_nm = @default
    WHERE   NOT EXISTS (SELECT  1 --one ticket only allowed
                        FROM    #parent_process_order AS po
                        WHERE   po.sch_nm = drc.sch_nm
                                AND po.tbl_nm = drc.tbl_nm)
            AND NOT EXISTS(SELECT   1 --Do not want any kids in here. adults only
                            FROM    privacy_framework.dml_hierarchy_configuration AS dhc
                            WHERE   dhc.child_sch_nm = drc.sch_nm
                                    AND dhc.child_tbl_nm = drc.tbl_nm)
            AND drc.sch_nm IS NOT NULL;
            
    SELECT  ppo.sch_nm
           ,ppo.tbl_nm
           ,ppo.processing_order 
    FROM    #parent_process_order AS ppo;';
    
    INSERT INTO #processing_order(
        sch_nm
       ,tbl_nm
       ,processing_order
    )
    EXEC sys.sp_executesql @sql_processing_order;

    --This table will hold all tables to be processed and the order in which they will be handled.
    --This includes all decendats of any parent tables
    DROP TABLE IF EXISTS #all_tables_order;

    CREATE TABLE #all_tables_order (
        order_id INT NOT NULL IDENTITY (1, 1)
       ,sch_nm sysname NOT NULL
       ,tbl_nm sysname NOT NULL
    );

    --The full order table is populated in this WHILE block
    --Nothing too complicated really in this
    WHILE EXISTS (SELECT 1 FROM #processing_order AS po)
    BEGIN

        DECLARE @sch_nm sysname
               ,@tbl_nm sysname;

        SELECT  TOP (1)
                @sch_nm = po.sch_nm
               ,@tbl_nm = po.tbl_nm
        FROM    #processing_order AS po 
        ORDER BY po.processing_order ASC;

        --check for any decendants and add them to the table
        DECLARE @sql_full_order NVARCHAR(2000) = N'
        ;WITH cte AS (
            SELECT  dhc.child_sch_nm
                   ,dhc.child_tbl_nm
                   ,1 AS process_order
            FROM    privacy_framework.dml_hierarchy_configuration AS dhc
            WHERE   dhc.parent_sch_nm = @sch_nm
                    AND dhc.parent_tbl_nm = @tbl_nm
            UNION ALL
            SELECT  dhc.child_sch_nm
                   ,dhc.child_tbl_nm
                   ,c.process_order + 1
            FROM    cte AS c
                    INNER JOIN privacy_framework.dml_hierarchy_configuration AS dhc ON dhc.parent_sch_nm = c.child_sch_nm
                            AND dhc.parent_tbl_nm = c.child_tbl_nm
        ), cte_group AS (
            SELECT  c.child_sch_nm
                   ,c.child_tbl_nm
                   ,MIN(c.process_order) AS process_order
            FROM    cte AS c
            GROUP BY c.child_sch_nm
                    ,c.child_tbl_nm
        ) 
        SELECT  c.child_sch_nm
               ,c.child_tbl_nm
        FROM    cte_group AS c
        ORDER BY c.process_order DESC;';

        DECLARE @params_full_order NVARCHAR(200) = N'
        @sch_nm sysname
       ,@tbl_nm sysname';

        INSERT INTO #all_tables_order(
            sch_nm
           ,tbl_nm
        )
        EXEC sys.sp_executesql @sql_full_order
                              ,@params_full_order
                              ,@sch_nm
                              ,@tbl_nm;

        --add the parent
        INSERT INTO #all_tables_order(
            sch_nm
           ,tbl_nm
        )
        VALUES(
            @sch_nm
           ,@tbl_nm
        );

        DELETE  po 
        FROM    #processing_order AS po
        WHERE   po.sch_nm = @sch_nm
                AND po.tbl_nm = @tbl_nm;

    END --at this point we have the full list of tables to be processed and the order defined

    -- Here we are building up the DML statements for each table in the order that they 
    -- are required to be processed
    -- The first check is to identify if a table is a parent or a child as the treatment 
    -- differs for both.
    -- It can be a be complicated building up the nested joins for multi-level hierarchies 
    -- which may have multiple join predicates.
    WHILE EXISTS (SELECT 1 FROM #all_tables_order AS fo)
    BEGIN
        DECLARE @processing_sch_nm sysname
               ,@processing_tbl_nm sysname;  

        SELECT  TOP (1)
                @processing_sch_nm = fo.sch_nm
               ,@processing_tbl_nm = fo.tbl_nm
        FROM    #all_tables_order AS fo 
        ORDER BY fo.order_id ASC;

        DECLARE @drp_command NVARCHAR(MAX) = N'';

        DECLARE @sql_build_drp NVARCHAR(MAX)=N'
        DECLARE @str_drp NVARCHAR(MAX) = N'''';
        DECLARE @parse   NVARCHAR(MAX) = N'''';

        IF EXISTS (SELECT   1
                   FROM     privacy_framework.dml_hierarchy_configuration AS dhc
                   WHERE    dhc.child_sch_nm = @processing_sch_nm
                            AND dhc.child_tbl_nm = @processing_tbl_nm)
        BEGIN 

           ;WITH cte (parent_sch_nm, parent_tbl_nm, child_sch_nm, child_tbl_nm, lvl) AS (
                SELECT  dhc.parent_sch_nm
                       ,dhc.parent_tbl_nm
                       ,dhc.child_sch_nm
                       ,dhc.child_tbl_nm
                       ,0 AS lvl
                FROM    privacy_framework.dml_hierarchy_configuration AS dhc
                WHERE   dhc.child_sch_nm = @processing_sch_nm
                        AND dhc.child_tbl_nm = @processing_tbl_nm
                UNION ALL
                SELECT  dhc.parent_sch_nm
                       ,dhc.parent_tbl_nm
                       ,dhc.child_sch_nm
                       ,dhc.child_tbl_nm
                       ,c.lvl + 1
                FROM    cte AS c
                        INNER JOIN privacy_framework.dml_hierarchy_configuration AS dhc ON dhc.child_sch_nm = c.parent_sch_nm
                                AND dhc.child_tbl_nm = c.parent_tbl_nm
            ), parent AS (
                SELECT  TOP (1)
                        c.parent_sch_nm
                       ,c.parent_tbl_nm
                FROM    cte AS c
                ORDER BY c.lvl DESC
            )
            SELECT  @str_drp += ''DECLARE @min_date DATETIME2(3) = (
                    SELECT MIN('' + ddc.drp_condition + '')
                    FROM   '' + QUOTENAME(ddc.sch_nm) + ''.'' + QUOTENAME(ddc.tbl_nm) + '' AS '' + QUOTENAME(ddc.tbl_nm) + '')''
            FROM    privacy_framework.dml_drp_condition AS ddc
                    INNER JOIN parent AS p ON p.parent_sch_nm = ddc.sch_nm
                            AND p.parent_tbl_nm = ddc.tbl_nm;


            ;WITH cte AS (
                SELECT  dhc.child_tbl_nm
                       ,dhc.child_sch_nm
                FROM    privacy_framework.dml_hierarchy_configuration AS dhc
                WHERE   dhc.child_sch_nm = @processing_sch_nm
                        AND dhc.child_tbl_nm = @processing_tbl_nm 
                GROUP BY dhc.child_tbl_nm
                        ,dhc.child_sch_nm
            )
            SELECT  @str_drp += ''DELETE '' + QUOTENAME(c.child_tbl_nm) + '' FROM '' +
                    QUOTENAME(c.child_sch_nm) + ''.'' + QUOTENAME(c.child_tbl_nm) + '' AS '' + QUOTENAME(c.child_tbl_nm)
            FROM    cte AS c;

            DECLARE @join_order TABLE (
                parent_sch_nm sysname NOT NULL
               ,parent_tbl_nm sysname NOT NULL
               ,child_sch_nm  sysname NOT NULL
               ,child_tbl_nm  sysname NOT NULL
               ,lvl           INT     NOT NULL
            );

           ;WITH cte (parent_sch_nm, parent_tbl_nm, child_sch_nm, child_tbl_nm, lvl) AS (
                SELECT  dhc.parent_sch_nm
                       ,dhc.parent_tbl_nm
                       ,dhc.child_sch_nm
                       ,dhc.child_tbl_nm
                       ,0 AS lvl
                FROM    privacy_framework.dml_hierarchy_configuration AS dhc
                WHERE   dhc.child_sch_nm = @processing_sch_nm
                        AND dhc.child_tbl_nm = @processing_tbl_nm
                UNION ALL
                SELECT  dhc.parent_sch_nm
                       ,dhc.parent_tbl_nm
                       ,dhc.child_sch_nm
                       ,dhc.child_tbl_nm
                       ,c.lvl + 1
                FROM    cte AS c
                        INNER JOIN privacy_framework.dml_hierarchy_configuration AS dhc ON dhc.child_sch_nm = c.parent_sch_nm
                                AND dhc.child_tbl_nm = c.parent_tbl_nm
            )
            INSERT INTO @join_order(
               parent_sch_nm
              ,parent_tbl_nm
              ,child_sch_nm
              ,child_tbl_nm
              ,lvl
           )
            SELECT  c.parent_sch_nm
                   ,c.parent_tbl_nm
                   ,c.child_sch_nm
                   ,c.child_tbl_nm
                   ,c.lvl
            FROM    cte AS c
            GROUP BY c.parent_sch_nm
                    ,c.parent_tbl_nm
                    ,c.child_sch_nm
                    ,c.child_tbl_nm   
                    ,c.lvl;

            WHILE EXISTS (SELECT 1 FROM @join_order AS jo)
            BEGIN
                DECLARE @child_sch_nm sysname
                       ,@child_tbl_nm sysname
                       ,@parent_sch_nm sysname
                       ,@parent_tbl_nm sysname;

                SELECT  TOP (1)
                        @child_sch_nm = jo.child_sch_nm
                       ,@child_tbl_nm = jo.child_tbl_nm
                       ,@parent_sch_nm = jo.parent_sch_nm
                       ,@parent_tbl_nm = jo.parent_tbl_nm
                FROM    @join_order AS jo
                ORDER BY jo.lvl ASC

                SET @str_drp += '' INNER JOIN '' + QUOTENAME(@parent_sch_nm) + ''.'' + QUOTENAME(@parent_tbl_nm) + 
                                '' AS '' + QUOTENAME(@parent_tbl_nm)

                SELECT  @str_drp += ISNULL('' ON '' + STRING_AGG(QUOTENAME(@child_tbl_nm) + ''.'' + dhc.child_join_col_nm + '' = '' + 
                                                                 QUOTENAME(@parent_tbl_nm) + ''.'' + dhc.parent_join_col_nm, '' AND ''), SPACE(0))
                FROM    privacy_framework.dml_hierarchy_configuration AS dhc 
                WHERE   dhc.parent_sch_nm = @parent_sch_nm
                        AND dhc.parent_tbl_nm = @parent_tbl_nm
                        AND dhc.child_sch_nm = @child_sch_nm
                        AND dhc.child_tbl_nm = @child_tbl_nm;

                DELETE  jo
                FROM    @join_order jo
                WHERE   jo.child_sch_nm = @child_sch_nm
                        AND jo.child_tbl_nm = @child_tbl_nm
                        AND jo.parent_sch_nm = @parent_sch_nm
                        AND jo.parent_tbl_nm = @parent_tbl_nm;
           END;

           ;WITH cte (parent_sch_nm, parent_tbl_nm, child_sch_nm, child_tbl_nm, lvl) AS (
                SELECT  dhc.parent_sch_nm
                       ,dhc.parent_tbl_nm
                       ,dhc.child_sch_nm
                       ,dhc.child_tbl_nm
                       ,0 AS lvl
                FROM    privacy_framework.dml_hierarchy_configuration AS dhc
                WHERE   dhc.child_sch_nm = @processing_sch_nm
                        AND dhc.child_tbl_nm = @processing_tbl_nm
                UNION ALL
                SELECT  dhc.parent_sch_nm
                       ,dhc.parent_tbl_nm
                       ,dhc.child_sch_nm
                       ,dhc.child_tbl_nm
                       ,c.lvl + 1
                FROM    cte AS c
                        INNER JOIN privacy_framework.dml_hierarchy_configuration AS dhc ON dhc.child_sch_nm = c.parent_sch_nm
                                AND dhc.child_tbl_nm = c.parent_tbl_nm
            ), parent AS (
                SELECT  TOP (1)
                        c.parent_sch_nm
                       ,c.parent_tbl_nm
                FROM    cte AS c
                ORDER BY c.lvl DESC
            )
            SELECT   @str_drp += '' WHERE   ''+ddc.drp_condition+'' < DATEADD(''+drc.retention_period_type+'', ''+CAST(drc.retention_period_value AS VARCHAR(10))+'' * -1, GETUTCDATE())
                             AND ''+ddc.drp_condition+'' <= DATEADD(DD, ''+CAST(drc.days_to_process AS VARCHAR(10))+'', @min_date)''
            FROM    parent AS p
                    INNER JOIN privacy_framework.dml_drp_condition AS ddc ON ddc.sch_nm = p.parent_sch_nm
                            AND ddc.tbl_nm = p.parent_tbl_nm
                    INNER JOIN privacy_framework.dml_retention_configuration AS drc ON drc.sch_nm = ddc.sch_nm
                            AND drc.tbl_nm = ddc.tbl_nm;

        END 
        ELSE
        BEGIN 
            SELECT  @str_drp += ''DECLARE @min_date DATETIME2(3) = (
                    SELECT MIN('' + ddc.drp_condition + '')
                    FROM   '' + QUOTENAME(ddc.sch_nm) + ''.'' + QUOTENAME(ddc.tbl_nm) + '' AS '' + QUOTENAME(ddc.tbl_nm) + '')''
            FROM    privacy_framework.dml_drp_condition AS ddc
            WHERE   ddc.sch_nm = @processing_sch_nm
                    AND ddc.tbl_nm = @processing_tbl_nm;

            SELECT  @str_drp += ''DELETE '' + QUOTENAME(ddc.tbl_nm) + '' FROM '' +
                    QUOTENAME(ddc.sch_nm) + ''.'' + QUOTENAME(ddc.tbl_nm) + '' AS '' + QUOTENAME(ddc.tbl_nm) +
                    '' WHERE   ''+ddc.drp_condition+'' < DATEADD(''+drc.retention_period_type+'', ''+CAST(drc.retention_period_value AS VARCHAR(10))+'' * -1, GETUTCDATE())
                             AND ''+ddc.drp_condition+'' <= DATEADD(DD, ''+CAST(drc.days_to_process AS VARCHAR(10))+'', @min_date)''
            FROM    privacy_framework.dml_drp_condition AS ddc 
                    INNER JOIN privacy_framework.dml_retention_configuration AS drc ON drc.sch_nm = ddc.sch_nm
                            AND drc.tbl_nm = ddc.tbl_nm
            WHERE   ddc.sch_nm = @processing_sch_nm
                    AND ddc.tbl_nm = @processing_tbl_nm;

        END; 

        BEGIN TRY

            EXEC(@str_drp);

        END TRY
        BEGIN CATCH

            PRINT ''SQL Parse Failure: ['' +@str_drp+ + '']'';
            THROW;
        END CATCH';

        DECLARE @params_build_drp NVARCHAR(500) = N'
        @processing_sch_nm sysname
       ,@processing_tbl_nm sysname';

        EXEC sys.sp_executesql @sql_build_drp
                              ,@params_build_drp 
                              ,@processing_sch_nm
                              ,@processing_tbl_nm;

        DELETE  fo
        FROM    #all_tables_order AS fo
        WHERE   fo.sch_nm = @processing_sch_nm
                AND fo.tbl_nm = @processing_tbl_nm;

    END; --end table processing loop

END;
GO