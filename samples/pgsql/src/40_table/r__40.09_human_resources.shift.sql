CREATE TABLE IF NOT EXISTS human_resources.shift(
    shift_id SERIAL NOT NULL
   ,name common.name NOT NULL
   ,start_time time NOT NULL
   ,end_time time NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);

COMMENT ON TABLE human_resources.shift IS 'Work shift lookup table.';
COMMENT ON COLUMN human_resources.shift.shift_id IS 'Primary key for shift records.';
COMMENT ON COLUMN human_resources.shift.name IS 'shift description.';
COMMENT ON COLUMN human_resources.shift.start_time IS 'shift start time.';
COMMENT ON COLUMN human_resources.shift.end_time IS 'shift end time.';