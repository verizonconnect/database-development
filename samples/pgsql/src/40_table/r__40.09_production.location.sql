CREATE TABLE IF NOT EXISTS production.location(
    location_id SERIAL NOT NULL
   ,name common.name NOT NULL
   ,cost_rate NUMERIC NOT NULL DEFAULT (0.00)
   ,availability DECIMAL(8, 2) NOT NULL DEFAULT (0.00)
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);

COMMENT ON TABLE production.location IS 'product inventory and manufacturing locations.';
COMMENT ON COLUMN production.location.location_id IS 'Primary key for location records.';
COMMENT ON COLUMN production.location.name IS 'location description.';
COMMENT ON COLUMN production.location.cost_rate IS 'Standard hourly cost of the manufacturing location.';
COMMENT ON COLUMN production.location.availability IS 'Work capacity (in hours) of the manufacturing location.';