CREATE TABLE IF NOT EXISTS sales.special_offer(
    special_offer_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for special_offer records.'
   ,description varchar(255) NOT NULL COMMENT 'Discount description.'
   ,discount_pct DECIMAL(19,4) NOT NULL DEFAULT (0.00) COMMENT 'Discount precentage.'
   ,type varchar(50) NOT NULL COMMENT 'Discount type category.'
   ,category varchar(50) NOT NULL COMMENT 'Group the discount applies to such as reseller or customer.'
   ,start_date DATETIME NOT NULL COMMENT 'Discount start date.'
   ,end_date DATETIME NOT NULL COMMENT 'Discount end date.'
   ,min_qty INT NOT NULL DEFAULT (0) COMMENT 'Minimum discount percent allowed.'
   ,max_qty INT NULL COMMENT 'Maximum discount percent allowed.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_special_offer` PRIMARY KEY (special_offer_id)
)
COMMENT 'Sale discounts lookup table.';
