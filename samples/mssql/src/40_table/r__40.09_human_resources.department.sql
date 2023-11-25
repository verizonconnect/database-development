
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[human_resources].[department]') AND type in (N'U'))
BEGIN
CREATE TABLE [human_resources].[department](
    [department_id] [smallint] IDENTITY(1,1) NOT NULL,
    [name] [common].[name] NOT NULL,
    [group_name] [common].[name] NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[human_resources].[department]') AND name = N'AK_department_name')
CREATE UNIQUE NONCLUSTERED INDEX [AK_department_name] ON [human_resources].[department]
(
    [name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'department', N'COLUMN',N'department_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for department records.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'department', @level2type=N'COLUMN',@level2name=N'department_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'department', N'COLUMN',N'name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'name of the department.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'department', @level2type=N'COLUMN',@level2name=N'name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'department', N'COLUMN',N'group_name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'name of the group to which the department belongs.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'department', @level2type=N'COLUMN',@level2name=N'group_name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'department', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'department', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'department', N'INDEX',N'AK_department_name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'department', @level2type=N'INDEX',@level2name=N'AK_department_name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'department', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lookup table containing the departments within the Adventure Works Cycles company.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'department'
GO
