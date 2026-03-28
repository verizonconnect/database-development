CREATE TABLE IF NOT EXISTS production.product_product_photo(
    product_id INT NOT NULL COMMENT 'product identification number. foreign key to product.product_id.'
   ,product_photo_id INT NOT NULL COMMENT 'product photo identification number. foreign key to product_photo.product_photo_id.'
   ,`primary` BOOLEAN NOT NULL DEFAULT (false)
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_product_product_photo` PRIMARY KEY (product_id, product_photo_id)
)
COMMENT 'Cross-reference table mapping products and product photos.';
