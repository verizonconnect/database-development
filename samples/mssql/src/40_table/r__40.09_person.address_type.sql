SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[person].[address_type]') AND type in (N'U'))
BEGIN
CREATE TABLE [person].[address_type](
    [address_type_id] [int] IDENTITY(1,1) NOT NULL,
    [name] [common].[name] NOT NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'address_type', N'COLUMN',N'address_type_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for address_type records.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'address_type', @level2type=N'COLUMN',@level2name=N'address_type_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'address_type', N'COLUMN',N'name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'address type description. For example, Billing, Home, or Shipping.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'address_type', @level2type=N'COLUMN',@level2name=N'name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'address_type', N'COLUMN',N'rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'address_type', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'address_type', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'address_type', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'address_type', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'types of addresses stored in the address table. ' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'address_type'
GO
