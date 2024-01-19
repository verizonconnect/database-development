CREATE TABLE IF NOT EXISTS sales.special_offer_product(
    special_offer_id INT NOT NULL
   ,product_id INT NOT NULL
   ,rowguid uuid NOT NULL DEFAULT (common.uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);
COMMENT ON TABLE sales.special_offer_product IS 'Cross-reference table mapping products to special offer discounts.';
COMMENT ON COLUMN sales.special_offer_product.special_offer_id IS 'Primary key for special_offer_product records.';
COMMENT ON COLUMN sales.special_offer_product.product_id IS 'product identification number. foreign key to product.product_id.';