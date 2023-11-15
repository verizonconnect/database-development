-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_programmable_object.test_privacy_framework__search_subject__invalid_params
AS
BEGIN

    EXEC tsqlt.ExpectException @ExpectedMessage = N'Requires at least one param in {@first_name_search, @last_name_search, @email_search, @phone_search} to be NOT NULL'
                              ,@ExpectedState = 1  
                              ,@Message = N'Error does not match what is expected' 
                              ,@ExpectedMessagePattern = N'Requires at least one param in {@first_name_search, @last_name_search, @email_search, @phone_search} to be NOT NULL'
                              ,@ExpectedErrorNumber = 50000 
    
    EXEC privacy_framework.search_subject @account_id = 1
                                         ,@subject_type_id = 1
                                         ,@first_name_search = NULL 
                                         ,@last_name_search = NULL
                                         ,@email_search = NULL
                                         ,@phone_search = NULL;
    
END;
GO
