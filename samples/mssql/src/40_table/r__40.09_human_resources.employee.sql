/****** Object:  Table [human_resources].[employee]    Script Date: 16/11/2023 08:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[human_resources].[employee]') AND type in (N'U'))
BEGIN
CREATE TABLE [human_resources].[employee](
    [business_entity_id] [int] NOT NULL,
    [national_id_number] [nvarchar](15) NOT NULL,
    [login_id] [nvarchar](256) NOT NULL,
    [organization_node] [hierarchyid] NULL,
    [organization_level]  AS ([organization_node].[GetLevel]()),
    [job_title] [nvarchar](50) NOT NULL,
    [birth_date] [date] NOT NULL,
    [marital_status] [nchar](1) NOT NULL,
    [gender] [nchar](1) NOT NULL,
    [hire_date] [date] NOT NULL,
    [salaried_flag] [common].[flag] NOT NULL,
    [holiday_hours] [smallint] NOT NULL,
    [sick_leave_hours] [smallint] NOT NULL,
    [current_flag] [common].[flag] NOT NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [AK_employee_login_id]    Script Date: 16/11/2023 08:45:05 ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[human_resources].[employee]') AND name = N'AK_employee_login_id')
CREATE UNIQUE NONCLUSTERED INDEX [AK_employee_login_id] ON [human_resources].[employee]
(
    [login_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [AK_employee_national_id_number]    Script Date: 16/11/2023 08:45:05 ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[human_resources].[employee]') AND name = N'AK_employee_national_id_number')
CREATE UNIQUE NONCLUSTERED INDEX [AK_employee_national_id_number] ON [human_resources].[employee]
(
    [national_id_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [AK_employee_rowguid]    Script Date: 16/11/2023 08:45:05 ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[human_resources].[employee]') AND name = N'AK_employee_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [AK_employee_rowguid] ON [human_resources].[employee]
(
    [rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
/****** Object:  Index [IX_employee_organization_level_organization_node]    Script Date: 16/11/2023 08:45:05 ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[human_resources].[employee]') AND name = N'IX_employee_organization_level_organization_node')
CREATE NONCLUSTERED INDEX [IX_employee_organization_level_organization_node] ON [human_resources].[employee]
(
    [organization_level] ASC,
    [organization_node] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [IX_employee_organization_node]    Script Date: 16/11/2023 08:45:05 ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[human_resources].[employee]') AND name = N'IX_employee_organization_node')
CREATE NONCLUSTERED INDEX [IX_employee_organization_node] ON [human_resources].[employee]
(
    [organization_node] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'COLUMN',N'business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for employee records.  Foreign key to business_entity.business_entity_id.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'COLUMN',@level2name=N'business_entity_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'COLUMN',N'national_id_number'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique national identification number such as a social security number.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'COLUMN',@level2name=N'national_id_number'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'COLUMN',N'login_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Network login.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'COLUMN',@level2name=N'login_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'COLUMN',N'organization_node'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Where the employee is located in corporate hierarchy.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'COLUMN',@level2name=N'organization_node'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'COLUMN',N'organization_level'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The depth of the employee in the corporate hierarchy.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'COLUMN',@level2name=N'organization_level'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'COLUMN',N'job_title'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Work title such as Buyer or sales Representative.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'COLUMN',@level2name=N'job_title'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'COLUMN',N'birth_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date of birth.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'COLUMN',@level2name=N'birth_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'COLUMN',N'marital_status'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'M = Married, S = Single' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'COLUMN',@level2name=N'marital_status'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'COLUMN',N'gender'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'M = Male, F = Female' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'COLUMN',@level2name=N'gender'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'COLUMN',N'hire_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'employee hired on this date.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'COLUMN',@level2name=N'hire_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'COLUMN',N'salaried_flag'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Job classification. 0 = Hourly, not exempt from collective bargaining. 1 = Salaried, exempt from collective bargaining.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'COLUMN',@level2name=N'salaried_flag'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'COLUMN',N'holiday_hours'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Number of available vacation hours.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'COLUMN',@level2name=N'holiday_hours'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'COLUMN',N'current_flag'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = Inactive, 1 = Active' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'COLUMN',@level2name=N'current_flag'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'COLUMN',N'rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'INDEX',N'AK_employee_login_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'INDEX',@level2name=N'AK_employee_login_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'INDEX',N'AK_employee_national_id_number'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'INDEX',@level2name=N'AK_employee_national_id_number'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'INDEX',N'AK_employee_rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index. Used to support replication samples.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'INDEX',@level2name=N'AK_employee_rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'INDEX',N'IX_employee_organization_level_organization_node'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'INDEX',@level2name=N'IX_employee_organization_level_organization_node'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', N'INDEX',N'IX_employee_organization_node'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee', @level2type=N'INDEX',@level2name=N'IX_employee_organization_node'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'employee information such as salary, department, and title.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee'
GO
