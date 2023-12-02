SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[purchasing].[ship_method]') AND type in (N'U'))
BEGIN
CREATE TABLE [purchasing].[ship_method](
    [ship_method_id] [int] IDENTITY(1,1) NOT NULL,
    [name] [common].[name] NOT NULL,
    [ship_base] [money] NOT NULL,
    [ship_rate] [money] NOT NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'ship_method', N'COLUMN',N'ship_method_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for ship_method records.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'ship_method', @level2type=N'COLUMN',@level2name=N'ship_method_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'ship_method', N'COLUMN',N'name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shipping company name.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'ship_method', @level2type=N'COLUMN',@level2name=N'name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'ship_method', N'COLUMN',N'ship_base'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Minimum shipping charge.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'ship_method', @level2type=N'COLUMN',@level2name=N'ship_base'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'ship_method', N'COLUMN',N'ship_rate'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shipping charge per pound.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'ship_method', @level2type=N'COLUMN',@level2name=N'ship_rate'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'ship_method', N'COLUMN',N'rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'ship_method', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'ship_method', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'ship_method', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'ship_method', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Shipping company lookup table.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'ship_method'
GO
