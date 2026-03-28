CREATE TABLE IF NOT EXISTS production.bill_of_materials(
    bill_of_materials_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for bill_of_materials records.'
   ,product_assembly_id INT NULL COMMENT 'Parent product identification number. foreign key to product.product_id.'
   ,component_id INT NOT NULL COMMENT 'Component identification number. foreign key to product.product_id.'
   ,start_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP()) COMMENT 'Date the component started being used in the assembly item.'
   ,end_date DATETIME NULL COMMENT 'Date the component stopped being used in the assembly item.'
   ,unit_measure_code CHAR(3) NOT NULL COMMENT 'Standard code identifying the unit of measure for the quantity.'
   ,bom_level SMALLINT NOT NULL COMMENT 'Indicates the depth the component is from its parent (assembly_id).'
   ,per_assembly_qty DECIMAL(8, 2) NOT NULL DEFAULT (1.00) COMMENT 'quantity of the component needed to create the assembly.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_bill_of_materials` PRIMARY KEY (bill_of_materials_id)
)
COMMENT 'Items required to make bicycles and bicycle subassemblies. it identifies the heirarchical relationship between a parent product and its components.';
