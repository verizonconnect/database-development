CREATE TABLE IF NOT EXISTS production.illustration(
    illustration_id SERIAL NOT NULL
   ,diagram XML NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
  
COMMENT ON TABLE production.illustration IS 'Bicycle assembly diagrams.';
COMMENT ON COLUMN production.illustration.illustration_id IS 'Primary key for illustration records.';
COMMENT ON COLUMN production.illustration.diagram IS 'illustrations used in manufacturing instructions. stored as XML.';