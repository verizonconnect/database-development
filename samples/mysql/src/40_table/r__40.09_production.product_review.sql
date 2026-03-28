CREATE TABLE IF NOT EXISTS production.product_review(
    product_review_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for product_review records.'
   ,product_id INT NOT NULL COMMENT 'product identification number. foreign key to product.product_id.'
   ,reviewer_name VARCHAR(50) NOT NULL COMMENT 'name of the reviewer.'
   ,review_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP()) COMMENT 'Date review was submitted.'
   ,email_address VARCHAR(50) NOT NULL COMMENT 'Reviewer\'s e-mail address.'
   ,rating INT NOT NULL COMMENT 'product rating given by the reviewer. scale is 1 to 5 with 5 as the highest rating.'
   ,comments VARCHAR(3850) COMMENT 'Reviewer\'s comments'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_product_review` PRIMARY KEY (product_review_id)
)
COMMENT 'Customer reviews of products they have purchase_d.';
