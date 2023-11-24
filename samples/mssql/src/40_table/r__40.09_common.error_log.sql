/****** Object:  Table [common].[error_log]    Script Date: 16/11/2023 08:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[common].[error_log]') AND type in (N'U'))
BEGIN
CREATE TABLE [common].[error_log](
    [error_log_id] [int] IDENTITY(1,1) NOT NULL,
    [error_time] [datetime] NOT NULL,
    [user_name] [sysname] NOT NULL,
    [error_number] [int] NOT NULL,
    [error_severity] [int] NULL,
    [error_state] [int] NULL,
    [error_procedure] [nvarchar](126) NULL,
    [error_line] [int] NULL,
    [error_message] [nvarchar](4000) NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'TABLE',N'error_log', N'COLUMN',N'error_log_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for error_log records.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'TABLE',@level1name=N'error_log', @level2type=N'COLUMN',@level2name=N'error_log_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'TABLE',N'error_log', N'COLUMN',N'error_time'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The date and time at which the error occurred.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'TABLE',@level1name=N'error_log', @level2type=N'COLUMN',@level2name=N'error_time'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'TABLE',N'error_log', N'COLUMN',N'user_name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The user who executed the batch in which the error occurred.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'TABLE',@level1name=N'error_log', @level2type=N'COLUMN',@level2name=N'user_name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'TABLE',N'error_log', N'COLUMN',N'error_number'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The error number of the error that occurred.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'TABLE',@level1name=N'error_log', @level2type=N'COLUMN',@level2name=N'error_number'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'TABLE',N'error_log', N'COLUMN',N'error_severity'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The severity of the error that occurred.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'TABLE',@level1name=N'error_log', @level2type=N'COLUMN',@level2name=N'error_severity'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'TABLE',N'error_log', N'COLUMN',N'error_state'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The state number of the error that occurred.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'TABLE',@level1name=N'error_log', @level2type=N'COLUMN',@level2name=N'error_state'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'TABLE',N'error_log', N'COLUMN',N'error_procedure'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The name of the stored procedure or trigger where the error occurred.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'TABLE',@level1name=N'error_log', @level2type=N'COLUMN',@level2name=N'error_procedure'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'TABLE',N'error_log', N'COLUMN',N'error_line'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The line number at which the error occurred.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'TABLE',@level1name=N'error_log', @level2type=N'COLUMN',@level2name=N'error_line'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'TABLE',N'error_log', N'COLUMN',N'error_message'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'The message text of the error that occurred.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'TABLE',@level1name=N'error_log', @level2type=N'COLUMN',@level2name=N'error_message'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'common', N'TABLE',N'error_log', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Audit table tracking errors in the the AdventureWorks database that are caught by the CATCH block of a TRY...CATCH construct. Data is inserted by stored procedure common.add_log__error when it is executed from inside the CATCH block of a TRY...CATCH construct.' , @level0type=N'SCHEMA',@level0name=N'common', @level1type=N'TABLE',@level1name=N'error_log'
GO
