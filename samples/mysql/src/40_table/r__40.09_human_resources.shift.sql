CREATE TABLE IF NOT EXISTS human_resources.shift(
    shift_id INT AUTO_INCREMENT NOT NULL COMMENT 'Primary key for shift records.'
   ,name VARCHAR(50) NOT NULL COMMENT 'shift description.'
   ,start_time time NOT NULL COMMENT 'shift start time.'
   ,end_time time NOT NULL COMMENT 'shift end time.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())

   ,CONSTRAINT `pk_shift` PRIMARY KEY (shift_id)
)
COMMENT 'Work shift lookup table.';
