CREATE TABLE IF NOT EXISTS sales.credit_card(
    credit_card_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for credit_card records.'
   ,card_type varchar(50) NOT NULL COMMENT 'Credit card name.'
   ,card_number varchar(25) NOT NULL COMMENT 'Credit card number.'
   ,exp_month SMALLINT NOT NULL COMMENT 'Credit card expiration month.'
   ,exp_year SMALLINT NOT NULL COMMENT 'Credit card expiration year.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_credit_card` PRIMARY KEY (credit_card_id)
)
COMMENT 'Customer credit card information.';
