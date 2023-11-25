
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[person].[person]') AND type in (N'U'))
BEGIN
CREATE TABLE [person].[person](
    [business_entity_id] [int] NOT NULL,
    [person_type] [nchar](2) NOT NULL,
    [name_style] [common].[name_style] NOT NULL,
    [title] [nvarchar](8) NULL,
    [first_name] [common].[name] NOT NULL,
    [middle_name] [common].[name] NULL,
    [last_name] [common].[name] NOT NULL,
    [suffix] [nvarchar](10) NULL,
    [email_promotion] [int] NOT NULL,
    [additional_contact_info] [xml](CONTENT [person].[additional_contact_info]) NULL,
    [demographics] [xml](CONTENT [person].[individual_survey]) NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[person].[person]') AND name = N'AK_person_rowguid')
CREATE UNIQUE NONCLUSTERED INDEX [AK_person_rowguid] ON [person].[person]
(
    [rowguid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[person].[person]') AND name = N'IX_person_last_name_first_name_middle_name')
CREATE NONCLUSTERED INDEX [IX_person_last_name_first_name_middle_name] ON [person].[person]
(
    [last_name] ASC,
    [first_name] ASC,
    [middle_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[person].[df_person_name_style]') AND type = 'D')
BEGIN
ALTER TABLE [person].[person] ADD  CONSTRAINT [df_person_name_style]  DEFAULT ((0)) FOR [name_style]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'person', N'COLUMN',N'business_entity_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for person records.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'person', @level2type=N'COLUMN',@level2name=N'business_entity_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'person', N'COLUMN',N'person_type'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary type of person: SC = store Contact, IN = Individual (retail) customer, SP = sales person, EM = employee (non-sales), VC = vendor contact, GC = General contact' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'person', @level2type=N'COLUMN',@level2name=N'person_type'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'person', N'COLUMN',N'name_style'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = The data in first_name and last_name are stored in western style (first name, last name) order.  1 = Eastern style (last name, first name) order.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'person', @level2type=N'COLUMN',@level2name=N'name_style'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'person', N'COLUMN',N'title'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'A courtesy title. For example, Mr. or Ms.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'person', @level2type=N'COLUMN',@level2name=N'title'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'person', N'COLUMN',N'first_name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'First name of the person.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'person', @level2type=N'COLUMN',@level2name=N'first_name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'person', N'COLUMN',N'middle_name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Middle name or middle initial of the person.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'person', @level2type=N'COLUMN',@level2name=N'middle_name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'person', N'COLUMN',N'last_name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Last name of the person.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'person', @level2type=N'COLUMN',@level2name=N'last_name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'person', N'COLUMN',N'suffix'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Surname suffix. For example, Sr. or Jr.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'person', @level2type=N'COLUMN',@level2name=N'suffix'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'person', N'COLUMN',N'email_promotion'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0 = Contact does not wish to receive e-mail promotions, 1 = Contact does wish to receive e-mail promotions from AdventureWorks, 2 = Contact does wish to receive e-mail promotions from AdventureWorks and selected partners. ' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'person', @level2type=N'COLUMN',@level2name=N'email_promotion'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'person', N'COLUMN',N'additional_contact_info'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Additional contact information about the person stored in xml format. ' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'person', @level2type=N'COLUMN',@level2name=N'additional_contact_info'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'person', N'COLUMN',N'demographics'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'personal information such as hobbies, and income collected from online shoppers. Used for sales analysis.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'person', @level2type=N'COLUMN',@level2name=N'demographics'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'person', N'COLUMN',N'rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'person', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'person', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'person', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'person', N'INDEX',N'AK_person_rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique nonclustered index. Used to support replication samples.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'person', @level2type=N'INDEX',@level2name=N'AK_person_rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'person', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Human beings involved with AdventureWorks: employees, customer contacts, and vendor contacts.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'person'
GO
