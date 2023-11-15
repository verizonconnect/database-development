-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_programmable_object.test_privacy_framework__search_subject__result_schemata
AS
BEGIN

    CREATE TABLE #expected_result_set_schema (
        subject_id                      INT          NOT NULL
       ,subject_name                    VARCHAR(100) NOT NULL
       ,subject_email                   VARCHAR(100)     NULL
       ,subject_email_translation_key   VARCHAR(100)     NULL
       ,subject_phone                   INT              NULL
       ,subject_phone_translation_key   VARCHAR(100)     NULL
    );

    CREATE TABLE #actual_result_set_schema (
        subject_id                      INT          NOT NULL
       ,subject_name                    VARCHAR(100) NOT NULL
       ,subject_email                   VARCHAR(100)     NULL
       ,subject_email_translation_key   VARCHAR(100)     NULL
       ,subject_phone                   INT              NULL
       ,subject_phone_translation_key   VARCHAR(100)     NULL
    );
    
    INSERT INTO #actual_result_set_schema(
        subject_id
       ,subject_name
       ,subject_email
       ,subject_email_translation_key
       ,subject_phone
       ,subject_phone_translation_key
    )
    EXEC privacy_framework.search_subject @account_id = 1
                                         ,@subject_type_id = 1
                                         ,@first_name_search = ''  
                                         ,@last_name_search = NULL
                                         ,@email_search = NULL
                                         ,@phone_search = NULL;

    EXEC tsqlt.AssertEqualsTableSchema @Expected = N'#expected_result_set_schema'  -- nvarchar(max)
                                      ,@Actual = N'#actual_result_set_schema'    -- nvarchar(max)
                                      ,@Message = N'Table schemata should match'   -- nvarchar(max)
    
    
END;
GO
