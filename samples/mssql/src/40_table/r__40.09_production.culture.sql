﻿SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[production].[culture]') AND type in (N'U'))
BEGIN
CREATE TABLE [production].[culture](
    [culture_id] [nchar](6) NOT NULL,
    [name] [common].[name] NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'culture', N'COLUMN',N'culture_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for culture records.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'culture', @level2type=N'COLUMN',@level2name=N'culture_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'culture', N'COLUMN',N'name'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'culture description.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'culture', @level2type=N'COLUMN',@level2name=N'name'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'culture', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'culture', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'culture', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Lookup table containing the languages in which some AdventureWorks data is stored.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'culture'
GO
