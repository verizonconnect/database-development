CREATE TABLE IF NOT EXISTS sales.sales_tax_rate(
    sales_tax_rate_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for sales_tax_rate records.'
   ,state_province_id INT NOT NULL COMMENT 'State, province, or country/region the sales tax applies to.'
   ,tax_type SMALLINT NOT NULL COMMENT '1 = tax applied to retail transactions, 2 = tax applied to wholesale transactions, 3 = tax applied to all sales (retail and wholesale) transactions.'
   ,tax_rate DECIMAL(19,4) NOT NULL DEFAULT (0.00) COMMENT 'Tax _rate amount.'
   ,name VARCHAR(50) NOT NULL COMMENT 'Tax _rate description.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_sales_tax_rate` PRIMARY KEY (sales_tax_rate_id)
)
COMMENT 'Tax _rate lookup table.';
