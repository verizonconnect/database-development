CREATE TABLE IF NOT EXISTS human_resources.department(
    department_id SERIAL NOT NULL
   ,name common.name NOT NULL
   ,group_name common.name NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);

COMMENT ON TABLE human_resources.department IS 'Lookup table containing the departments within the adventure works cycles company.';
COMMENT ON COLUMN human_resources.department.department_id IS 'Primary key for department records.';
COMMENT ON COLUMN human_resources.department.name IS 'name of the department.';
COMMENT ON COLUMN human_resources.department.group_name IS 'name of the group to which the department belongs.';