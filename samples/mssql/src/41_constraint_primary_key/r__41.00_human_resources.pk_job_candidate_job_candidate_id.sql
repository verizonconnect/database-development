
IF OBJECT_ID('[human_resources].[pk_job_candidate_job_candidate_id]', 'PK') IS NULL
    BEGIN
        ALTER TABLE [human_resources].[job_candidate]
        ADD CONSTRAINT [pk_job_candidate_job_candidate_id]
        PRIMARY KEY CLUSTERED (job_candidate_id ASC)
        WITH ( DATA_COMPRESSION = NONE)
        ON [PRIMARY];
    END;
GO

IF NOT EXISTS (SELECT 1 
               FROM sys.fn_listextendedproperty(N'MS_Description'
                                              , N'SCHEMA',N'human_resources'
                                              , N'TABLE',N'job_candidate'
                                              , N'CONSTRAINT',N'pk_job_candidate_job_candidate_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description'
                                  , @value=N'Primary key (clustered) constraint'
                                  , @level0type=N'SCHEMA',@level0name=N'human_resources'
                                  , @level1type=N'TABLE',@level1name=N'job_candidate'
                                  , @level2type=N'CONSTRAINT',@level2name=N'pk_job_candidate_job_candidate_id'
GO
