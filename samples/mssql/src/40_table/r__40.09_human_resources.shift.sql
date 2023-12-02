
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[human_resources].[shift]') AND type in (N'U'))
BEGIN
CREATE TABLE [human_resources].[shift](
    [shift_id] [tinyint] IDENTITY(1,1) NOT NULL,
    [name] [common].[name] NOT NULL,
    [start_time] [time](7) NOT NULL,
    [end_time] [time](7) NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'shift', N'COLUMN',N'shift_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for shift records.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'shift', @level2type=N'COLUMN',@level2name=N'shift_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'shift', N'COLUMN',N'name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'shift description.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'shift', @level2type=N'COLUMN',@level2name=N'name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'shift', N'COLUMN',N'start_time'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'shift start time.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'shift', @level2type=N'COLUMN',@level2name=N'start_time'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'shift', N'COLUMN',N'end_time'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'shift end time.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'shift', @level2type=N'COLUMN',@level2name=N'end_time'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'shift', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'shift', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'shift', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Work shift lookup table.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'shift'
GO
