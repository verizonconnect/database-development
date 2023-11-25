
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[person].[phone_number_type]') AND type in (N'U'))
BEGIN
CREATE TABLE [person].[phone_number_type](
    [phone_number_type_id] [int] IDENTITY(1,1) NOT NULL,
    [name] [common].[name] NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'phone_number_type', N'COLUMN',N'phone_number_type_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for telephone number type records.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'phone_number_type', @level2type=N'COLUMN',@level2name=N'phone_number_type_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'phone_number_type', N'COLUMN',N'name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'name of the telephone number type' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'phone_number_type', @level2type=N'COLUMN',@level2name=N'name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'phone_number_type', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'phone_number_type', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'phone_number_type', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'type of phone number of a person.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'phone_number_type'
GO
