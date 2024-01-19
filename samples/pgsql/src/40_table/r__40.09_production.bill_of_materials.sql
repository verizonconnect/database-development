CREATE TABLE IF NOT EXISTS production.bill_of_materials(
    bill_of_materials_id SERIAL NOT NULL
   ,product_assembly_id INT NULL
   ,component_id INT NOT NULL
   ,start_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
   ,end_date TIMESTAMP NULL
   ,unit_measure_code CHAR(3) NOT NULL
   ,bom_level SMALLINT NOT NULL
   ,per_assembly_qty DECIMAL(8, 2) NOT NULL DEFAULT (1.00)
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);

COMMENT ON TABLE production.bill_of_materials IS 'Items required to make bicycles and bicycle subassemblies. it identifies the heirarchical relationship between a parent product and its components.';
COMMENT ON COLUMN production.bill_of_materials.bill_of_materials_id IS 'Primary key for bill_of_materials records.';
COMMENT ON COLUMN production.bill_of_materials.product_assembly_id IS 'Parent product identification number. foreign key to product.product_id.';
COMMENT ON COLUMN production.bill_of_materials.component_id IS 'Component identification number. foreign key to product.product_id.';
COMMENT ON COLUMN production.bill_of_materials.start_date IS 'Date the component started being used in the assembly item.';
COMMENT ON COLUMN production.bill_of_materials.end_date IS 'Date the component stopped being used in the assembly item.';
COMMENT ON COLUMN production.bill_of_materials.unit_measure_code IS 'Standard code identifying the unit of measure for the quantity.';
COMMENT ON COLUMN production.bill_of_materials.bom_level IS 'Indicates the depth the component is from its parent (assembly_id).';
COMMENT ON COLUMN production.bill_of_materials.per_assembly_qty IS 'quantity of the component needed to create the assembly.';