CREATE TABLE IF NOT EXISTS production.product(
    product_id SERIAL NOT NULL
   ,name common.name NOT NULL
   ,product_number VARCHAR(25) NOT NULL
   ,make_flag common.flag NOT NULL DEFAULT (true)
   ,finished_goods_flag common.flag NOT NULL DEFAULT (true)
   ,colour VARCHAR(15) NULL
   ,safety_stock_level SMALLINT NOT NULL
   ,reorder_point SMALLINT NOT NULL
   ,standard_cost NUMERIC NOT NULL
   ,list_price NUMERIC NOT NULL
   ,size VARCHAR(5) NULL
   ,size_unit_measure_code char(3) NULL
   ,weight_unit_measure_code char(3) NULL
   ,weight DECIMAL(8, 2) NULL
   ,days_to_manufacture INT NOT NULL
   ,product_line char(2) NULL
   ,class char(2) NULL
   ,style char(2) NULL
   ,product_sub_category_id INT NULL
   ,product_model_id INT NULL
   ,sell_start_date TIMESTAMP NOT NULL
   ,sell_end_date TIMESTAMP NULL
   ,discontinued_date TIMESTAMP NULL
   ,rowguid uuid NOT NULL DEFAULT (common.uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
  
COMMENT ON TABLE production.product IS 'products sold or used in the manfacturing of sold products.';
COMMENT ON COLUMN production.product.product_id IS 'Primary key for product records.';
COMMENT ON COLUMN production.product.name IS 'name of the product.';
COMMENT ON COLUMN production.product.product_number IS 'Unique product identification number.';
COMMENT ON COLUMN production.product.make_flag IS '0 = product is purchase_d, 1 = product is manufactured in-house.';
COMMENT ON COLUMN production.product.finished_goods_flag IS '0 = product is not a salable item. 1 = product is salable.';
COMMENT ON COLUMN production.product.colour IS 'product colour.';
COMMENT ON COLUMN production.product.safety_stock_level IS 'Minimum inventory quantity.';
COMMENT ON COLUMN production.product.reorder_point IS 'Inventory level that triggers a purchase order or work order.';
COMMENT ON COLUMN production.product.standard_cost IS 'Standard cost of the product.';
COMMENT ON COLUMN production.product.list_price IS 'Selling price.';
COMMENT ON COLUMN production.product.size IS 'product size.';
COMMENT ON COLUMN production.product.size_unit_measure_code IS 'Unit of measure for size column.';
COMMENT ON COLUMN production.product.weight_unit_measure_code IS 'Unit of measure for weight column.';
COMMENT ON COLUMN production.product.weight IS 'product weight.';
COMMENT ON COLUMN production.product.days_to_manufacture IS 'Number of days required to manufacture the product.';
COMMENT ON COLUMN production.product.product_line IS 'R = road, M = mountain, T = touring, S = standard';
COMMENT ON COLUMN production.product.class IS 'H = high, M = medium, L = low';
COMMENT ON COLUMN production.product.style IS 'W = womens, M = mens, U = universal';
COMMENT ON COLUMN production.product.product_sub_category_id IS 'product is a member of this product subcategory. foreign key to product_sub_category.product_sub_category_id.';
COMMENT ON COLUMN production.product.product_model_id IS 'product is a member of this product model. foreign key to product_model.product_model_id.';
COMMENT ON COLUMN production.product.sell_start_date IS 'Date the product was available for sale.';
COMMENT ON COLUMN production.product.sell_end_date IS 'Date the product was no longer available for sale.';
COMMENT ON COLUMN production.product.discontinued_date IS 'Date the product was discontinued.';