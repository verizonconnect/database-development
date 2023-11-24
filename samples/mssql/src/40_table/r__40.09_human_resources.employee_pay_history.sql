/****** Object:  Table [human_resources].[employee_pay_history]    Script Date: 16/11/2023 08:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[human_resources].[employee_pay_history]') AND type in (N'U'))
BEGIN
CREATE TABLE [human_resources].[employee_pay_history](
    [business_entity_id] [int] NOT NULL,
    [rate_change_date] [datetime] NOT NULL,
    [rate] [money] NOT NULL,
    [pay_frequency] [tinyint] NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee_pay_history', N'COLUMN',N'business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'employee identification number. Foreign key to employee.business_entity_id.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee_pay_history', @level2type=N'COLUMN',@level2name=N'business_entity_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee_pay_history', N'COLUMN',N'rate_change_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the change in pay is effective' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee_pay_history', @level2type=N'COLUMN',@level2name=N'rate_change_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee_pay_history', N'COLUMN',N'rate'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Salary hourly rate.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee_pay_history', @level2type=N'COLUMN',@level2name=N'rate'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee_pay_history', N'COLUMN',N'pay_frequency'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = Salary received monthly, 2 = Salary received biweekly' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee_pay_history', @level2type=N'COLUMN',@level2name=N'pay_frequency'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee_pay_history', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee_pay_history', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'human_resources', N'TABLE',N'employee_pay_history', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'employee pay history.' , @level0type=N'SCHEMA',@level0name=N'human_resources', @level1type=N'TABLE',@level1name=N'employee_pay_history'
GO
