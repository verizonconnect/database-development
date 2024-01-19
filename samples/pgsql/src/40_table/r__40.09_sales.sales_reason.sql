CREATE TABLE IF NOT EXISTS sales.sales_reason(
    sales_reason_id SERIAL NOT NULL
   ,name common.name NOT NULL
   ,reason_type common.name NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);
COMMENT ON TABLE sales.sales_reason IS 'Lookup table of customer purchase reasons.';
COMMENT ON COLUMN sales.sales_reason.sales_reason_id IS 'Primary key for sales_reason records.';
COMMENT ON COLUMN sales.sales_reason.name IS 'Sales reason description.';
COMMENT ON COLUMN sales.sales_reason.reason_type IS 'Category the sales reason belongs to.';