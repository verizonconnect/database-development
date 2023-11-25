﻿
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[person].[contact_type]') AND type in (N'U'))
BEGIN
CREATE TABLE [person].[contact_type](
    [contact_type_id] [int] IDENTITY(1,1) NOT NULL,
    [name] [common].[name] NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[person].[contact_type]') AND name = N'AK_contact_type_name')
CREATE UNIQUE NONCLUSTERED INDEX [AK_contact_type_name] ON [person].[contact_type]
(
    [name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'contact_type', N'COLUMN',N'contact_type_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for contact_type records.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'contact_type', @level2type=N'COLUMN',@level2name=N'contact_type_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'contact_type', N'COLUMN',N'name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Contact type description.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'contact_type', @level2type=N'COLUMN',@level2name=N'name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'contact_type', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'contact_type', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'contact_type', N'INDEX',N'AK_contact_type_name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'contact_type', @level2type=N'INDEX',@level2name=N'AK_contact_type_name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'contact_type', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lookup table containing the types of business entity contacts.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'contact_type'
GO
