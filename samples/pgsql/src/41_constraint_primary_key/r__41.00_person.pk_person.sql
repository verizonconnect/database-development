DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'person'
                           AND tc.table_name = 'person'
                           AND tc.constraint_name = 'pk_person'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE person.person
        ADD CONSTRAINT "pk_person"
        PRIMARY KEY (business_entity_id);
    END IF;
END$$
