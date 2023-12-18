SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--A stored procedure which demonstrates integrated full text search
--See ../41_constraint_primary_key/r__41.00_human_resources.pk_job_candidate_job_candidate_id.sql
CREATE OR ALTER PROCEDURE [common].[get_candidate__resumes]
    @searchString [nvarchar](1000),   
    @useInflectional [bit]=0,
    @useThesaurus [bit]=0,
    @language[int]=0


WITH EXECUTE AS CALLER
AS
BEGIN
    SET NOCOUNT ON;

      DECLARE @string nvarchar(1050)
      --setting the lcid to the default instance LC_id if needed
      IF @language = NULL OR @language = 0 
      BEGIN 
            SELECT @language =CONVERT(int, serverproperty('lcid'))  
      END
      

            --FREETEXTTABLE case as inflectional and Thesaurus were required
      IF @useThesaurus = 1 AND @useInflectional = 1  
        BEGIN
                  SELECT FT_TBL.[job_candidate_id], KEY_TBL.[RANK] FROM [human_resources].[job_candidate] AS FT_TBL 
                        INNER JOIN FREETEXTTABLE([human_resources].[job_candidate],*, @searchString,LANGUAGE @language) AS KEY_TBL
                   ON  FT_TBL.[job_candidate_id] =KEY_TBL.[KEY]
            END

      ELSE IF @useThesaurus = 1
            BEGIN
                  SELECT @string ='FORMSOF(THESAURUS,"'+@searchString +'"'+')'      
                  SELECT FT_TBL.[job_candidate_id], KEY_TBL.[RANK] FROM [human_resources].[job_candidate] AS FT_TBL 
                        INNER JOIN CONTAINSTABLE([human_resources].[job_candidate],*, @string,LANGUAGE @language) AS KEY_TBL
                   ON  FT_TBL.[job_candidate_id] =KEY_TBL.[KEY]
        END

      ELSE IF @useInflectional = 1
            BEGIN
                  SELECT @string ='FORMSOF(INFLECTIONAL,"'+@searchString +'"'+')'
                  SELECT FT_TBL.[job_candidate_id], KEY_TBL.[RANK] FROM [human_resources].[job_candidate] AS FT_TBL 
                        INNER JOIN CONTAINSTABLE([human_resources].[job_candidate],*, @string,LANGUAGE @language) AS KEY_TBL
                   ON  FT_TBL.[job_candidate_id] =KEY_TBL.[KEY]
        END
  
      ELSE --base case, plain CONTAINSTABLE
            BEGIN
                  SELECT @string='"'+@searchString +'"'
                  SELECT FT_TBL.[job_candidate_id],KEY_TBL.[RANK] FROM [human_resources].[job_candidate] AS FT_TBL 
                        INNER JOIN CONTAINSTABLE([human_resources].[job_candidate],*,@string,LANGUAGE @language) AS KEY_TBL
                   ON  FT_TBL.[job_candidate_id] =KEY_TBL.[KEY]
            END

END;
GO
