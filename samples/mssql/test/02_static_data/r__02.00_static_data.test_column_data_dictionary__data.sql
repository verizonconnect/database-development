-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_column_data_dictionary__data
AS
BEGIN
 
    SET NOCOUNT ON;
    
    CREATE TABLE #expected (
        sch_nm                         SYSNAME      NOT NULL
       ,tbl_nm                         SYSNAME      NOT NULL
       ,col_nm                         SYSNAME      NOT NULL
       ,pii_indicator                  BIT          NOT NULL
       ,direct_pii_indicator           BIT          NOT NULL
       ,subject_data_type_id           SMALLINT         NULL 
       ,subject_type_id                SMALLINT         NULL
       ,PRIMARY KEY (sch_nm, tbl_nm, col_nm)
    );

    --INSERT INTO #expected (
    --    sch_nm                        
    --   ,tbl_nm                        
    --   ,col_nm                                    
    --   ,pii_indicator                 
    --   ,direct_pii_indicator
    --   ,subject_data_type_id
    --   ,subject_type_id
    --) VALUES   
    --        ('sch_nm','tbl_nm','col_nm',0,0,NULL,NULL)
 
            
    SELECT  t.sch_nm
           ,t.tbl_nm                       
           ,t.col_nm                                    
           ,t.pii_indicator                 
           ,t.direct_pii_indicator
           ,t.subject_data_type_id
           ,t.subject_type_id
    INTO    #actual
    FROM    privacy_framework.column_data_dictionary AS t;
 
    EXEC tSQLt.AssertEqualsTable @Expected = N'#expected'
                                ,@Actual = N'#actual'
                                ,@Message = N'column_data_dictionary data not as expected';
 
END;
GO

