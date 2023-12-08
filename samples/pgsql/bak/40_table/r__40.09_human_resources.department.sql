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
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'department', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lookup table containing the departments within the Adventure Works Cycles company.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'department'
GO
