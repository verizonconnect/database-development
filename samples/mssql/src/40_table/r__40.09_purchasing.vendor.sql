
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[purchasing].[vendor]') AND type in (N'U'))
BEGIN
CREATE TABLE [purchasing].[vendor](
    [business_entity_id] [int] NOT NULL,
    [account_number] [common].[account_number] NOT NULL,
    [name] [common].[name] NOT NULL,
    [credit_rating] [tinyint] NOT NULL,
    [preferred_vendor_status] [common].[flag] NOT NULL,
    [active_flag] [common].[flag] NOT NULL,
    [purchasing_web_service_url] [nvarchar](1024) NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[purchasing].[vendor]') AND name = N'AK_vendor_account_number')
CREATE UNIQUE NONCLUSTERED INDEX [AK_vendor_account_number] ON [purchasing].[vendor]
(
    [account_number] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'vendor', N'COLUMN',N'business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for vendor records.  Foreign key to business_entity.business_entity_id' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'vendor', @level2type=N'COLUMN',@level2name=N'business_entity_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'vendor', N'COLUMN',N'account_number'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'vendor account (identification) number.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'vendor', @level2type=N'COLUMN',@level2name=N'account_number'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'vendor', N'COLUMN',N'name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Company name.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'vendor', @level2type=N'COLUMN',@level2name=N'name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'vendor', N'COLUMN',N'credit_rating'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'1 = Superior, 2 = Excellent, 3 = Above average, 4 = Average, 5 = Below average' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'vendor', @level2type=N'COLUMN',@level2name=N'credit_rating'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'vendor', N'COLUMN',N'preferred_vendor_status'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = Do not use if another vendor is available. 1 = Preferred over other vendors supplying the same product.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'vendor', @level2type=N'COLUMN',@level2name=N'preferred_vendor_status'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'vendor', N'COLUMN',N'active_flag'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = vendor no longer used. 1 = vendor is actively used.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'vendor', @level2type=N'COLUMN',@level2name=N'active_flag'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'vendor', N'COLUMN',N'purchasing_web_service_url'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'vendor URL.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'vendor', @level2type=N'COLUMN',@level2name=N'purchasing_web_service_url'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'vendor', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'vendor', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'vendor', N'INDEX',N'AK_vendor_account_number'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'vendor', @level2type=N'INDEX',@level2name=N'AK_vendor_account_number'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'purchasing', N'TABLE',N'vendor', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Companies from whom Adventure Works Cycles purchases parts or other goods.' , @level0type=N'SCHEMA',@level0name=N'purchasing', @level1type=N'TABLE',@level1name=N'vendor'
GO
