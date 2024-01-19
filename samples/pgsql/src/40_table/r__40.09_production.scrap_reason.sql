CREATE TABLE IF NOT EXISTS production.scrap_reason(
    scrap_reason_id SERIAL NOT NULL
   ,name common.name NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
  
COMMENT ON TABLE production.scrap_reason IS 'Manufacturing failure reasons lookup table.';
COMMENT ON COLUMN production.scrap_reason.scrap_reason_id IS 'Primary key for scrap_reason records.';
COMMENT ON COLUMN production.scrap_reason.name IS 'Failure description.';