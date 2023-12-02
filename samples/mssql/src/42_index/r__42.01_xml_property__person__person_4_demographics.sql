SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO
IF NOT EXISTS (SELECT 1 
               FROM   sys.indexes 
               WHERE  object_id = OBJECT_ID(N'[person].[person]') 
                      AND name = N'xml_property__person__person_4_demographics')
CREATE XML INDEX [xml_property__person__person_4_demographics] 
ON [person].[person] (
    [demographics]
)
USING XML INDEX [xml_primary__person__person_4_demographics] FOR PROPERTY;
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'person', N'TABLE',N'person', N'INDEX',N'xml_property__person__person_4_demographics'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Secondary XML index for property.' , @level0type=N'SCHEMA',@level0name=N'person', @level1type=N'TABLE',@level1name=N'person', @level2type=N'INDEX',@level2name=N'xml_property__person__person_4_demographics'
GO
