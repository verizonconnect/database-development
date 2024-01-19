CREATE TABLE IF NOT EXISTS sales.sales_order_header(
    sales_order_id SERIAL NOT NULL
   ,revision_number SMALLINT NOT NULL DEFAULT (0)
   ,order_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
   ,due_date TIMESTAMP NOT NULL
   ,ship_date TIMESTAMP NULL
   ,status SMALLINT NOT NULL DEFAULT (1)
   ,online_order_flag common.flag NOT NULL DEFAULT (true)
   ,sales_order_number VARCHAR(23)
   ,purchase_order_number common.order_number NULL
   ,account_number common.account_number NULL
   ,customer_id INT NOT NULL
   ,sales_person_id INT NULL
   ,territory_id INT NULL
   ,bill_to_address_id INT NOT NULL
   ,ship_to_address_id INT NOT NULL
   ,ship_method_id INT NOT NULL
   ,credit_card_id INT NULL
   ,credit_card_approval_code varchar(15) NULL
   ,currency_rate_id INT NULL
   ,sub_total NUMERIC NOT NULL DEFAULT (0.00)
   ,tax_amt NUMERIC NOT NULL DEFAULT (0.00)
   ,freight NUMERIC NOT NULL DEFAULT (0.00)
   ,total_due NUMERIC
   ,comment varchar(128) NULL
   ,rowguid uuid NOT NULL DEFAULT (common.uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);
COMMENT ON TABLE sales.sales_order_header IS 'General sales order information.';
COMMENT ON COLUMN sales.sales_order_header.sales_order_id IS 'Primary key.';
COMMENT ON COLUMN sales.sales_order_header.revision_number IS 'Incremental number to track changes to the sales order over time.';
COMMENT ON COLUMN sales.sales_order_header.order_date IS 'Dates the sales order was created.';
COMMENT ON COLUMN sales.sales_order_header.due_date IS 'Date the order is due to the customer.';
COMMENT ON COLUMN sales.sales_order_header.ship_date IS 'Date the order was shipped to the customer.';
COMMENT ON COLUMN sales.sales_order_header.status IS 'Order current status. 1 = in process; 2 = approved; 3 = backordered; 4 = rejected; 5 = shipped; 6 = cancelled';
COMMENT ON COLUMN sales.sales_order_header.online_order_flag IS '0 = order placed by sales person. 1 = order placed online by customer.';
--  COMMENT ON COLUMN sales.sales_order_header.sales_order_number IS 'Unique sales order identification number.';
COMMENT ON COLUMN sales.sales_order_header.purchase_order_number IS 'Customer purchase order number reference.';
COMMENT ON COLUMN sales.sales_order_header.account_number IS 'Financial accounting number reference.';
COMMENT ON COLUMN sales.sales_order_header.customer_id IS 'Customer identification number. foreign key to customer.business_entity_id.';
COMMENT ON COLUMN sales.sales_order_header.sales_person_id IS 'Sales person who created the sales order. foreign key to sales_person.business_entity_id.';
COMMENT ON COLUMN sales.sales_order_header.territory_id IS 'Territory in which the sale was made. foreign key to sales_territory.sales_territory_id.';
COMMENT ON COLUMN sales.sales_order_header.bill_to_address_id IS 'Customer billing address. foreign key to address.address_id.';
COMMENT ON COLUMN sales.sales_order_header.ship_to_address_id IS 'Customer shipping address. foreign key to address.address_id.';
COMMENT ON COLUMN sales.sales_order_header.ship_method_id IS 'Shipping method. foreign key to ship_method.ship_method_id.';
COMMENT ON COLUMN sales.sales_order_header.credit_card_id IS 'Credit card identification number. foreign key to credit_card.credit_card_id.';
COMMENT ON COLUMN sales.sales_order_header.credit_card_approval_code IS 'Approval code provided by the credit card company.';
COMMENT ON COLUMN sales.sales_order_header.currency_rate_id IS 'Currency exchange _rate used. foreign key to currency_rate.currency_rate_id.';
COMMENT ON COLUMN sales.sales_order_header.sub_total IS 'Sales subtotal. computed as SUM(sales_order_detail.line_total)for the appropriate sales_order_id.';
COMMENT ON COLUMN sales.sales_order_header.tax_amt IS 'Tax amount.';
COMMENT ON COLUMN sales.sales_order_header.freight IS 'Shipping cost.';
COMMENT ON COLUMN sales.sales_order_header.total_due IS 'Total due from customer. computed as subtotal + tax_amt + freight.';
COMMENT ON COLUMN sales.sales_order_header.comment IS 'Sales representative comments.';