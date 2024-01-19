CREATE TABLE IF NOT EXISTS production.culture(
    culture_id CHAR(6) NOT NULL
   ,name common.name NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);

COMMENT ON TABLE production.culture IS 'Lookup table containing the languages in which some adventure_works data is stored.';
COMMENT ON COLUMN production.culture.culture_id IS 'Primary key for culture records.';
COMMENT ON COLUMN production.culture.name IS 'culture description.';