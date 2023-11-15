-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_table_data_dictionary__data
AS
BEGIN
 
    CREATE TABLE #expected (
        sch_nm                      SYSNAME       NOT NULL
       ,tbl_nm                      SYSNAME       NOT NULL
       ,transactional_indicator     BIT           NOT NULL
       ,partitioned_indicator       BIT           NOT NULL
       ,drp_type_desc               VARCHAR(20)   NOT NULL
       ,business_justification_id   TINYINT       NOT NULL
       ,PRIMARY KEY (sch_nm, tbl_nm)
    );

    --INSERT INTO #expected (
    --    sch_nm
    --   ,tbl_nm
    --   ,transactional_indicator
    --   ,partitioned_indicator
    --   ,drp_type_desc
    --   ,business_justification_id
    --) VALUES   
    --        ('sch_nm','tbl_nm',0,0,'RDT99',0);

    SELECT  t.sch_nm
           ,t.tbl_nm
           ,t.transactional_indicator
           ,t.partitioned_indicator
           ,t.drp_type_desc
           ,t.business_justification_id
    INTO    #actual
    FROM    privacy_framework.table_data_dictionary AS t;
 
    EXEC tSQLt.AssertEqualsTable @Expected = N'#expected'
                                ,@Actual = N'#actual'
                                ,@Message = N'table_data_dictionary data not as expected';
END;
GO
