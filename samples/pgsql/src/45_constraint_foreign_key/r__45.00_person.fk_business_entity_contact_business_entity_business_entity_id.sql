DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'person'
                           AND tc.table_name = 'business_entity_contact'
                           AND tc.constraint_name = 'fk_business_entity_contact_business_entity_business_entity_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE person.business_entity_contact
        ADD CONSTRAINT "fk_business_entity_contact_business_entity_business_entity_id"
        FOREIGN KEY (business_entity_id)
        REFERENCES person.business_entity(business_entity_id);
    END IF;
END$$
