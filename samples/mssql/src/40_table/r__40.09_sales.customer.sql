﻿SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[sales].[customer]') AND type in (N'U'))
BEGIN
CREATE TABLE [sales].[customer](
    [customer_id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
    [person_id] [int] NULL,
    [store_id] [int] NULL,
    [territory_id] [int] NULL,
    [account_number]  AS (isnull('AW'+[common].[pad_leading_zeros]([customer_id]),'')),
    [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'customer', N'COLUMN',N'customer_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'customer', @level2type=N'COLUMN',@level2name=N'customer_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'customer', N'COLUMN',N'person_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key to person.business_entity_id' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'customer', @level2type=N'COLUMN',@level2name=N'person_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'customer', N'COLUMN',N'store_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Foreign key to store.business_entity_id' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'customer', @level2type=N'COLUMN',@level2name=N'store_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'customer', N'COLUMN',N'territory_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'_id of the territory in which the customer is located. Foreign key to sales_territory.salesterritory_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'customer', @level2type=N'COLUMN',@level2name=N'territory_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'customer', N'COLUMN',N'account_number'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique number identifying the customer assigned by the accounting system.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'customer', @level2type=N'COLUMN',@level2name=N'account_number'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'customer', N'COLUMN',N'rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'customer', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'customer', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'customer', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'customer', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Current customer information. Also see the person and store tables.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'customer'
GO
