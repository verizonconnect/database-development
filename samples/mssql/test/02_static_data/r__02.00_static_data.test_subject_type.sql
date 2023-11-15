-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_subject_type__data
AS
BEGIN
 
    SET NOCOUNT ON;
    
    CREATE TABLE #expected (
        subject_type_id   SMALLINT      NOT NULL
       ,subject_type_desc VARCHAR(100)  NOT NULL
    );

    INSERT INTO #expected (
        [subject_type_id]
       ,[subject_type_desc])
    VALUES (1, 'Customer''s Customer')
          ,(2, 'User (includes Driver/Technician/Admin/User)')
          ,(3, 'Customer Additional Contact')
          ,(4, 'Account')
          ,(5, 'Installer')
          ,(6, 'Vendor')
          ,(7, 'B2B Point of Contact')
          ,(8, 'Verizon Customer')
          ,(9, 'Verizon Employee');
      
    SELECT  t.subject_type_id
           ,t.subject_type_desc
    INTO    #actual
    FROM    privacy_framework.subject_type AS t;
 
    EXEC tSQLt.AssertEqualsTable @Expected = N'#expected'
                                ,@Actual = N'#actual'
                                ,@Message = N'subject_type data not as expected';
 
END;
GO

