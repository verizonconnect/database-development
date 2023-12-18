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
               WHERE  object_id = OBJECT_ID(N'[sales].[store]') 
                      AND name = N'xml_primary__sales__store_3_demographics')
CREATE PRIMARY XML INDEX [xml_primary__sales__store_3_demographics] 
ON [sales].[store] (
    [demographics]
);
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'sales', N'TABLE',N'store', N'INDEX',N'xml_primary__sales__store_3_demographics'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary XML index.' , @level0type=N'SCHEMA',@level0name=N'sales', @level1type=N'TABLE',@level1name=N'store', @level2type=N'INDEX',@level2name=N'xml_primary__sales__store_3_demographics'
GO
