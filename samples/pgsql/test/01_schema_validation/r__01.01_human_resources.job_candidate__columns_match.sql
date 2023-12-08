
CREATE OR ALTER PROCEDURE test_schema_validation.test_job_candidate__columns_match
AS
BEGIN
 
    CREATE TABLE [human_resources].[job_candidate_tsqlt](
        [job_candidate_id] int NOT NULL
       ,[business_entity_id] int NULL
       ,[resume] xml NULL
       ,[modified_date] datetime NOT NULL 
    );
 
    EXEC tSQLt.AssertEqualsTableSchema @Expected = N'human_resources.job_candidate_tsqlt'
                                      ,@Actual = N'human_resources.job_candidate'
                                      ,@Message = N'Column definitions do not match';
END;
GO
