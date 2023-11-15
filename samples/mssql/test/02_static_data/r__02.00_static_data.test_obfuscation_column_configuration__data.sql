-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_obfuscation_column_configuration__data
AS
BEGIN
 
    SET NOCOUNT ON;
    
    CREATE TABLE #expected (
         sch_nm                              SYSNAME      NOT NULL
        ,tbl_nm                              SYSNAME      NOT NULL
        ,col_nm                              SYSNAME      NOT NULL
        ,obfuscation_method_id               INT          NOT NULL
        ,obfuscated_subject_level_indicator  BIT          NOT NULL
       ,PRIMARY KEY (sch_nm, tbl_nm, col_nm)
    );

    --INSERT INTO #expected (
    --    sch_nm                        
    --   ,tbl_nm                        
    --   ,col_nm                        
    --   ,obfuscation_method_id    
    --   ,obfuscated_subject_level_indicator  
    --)
    --VALUES   ('sch_nm','tbl_nm','col_nm',0)
 
            
    SELECT  t.sch_nm
           ,t.tbl_nm                       
           ,t.col_nm                        
           ,t.obfuscation_method_id         
           ,t.obfuscated_subject_level_indicator
    INTO    #actual
    FROM    privacy_framework.obfuscation_column_configuration AS t;
 
    EXEC tSQLt.AssertEqualsTable @Expected = N'#expected'
                                ,@Actual = N'#actual'
                                ,@Message = N'obfuscation_column_configuration data not as expected';
 
END;
GO

