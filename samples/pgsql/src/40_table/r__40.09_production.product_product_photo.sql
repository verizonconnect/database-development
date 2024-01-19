CREATE TABLE IF NOT EXISTS production.product_product_photo(
    product_id INT NOT NULL
   ,product_photo_id INT NOT NULL
   ,"primary" common.flag NOT NULL DEFAULT (false)
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
  
COMMENT ON TABLE production.product_product_photo IS 'Cross-reference table mapping products and product photos.';
COMMENT ON COLUMN production.product_product_photo.product_id IS 'product identification number. foreign key to product.product_id.';
COMMENT ON COLUMN production.product_product_photo.product_photo_id IS 'product photo identification number. foreign key to product_photo.product_photo_id.';
COMMENT ON COLUMN production.product_product_photo.primary IS '0 = photo is not the principal image. 1 = photo is the principal image.';