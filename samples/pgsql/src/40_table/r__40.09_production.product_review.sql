CREATE TABLE IF NOT EXISTS production.product_review(
    product_review_id SERIAL NOT NULL
   ,product_id INT NOT NULL
   ,reviewer_name common.name NOT NULL
   ,review_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
   ,email_address VARCHAR(50) NOT NULL
   ,rating INT NOT NULL
   ,comments VARCHAR(3850)
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
  
COMMENT ON TABLE production.product_review IS 'Customer reviews of products they have purchase_d.';
COMMENT ON COLUMN production.product_review.product_review_id IS 'Primary key for product_review records.';
COMMENT ON COLUMN production.product_review.product_id IS 'product identification number. foreign key to product.product_id.';
COMMENT ON COLUMN production.product_review.reviewer_name IS 'name of the reviewer.';
COMMENT ON COLUMN production.product_review.review_date IS 'Date review was submitted.';
COMMENT ON COLUMN production.product_review.email_address IS 'Reviewer''s e-mail address.';
COMMENT ON COLUMN production.product_review.rating IS 'product rating given by the reviewer. scale is 1 to 5 with 5 as the highest rating.';
COMMENT ON COLUMN production.product_review.comments IS 'Reviewer''s comments';