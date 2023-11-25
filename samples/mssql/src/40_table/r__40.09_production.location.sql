
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[production].[location]') AND type in (N'U'))
BEGIN
CREATE TABLE [production].[location](
    [location_id] [smallint] IDENTITY(1,1) NOT NULL,
    [name] [common].[name] NOT NULL,
    [cost_rate] [smallmoney] NOT NULL,
    [availability] [decimal](8, 2) NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[production].[location]') AND name = N'AK_location_name')
CREATE UNIQUE NONCLUSTERED INDEX [AK_location_name] ON [production].[location]
(
    [name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'location', N'COLUMN',N'location_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for location records.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'location', @level2type=N'COLUMN',@level2name=N'location_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'location', N'COLUMN',N'name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'location description.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'location', @level2type=N'COLUMN',@level2name=N'name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'location', N'COLUMN',N'cost_rate'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Standard hourly cost of the manufacturing location.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'location', @level2type=N'COLUMN',@level2name=N'cost_rate'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'location', N'COLUMN',N'Availability'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Work capacity (in hours) of the manufacturing location.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'location', @level2type=N'COLUMN',@level2name=N'Availability'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'location', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'location', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'location', N'INDEX',N'AK_location_name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'location', @level2type=N'INDEX',@level2name=N'AK_location_name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'location', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product inventory and manufacturing locations.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'location'
GO
