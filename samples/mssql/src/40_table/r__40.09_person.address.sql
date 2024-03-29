﻿SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[person].[address]') AND type in (N'U'))
BEGIN
CREATE TABLE [person].[address](
    [address_id] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
    [address_line_1] [nvarchar](60) NOT NULL,
    [address_line_2] [nvarchar](60) NULL,
    [city] [nvarchar](30) NOT NULL,
    [state_province_id] [int] NOT NULL,
    [postal_code] [nvarchar](15) NOT NULL,
    [spatial_location] [geography] NULL,
    [rowguid] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'address', N'COLUMN',N'address_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for address records.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'address', @level2type=N'COLUMN',@level2name=N'address_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'address', N'COLUMN',N'address_line_1'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'First street address line.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'address', @level2type=N'COLUMN',@level2name=N'address_line_1'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'address', N'COLUMN',N'address_line_2'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Second street address line.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'address', @level2type=N'COLUMN',@level2name=N'address_line_2'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'address', N'COLUMN',N'city'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'name of the city.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'address', @level2type=N'COLUMN',@level2name=N'city'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'address', N'COLUMN',N'state_province_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Unique identification number for the state or province. Foreign key to state_province table.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'address', @level2type=N'COLUMN',@level2name=N'state_province_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'address', N'COLUMN',N'postal_code'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Postal code for the street address.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'address', @level2type=N'COLUMN',@level2name=N'postal_code'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'address', N'COLUMN',N'spatial_location'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Latitude and longitude of this address.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'address', @level2type=N'COLUMN',@level2name=N'spatial_location'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'address', N'COLUMN',N'rowguid'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'address', @level2type=N'COLUMN',@level2name=N'rowguid'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'address', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'address', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'address', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Street address information for customers, employees, and vendors.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'address'
GO
