CREATE TABLE IF NOT EXISTS production.unit_measure(
    unit_measure_code char(3) NOT NULL COMMENT 'Primary key.'
   ,name VARCHAR(50) NOT NULL COMMENT 'Unit of measure description.'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_unit_measure` PRIMARY KEY (unit_measure_code)
)
COMMENT 'Unit of measure lookup table.';
