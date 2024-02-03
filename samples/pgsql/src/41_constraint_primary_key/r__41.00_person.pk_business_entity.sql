DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'person'
                           AND tc.table_name = 'business_entity'
                           AND tc.constraint_name = 'pk_business_entity'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE person.business_entity
        ADD CONSTRAINT "pk_business_entity"
        PRIMARY KEY (business_entity_id);
    END IF;
END$$
