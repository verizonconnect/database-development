CREATE TABLE IF NOT EXISTS sales.sales_tax_rate(
    sales_tax_rate_id SERIAL NOT NULL
   ,state_province_id INT NOT NULL
   ,tax_type SMALLINT NOT NULL
   ,tax_rate NUMERIC NOT NULL DEFAULT (0.00)
   ,name common.name NOT NULL
   ,rowguid uuid NOT NULL DEFAULT (uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);
COMMENT ON TABLE sales.sales_tax_rate IS 'Tax _rate lookup table.';
COMMENT ON COLUMN sales.sales_tax_rate.sales_tax_rate_id IS 'Primary key for sales_tax_rate records.';
COMMENT ON COLUMN sales.sales_tax_rate.state_province_id IS 'State, province, or country/region the sales tax applies to.';
COMMENT ON COLUMN sales.sales_tax_rate.tax_type IS '1 = tax applied to retail transactions, 2 = tax applied to wholesale transactions, 3 = tax applied to all sales (retail and wholesale) transactions.';
COMMENT ON COLUMN sales.sales_tax_rate.tax_rate IS 'Tax _rate amount.';
COMMENT ON COLUMN sales.sales_tax_rate.name IS 'Tax _rate description.';