CREATE TABLE IF NOT EXISTS sales.special_offer_product(
    special_offer_id INT NOT NULL COMMENT 'Primary key for special_offer_product records.'
   ,product_id INT NOT NULL COMMENT 'product identification number. foreign key to product.product_id.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_special_offer_product` PRIMARY KEY (special_offer_id, product_id)
)
COMMENT 'Cross-reference table mapping products to special offer discounts.';
