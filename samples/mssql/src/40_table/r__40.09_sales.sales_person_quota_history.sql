SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[sales].[sales_person_quota_history]') AND type in (N'U'))
BEGIN
CREATE TABLE [sales].[sales_person_quota_history](
    [business_entity_id] [int] NOT NULL,
    [quota_date] [datetime] NOT NULL,
    [sales_quota] [money] NOT NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_person_quota_history', N'COLUMN',N'business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sales person identification number. Foreign key to sales_person.business_entity_id.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_person_quota_history', @level2type=N'COLUMN',@level2name=N'business_entity_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_person_quota_history', N'COLUMN',N'quota_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sales quota date.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_person_quota_history', @level2type=N'COLUMN',@level2name=N'quota_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_person_quota_history', N'COLUMN',N'sales_quota'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sales quota amount.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_person_quota_history', @level2type=N'COLUMN',@level2name=N'sales_quota'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_person_quota_history', N'COLUMN',N'rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_person_quota_history', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_person_quota_history', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_person_quota_history', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'sales_person_quota_history', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'sales performance tracking.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'sales_person_quota_history'
GO
