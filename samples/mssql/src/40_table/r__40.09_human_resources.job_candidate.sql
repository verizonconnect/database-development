SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[human_resources].[job_candidate]') AND type in (N'U'))
BEGIN
CREATE TABLE [human_resources].[job_candidate](
    [job_candidate_id] [int] IDENTITY(1,1) NOT NULL,
    [business_entity_id] [int] NULL,
    [resume] [xml](CONTENT [human_resources].[hr_resume]) NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[human_resources].[job_candidate]') AND name = N'IX_job_candidate_business_entity_id')
CREATE NONCLUSTERED INDEX [IX_job_candidate_business_entity_id] ON [human_resources].[job_candidate]
(
    [business_entity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'job_candidate', N'COLUMN',N'job_candidate_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for job_candidate records.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'job_candidate', @level2type=N'COLUMN',@level2name=N'job_candidate_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'job_candidate', N'COLUMN',N'business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'employee identification number if applicant was hired. Foreign key to employee.business_entity_id.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'job_candidate', @level2type=N'COLUMN',@level2name=N'business_entity_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'job_candidate', N'COLUMN',N'resume'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Résumé in XML format.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'job_candidate', @level2type=N'COLUMN',@level2name=N'resume'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'job_candidate', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'job_candidate', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'job_candidate', N'INDEX',N'IX_job_candidate_business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'job_candidate', @level2type=N'INDEX',@level2name=N'IX_job_candidate_business_entity_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'job_candidate', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Résumés submitted to Human Resources by job applicants.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'job_candidate'
GO
