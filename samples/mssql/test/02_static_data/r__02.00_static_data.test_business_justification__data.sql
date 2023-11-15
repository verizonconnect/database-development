-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_static_data.test_business_justification_data
AS
BEGIN
 
    CREATE TABLE #expected (
        business_justification_id   TINYINT      NOT NULL 
       ,business_justification_desc VARCHAR(50)  NOT NULL
       ,PRIMARY KEY (business_justification_id)
    );

    INSERT INTO #expected (
        business_justification_id
       ,business_justification_desc
    )
    VALUES (1, 'Product Other')
          ,(2, 'Product Support')
          ,(3, 'Product Important')
          ,(4, 'Product Critical')
          ,(5, 'Product Not Required');

    SELECT  t.business_justification_id
           ,t.business_justification_desc
    INTO    #actual
    FROM    privacy_framework.business_justification AS t;
 
    EXEC tSQLt.AssertEqualsTable @Expected = N'#expected'
                                ,@Actual = N'#actual'
                                ,@Message = N'privacy_framework.business_justification data not as expected';
END;
GO
