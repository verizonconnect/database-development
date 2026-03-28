CREATE TABLE IF NOT EXISTS production.product(
    product_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for product records.'
   ,name VARCHAR(50) NOT NULL COMMENT 'name of the product.'
   ,product_number VARCHAR(25) NOT NULL COMMENT 'Unique product identification number.'
   ,make_flag BOOLEAN NOT NULL DEFAULT (true) COMMENT '0 = product is purchase_d, 1 = product is manufactured in-house.'
   ,finished_goods_flag BOOLEAN NOT NULL DEFAULT (true) COMMENT '0 = product is not a salable item. 1 = product is salable.'
   ,colour VARCHAR(15) NULL COMMENT 'product colour.'
   ,safety_stock_level SMALLINT NOT NULL COMMENT 'Minimum inventory quantity.'
   ,reorder_point SMALLINT NOT NULL COMMENT 'Inventory level that triggers a purchase order or work order.'
   ,standard_cost DECIMAL(19,4) NOT NULL COMMENT 'Standard cost of the product.'
   ,list_price DECIMAL(19,4) NOT NULL COMMENT 'Selling price.'
   ,size VARCHAR(5) NULL COMMENT 'product size.'
   ,size_unit_measure_code char(3) NULL COMMENT 'Unit of measure for size column.'
   ,weight_unit_measure_code char(3) NULL COMMENT 'Unit of measure for weight column.'
   ,weight DECIMAL(8, 2) NULL COMMENT 'product weight.'
   ,days_to_manufacture INT NOT NULL COMMENT 'Number of days required to manufacture the product.'
   ,product_line char(2) NULL COMMENT 'R = road, M = mountain, T = touring, S = standard'
   ,class char(2) NULL COMMENT 'H = high, M = medium, L = low'
   ,style char(2) NULL COMMENT 'W = womens, M = mens, U = universal'
   ,product_sub_category_id INT NULL COMMENT 'product is a member of this product subcategory. foreign key to product_sub_category.product_sub_category_id.'
   ,product_model_id INT NULL COMMENT 'product is a member of this product model. foreign key to product_model.product_model_id.'
   ,sell_start_date DATETIME NOT NULL COMMENT 'Date the product was available for sale.'
   ,sell_end_date DATETIME NULL COMMENT 'Date the product was no longer available for sale.'
   ,discontinued_date DATETIME NULL COMMENT 'Date the product was discontinued.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_product` PRIMARY KEY (product_id)
)
COMMENT 'products sold or used in the manfacturing of sold products.';
