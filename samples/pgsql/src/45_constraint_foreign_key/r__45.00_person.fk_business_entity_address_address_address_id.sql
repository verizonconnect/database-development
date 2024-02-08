DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'person'
                           AND tc.table_name = 'business_entity_address'
                           AND tc.constraint_name = 'fk_business_entity_address_address_address_id'
                           AND tc.constraint_type = 'FOREIGN KEY')
    THEN
        ALTER TABLE person.business_entity_address
        ADD CONSTRAINT "fk_business_entity_address_address_address_id"
        FOREIGN KEY (address_id)
        REFERENCES person.address(address_id);
    END IF;
END$$
