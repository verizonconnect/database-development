-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_privacy_framework__all_tables_accounted_for
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @exclude_schema_ids TABLE (
        id INT NOT NULL
    );
    INSERT INTO @exclude_schema_ids (
        id
    ) VALUES (ISNULL(SCHEMA_ID('tSQLt'), -1))
            ,(ISNULL(SCHEMA_ID('privacy_framework'), -1))
            ,(ISNULL(SCHEMA_ID('flyway'), -1))
            ,(ISNULL(SCHEMA_ID('flyway_test'), -1));

    DECLARE @exclude_tables TABLE (
        object_id INT NOT NULL
    );
    INSERT INTO @exclude_tables (
        object_id
    ) VALUES (ISNULL(OBJECT_ID('dbo.flyway_schema_history'), -1))
            ,(ISNULL(OBJECT_ID('test.flyway_schema_history'), -1))
            ,(ISNULL(OBJECT_ID('dbo.DDL_Log'), -1))
            ,(ISNULL(OBJECT_ID('UTILITY.DBVersion'), -1))
            ,(ISNULL(OBJECT_ID('dbo.__RefactorLog'), -1));
   
    SELECT  SCHEMA_NAME(t.schema_id) AS sch_nm
           ,t.name AS tbl_nm
    INTO    #expected
    FROM    sys.tables AS t
    WHERE   NOT EXISTS (SELECT 1 FROM @exclude_schema_ids AS e WHERE e.id = t.schema_id)
            AND NOT EXISTS (SELECT 1 FROM @exclude_tables AS e WHERE e.object_id = t.object_id);

    SELECT  t.sch_nm
           ,t.tbl_nm
    INTO    #actual
    FROM    privacy_framework.table_data_dictionary AS t;
 
    EXEC tSQLt.AssertEqualsTable @Expected = N'#expected'
                                ,@Actual = N'#actual'
                                ,@Message = N'privacy_framework.table_data_dictionary data does not match the schema';
END;
GO
