
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.views WHERE object_id = OBJECT_ID(N'[production].[product_and_description]'))
EXEC sys.sp_executesql @statement = N'
CREATE VIEW [production].[product_and_description] 
WITH SCHEMABINDING 
AS 
-- View (indexed or standard) to display products and product descriptions by language.
SELECT 
    p.[product_id] 
    ,p.[name] 
    ,pm.[name] AS [product_model] 
    ,pmx.[culture_id] 
    ,pd.[description] 
FROM [production].[product] p 
    INNER JOIN [production].[product_model] pm 
    ON p.[product_model_id] = pm.[product_model_id] 
    INNER JOIN [production].[product_model_product_description_culture] pmx 
    ON pm.[product_model_id] = pmx.[product_model_id] 
    INNER JOIN [production].[product_description] pd 
    ON pmx.[product_description_id] = pd.[product_description_id];
' 
GO
SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[production].[product_and_description]') AND name = N'IX_product_and_description')
CREATE UNIQUE CLUSTERED INDEX [IX_product_and_description] ON [production].[product_and_description]
(
    [culture_id] ASC,
    [product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'VIEW',N'product_and_description', N'INDEX',N'IX_product_and_description'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Clustered index on the view product_and_description.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'VIEW',@level1name=N'product_and_description', @level2type=N'INDEX',@level2name=N'IX_product_and_description'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'VIEW',N'product_and_description', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'product names and descriptions. product descriptions are provided in multiple languages.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'VIEW',@level1name=N'product_and_description'
GO
