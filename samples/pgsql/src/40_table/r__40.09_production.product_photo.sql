CREATE TABLE IF NOT EXISTS production.product_photo(
    product_photo_id SERIAL NOT NULL
   ,thumb_nail_photo bytea NULL
   ,thumb_nail_photo_file_name VARCHAR(50) NULL
   ,large_photo bytea NULL
   ,large_photo_file_name VARCHAR(50) NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
  
COMMENT ON TABLE production.product_photo IS 'product images.';
COMMENT ON COLUMN production.product_photo.product_photo_id IS 'Primary key for product_photo records.';
COMMENT ON COLUMN production.product_photo.thumb_nail_photo IS 'Small image of the product.';
COMMENT ON COLUMN production.product_photo.thumb_nail_photo_file_name IS 'Small image file name.';
COMMENT ON COLUMN production.product_photo.large_photo IS 'Large image of the product.';
COMMENT ON COLUMN production.product_photo.large_photo_file_name IS 'Large image file name.';