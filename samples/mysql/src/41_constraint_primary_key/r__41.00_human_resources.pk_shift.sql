DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'human_resources'
                           AND tc.table_name = 'shift '
                           AND tc.constraint_name = 'pk_shift'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE human_resources.shift 
        ADD CONSTRAINT "pk_shift" 
        PRIMARY KEY (shift_id);
    END IF;
END$$
