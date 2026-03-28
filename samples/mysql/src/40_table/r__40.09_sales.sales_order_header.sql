CREATE TABLE IF NOT EXISTS sales.sales_order_header(
    sales_order_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key.'
   ,revision_number SMALLINT NOT NULL DEFAULT (0) COMMENT 'Incremental number to track changes to the sales order over time.'
   ,order_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP()) COMMENT 'Dates the sales order was created.'
   ,due_date DATETIME NOT NULL COMMENT 'Date the order is due to the customer.'
   ,ship_date DATETIME NULL COMMENT 'Date the order was shipped to the customer.'
   ,status SMALLINT NOT NULL DEFAULT (1) COMMENT 'Order current status. 1 = in process; 2 = approved; 3 = backordered; 4 = rejected; 5 = shipped; 6 = cancelled'
   ,online_order_flag BOOLEAN NOT NULL DEFAULT (true) COMMENT '0 = order placed by sales person. 1 = order placed online by customer.'
   ,sales_order_number VARCHAR(23) COMMENT 'Unique sales order identification number.'
   ,purchase_order_number VARCHAR(25) NULL COMMENT 'Customer purchase order number reference.'
   ,account_number VARCHAR(15) NULL COMMENT 'Financial accounting number reference.'
   ,customer_id INT NOT NULL COMMENT 'Customer identification number. foreign key to customer.business_entity_id.'
   ,sales_person_id INT NULL COMMENT 'Sales person who created the sales order. foreign key to sales_person.business_entity_id.'
   ,territory_id INT NULL COMMENT 'Territory in which the sale was made. foreign key to sales_territory.sales_territory_id.'
   ,bill_to_address_id INT NOT NULL COMMENT 'Customer billing address. foreign key to address.address_id.'
   ,ship_to_address_id INT NOT NULL COMMENT 'Customer shipping address. foreign key to address.address_id.'
   ,ship_method_id INT NOT NULL COMMENT 'Shipping method. foreign key to ship_method.ship_method_id.'
   ,credit_card_id INT NULL COMMENT 'Credit card identification number. foreign key to credit_card.credit_card_id.'
   ,credit_card_approval_code varchar(15) NULL COMMENT 'Approval code provided by the credit card company.'
   ,currency_rate_id INT NULL COMMENT 'Currency exchange _rate used. foreign key to currency_rate.currency_rate_id.'
   ,sub_total DECIMAL(19,4) NOT NULL DEFAULT (0.00) COMMENT 'Sales subtotal. computed as SUM(sales_order_detail.line_total)for the appropriate sales_order_id.'
   ,tax_amt DECIMAL(19,4) NOT NULL DEFAULT (0.00) COMMENT 'Tax amount.'
   ,freight DECIMAL(19,4) NOT NULL DEFAULT (0.00) COMMENT 'Shipping cost.'
   ,total_due DECIMAL(19,4) COMMENT 'Total due from customer. computed as subtotal + tax_amt + freight.'
   ,comment varchar(128) NULL COMMENT 'Sales representative comments.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_sales_order_header` PRIMARY KEY (sales_order_id)
)
COMMENT 'General sales order information.';
