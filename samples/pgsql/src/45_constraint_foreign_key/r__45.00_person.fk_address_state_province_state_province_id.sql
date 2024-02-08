DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'person'
                           AND tc.table_name = 'address'
                           AND tc.constraint_name = 'fk_address_state_province_state_province_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE person.address
        ADD CONSTRAINT "fk_address_state_province_state_province_id"
        FOREIGN KEY (state_province_id)
        REFERENCES person.state_province(state_province_id);
    END IF;
END$$
