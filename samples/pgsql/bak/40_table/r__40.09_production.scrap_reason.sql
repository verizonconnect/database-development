SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[production].[scrap_reason]') AND type in (N'U'))
BEGIN
CREATE TABLE [production].[scrap_reason](
    [scrap_reason_id] [smallint] IDENTITY(1,1) NOT NULL,
    [name] [common].[name] NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'scrap_reason', N'COLUMN',N'scrap_reason_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for scrap_reason records.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'scrap_reason', @level2type=N'COLUMN',@level2name=N'scrap_reason_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'scrap_reason', N'COLUMN',N'name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Failure description.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'scrap_reason', @level2type=N'COLUMN',@level2name=N'name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'scrap_reason', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'scrap_reason', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'scrap_reason', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Manufacturing failure reasons lookup table.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'scrap_reason'
GO
