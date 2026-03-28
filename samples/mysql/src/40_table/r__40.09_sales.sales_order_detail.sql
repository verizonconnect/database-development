CREATE TABLE IF NOT EXISTS sales.sales_order_detail(
    sales_order_id INT NOT NULL COMMENT 'Primary key. foreign key to sales_order_header.sales_order_id.'
   ,sales_order_detail_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key. one incremental unique number per product sold.'
   ,carrier_tracking_number varchar(25) NULL COMMENT 'Shipment tracking number supplied by the shipper.'
   ,order_qty SMALLINT NOT NULL COMMENT 'quantity ordered per product.'
   ,product_id INT NOT NULL COMMENT 'product sold to customer. foreign key to product.product_id.'
   ,special_offer_id INT NOT NULL COMMENT 'Promotional code. foreign key to special_offer.special_offer_id.'
   ,unit_price DECIMAL(19,4) NOT NULL COMMENT 'Selling price of a single product.'
   ,unit_price_discount DECIMAL(19,4) NOT NULL DEFAULT (0.0) COMMENT 'Discount amount.'
   ,line_total DECIMAL(19,4)
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_sales_order_detail` PRIMARY KEY (sales_order_detail_id)
)
COMMENT 'Individual products associated with a specific sales order. see sales_order_header.';
