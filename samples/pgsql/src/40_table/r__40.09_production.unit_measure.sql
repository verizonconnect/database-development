CREATE TABLE IF NOT EXISTS production.unit_measure(
    unit_measure_code char(3) NOT NULL
   ,name common.name NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
  
COMMENT ON TABLE production.unit_measure IS 'Unit of measure lookup table.';
COMMENT ON COLUMN production.unit_measure.unit_measure_code IS 'Primary key.';
COMMENT ON COLUMN production.unit_measure.name IS 'Unit of measure description.';