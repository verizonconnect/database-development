/****** Object:  Table [sales].[currency_rate]    Script Date: 16/11/2023 08:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[sales].[currency_rate]') AND type in (N'U'))
BEGIN
CREATE TABLE [sales].[currency_rate](
    [currency_rate_id] [int] IDENTITY(1,1) NOT NULL,
    [currency_rate_date] [datetime] NOT NULL,
    [from_currency_code] [nchar](3) NOT NULL,
    [to_currency_code] [nchar](3) NOT NULL,
    [average_rate] [money] NOT NULL,
    [end_of_day_rate] [money] NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [AK_currency_rate_currency_rate_date_from_currency_code_to_currency_code]    Script Date: 16/11/2023 08:45:05 ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[sales].[currency_rate]') AND name = N'AK_currency_rate_currency_rate_date_from_currency_code_to_currency_code')
CREATE UNIQUE NONCLUSTERED INDEX [AK_currency_rate_currency_rate_date_from_currency_code_to_currency_code] ON [sales].[currency_rate]
(
    [currency_rate_date] ASC,
    [from_currency_code] ASC,
    [to_currency_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'currency_rate', N'COLUMN',N'currency_rate_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for currency_rate records.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'currency_rate', @level2type=N'COLUMN',@level2name=N'currency_rate_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'currency_rate', N'COLUMN',N'currency_rate_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the exchange rate was obtained.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'currency_rate', @level2type=N'COLUMN',@level2name=N'currency_rate_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'currency_rate', N'COLUMN',N'from_currency_code'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Exchange rate was converted from this currency code.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'currency_rate', @level2type=N'COLUMN',@level2name=N'from_currency_code'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'currency_rate', N'COLUMN',N'to_currency_code'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Exchange rate was converted to this currency code.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'currency_rate', @level2type=N'COLUMN',@level2name=N'to_currency_code'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'currency_rate', N'COLUMN',N'average_rate'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Average exchange rate for the day.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'currency_rate', @level2type=N'COLUMN',@level2name=N'average_rate'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'currency_rate', N'COLUMN',N'end_of_day_rate'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Final exchange rate for the day.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'currency_rate', @level2type=N'COLUMN',@level2name=N'end_of_day_rate'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'currency_rate', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'currency_rate', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'currency_rate', N'INDEX',N'AK_currency_rate_currency_rate_date_from_currency_code_to_currency_code'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'currency_rate', @level2type=N'INDEX',@level2name=N'AK_currency_rate_currency_rate_date_from_currency_code_to_currency_code'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'currency_rate', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'currency exchange rates.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'currency_rate'
GO

