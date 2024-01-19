CREATE TABLE IF NOT EXISTS purchasing.ship_method(
    ship_method_id SERIAL NOT NULL
   ,name common.name NOT NULL
   ,ship_base NUMERIC NOT NULL DEFAULT (0.00)
   ,ship_rate NUMERIC NOT NULL DEFAULT (0.00)
   ,rowguid uuid NOT NULL DEFAULT (common.uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (now() at time zone 'utc')
);

COMMENT ON TABLE purchasing.ship_method IS 'Shipping company lookup table.';
COMMENT ON COLUMN purchasing.ship_method.ship_method_id IS 'Primary key for ship_method records.';
COMMENT ON COLUMN purchasing.ship_method.name IS 'Shipping company name.';
COMMENT ON COLUMN purchasing.ship_method.ship_base IS 'Minimum shipping charge.';
COMMENT ON COLUMN purchasing.ship_method.ship_rate IS 'Shipping charge per pound.';