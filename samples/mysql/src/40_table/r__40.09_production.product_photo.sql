CREATE TABLE IF NOT EXISTS production.product_photo(
    product_photo_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for product_photo records.'
   ,thumb_nail_photo BLOB NULL COMMENT 'Small image of the product.'
   ,thumb_nail_photo_file_name VARCHAR(50) NULL COMMENT 'Small image file name.'
   ,large_photo BLOB NULL COMMENT 'Large image of the product.'
   ,large_photo_file_name VARCHAR(50) NULL COMMENT 'Large image file name.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_product_photo` PRIMARY KEY (product_photo_id)
)
COMMENT 'product images.';
