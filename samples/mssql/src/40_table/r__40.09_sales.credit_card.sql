SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[sales].[credit_card]') AND type in (N'U'))
BEGIN
CREATE TABLE [sales].[credit_card](
    [credit_card_id] [int] IDENTITY(1,1) NOT NULL,
    [card_type] [nvarchar](50) NOT NULL,
    [card_number] [nvarchar](25) NOT NULL,
    [exp_month] [tinyint] NOT NULL,
    [exp_year] [smallint] NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'credit_card', N'COLUMN',N'credit_card_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for credit_card records.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'credit_card', @level2type=N'COLUMN',@level2name=N'credit_card_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'credit_card', N'COLUMN',N'card_type'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Credit card name.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'credit_card', @level2type=N'COLUMN',@level2name=N'card_type'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'credit_card', N'COLUMN',N'card_number'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Credit card number.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'credit_card', @level2type=N'COLUMN',@level2name=N'card_number'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'credit_card', N'COLUMN',N'exp_month'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Credit card expiration month.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'credit_card', @level2type=N'COLUMN',@level2name=N'exp_month'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'credit_card', N'COLUMN',N'exp_year'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Credit card expiration year.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'credit_card', @level2type=N'COLUMN',@level2name=N'exp_year'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'credit_card', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'credit_card', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'credit_card', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'customer credit card information.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'credit_card'
GO
