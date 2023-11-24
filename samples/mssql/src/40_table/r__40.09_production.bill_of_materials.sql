/****** Object:  Table [production].[bill_of_materials]    Script Date: 16/11/2023 08:45:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT 1 FROM sys.objects WHERE object_id = OBJECT_ID(N'[production].[bill_of_materials]') AND type in (N'U'))
BEGIN
CREATE TABLE [production].[bill_of_materials](
    [bill_of_materials_id] [int] IDENTITY(1,1) NOT NULL,
    [product_assembly_id] [int] NULL,
    [component_id] [int] NOT NULL,
    [start_date] [datetime] NOT NULL,
    [end_date] [datetime] NULL,
    [unit_measure_code] [nchar](3) NOT NULL,
    [bom_level] [smallint] NOT NULL,
    [per_assembly_qty] [decimal](8, 2) NOT NULL,
    [modified_date] [datetime] NOT NULL
) ON [PRIMARY]
END
GO
/****** Object:  Index [AK_bill_of_materials_product_assembly_id_component_id_start_date]    Script Date: 16/11/2023 08:45:05 ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[production].[bill_of_materials]') AND name = N'AK_bill_of_materials_product_assembly_id_component_id_start_date')
CREATE UNIQUE CLUSTERED INDEX [AK_bill_of_materials_product_assembly_id_component_id_start_date] ON [production].[bill_of_materials]
(
    [product_assembly_id] ASC,
    [component_id] ASC,
    [start_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [IX_bill_of_materials_unit_measure_code]    Script Date: 16/11/2023 08:45:05 ******/
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE object_id = OBJECT_ID(N'[production].[bill_of_materials]') AND name = N'IX_bill_of_materials_unit_measure_code')
CREATE NONCLUSTERED INDEX [IX_bill_of_materials_unit_measure_code] ON [production].[bill_of_materials]
(
    [unit_measure_code] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'bill_of_materials', N'COLUMN',N'bill_of_materials_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Primary key for bill_of_materials records.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'bill_of_materials', @level2type=N'COLUMN',@level2name=N'bill_of_materials_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'bill_of_materials', N'COLUMN',N'product_assembly_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Parent product identification number. Foreign key to product.product_id.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'bill_of_materials', @level2type=N'COLUMN',@level2name=N'product_assembly_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'bill_of_materials', N'COLUMN',N'component_id'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'component identification number. Foreign key to product.product_id.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'bill_of_materials', @level2type=N'COLUMN',@level2name=N'component_id'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'bill_of_materials', N'COLUMN',N'start_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the component started being used in the assembly item.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'bill_of_materials', @level2type=N'COLUMN',@level2name=N'start_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'bill_of_materials', N'COLUMN',N'end_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date the component stopped being used in the assembly item.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'bill_of_materials', @level2type=N'COLUMN',@level2name=N'end_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'bill_of_materials', N'COLUMN',N'unit_measure_code'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Standard code identifying the unit of measure for the quantity.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'bill_of_materials', @level2type=N'COLUMN',@level2name=N'unit_measure_code'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'bill_of_materials', N'COLUMN',N'bom_level'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Indicates the depth the component is from its parent (Assembly_id).' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'bill_of_materials', @level2type=N'COLUMN',@level2name=N'bom_level'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'bill_of_materials', N'COLUMN',N'per_assembly_qty'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'quantity of the component needed to create the assembly.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'bill_of_materials', @level2type=N'COLUMN',@level2name=N'per_assembly_qty'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'bill_of_materials', N'COLUMN',N'modified_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Date and time the record was last updated.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'bill_of_materials', @level2type=N'COLUMN',@level2name=N'modified_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'bill_of_materials', N'INDEX',N'AK_bill_of_materials_product_assembly_id_component_id_start_date'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Clustered index.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'bill_of_materials', @level2type=N'INDEX',@level2name=N'AK_bill_of_materials_product_assembly_id_component_id_start_date'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'bill_of_materials', N'INDEX',N'IX_bill_of_materials_unit_measure_code'))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Nonclustered index.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'bill_of_materials', @level2type=N'INDEX',@level2name=N'IX_bill_of_materials_unit_measure_code'
GO
IF NOT EXISTS (SELECT 1 FROM sys.fn_listextendedproperty(N'MS_Description' , N'SCHEMA',N'production', N'TABLE',N'bill_of_materials', NULL,NULL))
    EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Items required to make bicycles and bicycle subassemblies. It identifies the heirarchical relationship between a parent product and its components.' , @level0type=N'SCHEMA',@level0name=N'production', @level1type=N'TABLE',@level1name=N'bill_of_materials'
GO
