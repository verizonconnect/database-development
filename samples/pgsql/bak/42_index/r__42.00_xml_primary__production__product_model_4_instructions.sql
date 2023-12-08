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
               WHERE  object_id = OBJECT_ID(N'[production].[product_model]') 
                      AND name = N'xml_primary__production__product_model_4_instructions')
CREATE PRIMARY XML INDEX [xml_primary__production__product_model_4_instructions] 
ON [production].[product_model] (
    [instructions]
);
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'product_model', N'INDEX',N'xml_primary__production__product_model_4_instructions'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary XML index.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'product_model', @level2type=N'INDEX',@level2name=N'xml_primary__production__product_model_4_instructions'
GO
