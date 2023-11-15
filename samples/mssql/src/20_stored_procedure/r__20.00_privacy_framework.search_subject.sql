-- Copyright 2022. Verizon Connect Ireland Limited. All rights reserved.
CREATE OR ALTER PROCEDURE [privacy_framework].[search_subject](
    @account_id         INT 
   ,@subject_type_id    INT
   ,@first_name_search  VARCHAR(50)  = NULL
   ,@last_name_search   VARCHAR(50)  = NULL
   ,@email_search       VARCHAR(100) = NULL
   ,@phone_search       INT          = NULL
)
AS
BEGIN
    SET NOCOUNT ON;

    --Variable declarations
    DECLARE @return_value INT = -1;
    IF COALESCE(@first_name_search, @last_name_search,@email_search,@phone_search) IS NULL
    BEGIN
        ;THROW 50000, 'Requires at least one param in {@first_name_search, @last_name_search, @email_search, @phone_search} to be NOT NULL', 1;
    END

    --Replace: From here
    CREATE TABLE #expected_result_set_schema (
        subject_id                      INT          NOT NULL
       ,subject_name                    VARCHAR(100) NOT NULL
       ,subject_email                   VARCHAR(100)     NULL
       ,subject_email_translation_key   VARCHAR(100)     NULL
       ,subject_phone                   INT              NULL
       ,subject_phone_translation_key   VARCHAR(100)     NULL
    );

    SELECT  t.subject_id
           ,t.subject_name
           ,t.subject_email
           ,t.subject_email_translation_key
           ,t.subject_phone
           ,t.subject_phone_translation_key
    FROM    #expected_result_set_schema AS t;

    --Replace: To here

    SET @return_value = 1;
    RETURN @return_value;

END;
GO
