-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_table_configuration__data
AS
BEGIN
 
    CREATE TABLE #expected (
        sch_nm                      SYSNAME       NOT NULL
       ,tbl_nm                      SYSNAME       NOT NULL
       ,batch_size                  INT           NOT NULL
       ,account_id_column_name    NVARCHAR(128) NOT NULL
       ,modified_utc_when_column_name   NVARCHAR(128) NOT NULL
       ,obfuscated_ind_column_name   NVARCHAR(128) NOT NULL
       ,subject_id_column_name          SYSNAME           NULL
       ,PRIMARY KEY (sch_nm, tbl_nm)
    );

    --INSERT INTO #expected (
    --    sch_nm
    --   ,tbl_nm
    --   ,batch_size
    --   ,account_id_column_name
    --   ,modified_utc_when_column_name
    --   ,obfuscated_ind_column_name
    --   ,subject_id_column_name
    --) VALUES   
    --        ('sch_nm','tbl_nm',NULL,NULL,NULL,NULL,NULL,NULL);

    SELECT  t.sch_nm
           ,t.tbl_nm
           ,t.batch_size
           ,t.account_id_column_name
           ,t.modified_utc_when_column_name
           ,t.obfuscated_ind_column_name
           ,t.subject_id_column_name
    INTO    #actual
    FROM    privacy_framework.table_configuration AS t;
 
    EXEC tSQLt.AssertEqualsTable @Expected = N'#expected'
                                ,@Actual = N'#actual'
                                ,@Message = N'table_configuration data not as expected';
END;
GO
