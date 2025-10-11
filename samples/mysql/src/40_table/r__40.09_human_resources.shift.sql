CREATE TABLE IF NOT EXISTS human_resources.shift(
    shift_id       INT         NOT NULL COMMENT 'Primary key for shift records.'
   ,name_desc      VARCHAR(50) NOT NULL COMMENT 'shift name description.'
   ,start_h24_time TIME        NOT NULL COMMENT 'shift start time in 24h format.'
   ,end_h24_time   TIME        NOT NULL COMMENT 'shift end time in 24h format.'
   ,modified_date  TIMESTAMP   NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
) COMMENT 'Work shift lookup table.';
