CREATE TABLE IF NOT EXISTS person.business_entity_address(
    business_entity_id INT NOT NULL
   ,address_id INT NOT NULL
   ,address_type_id INT NOT NULL
   ,rowguid uuid NOT NULL DEFAULT (common.uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);
COMMENT ON TABLE person.business_entity_address IS 'Cross-reference table mapping customers, vendors, and employees to their addresses.';
COMMENT ON COLUMN person.business_entity_address.business_entity_id IS 'Primary key. foreign key to business_entity.business_entity_id.';
COMMENT ON COLUMN person.business_entity_address.address_id IS 'Primary key. foreign key to address.address_id.';
COMMENT ON COLUMN person.business_entity_address.address_type_id IS 'Primary key. foreign key to address_type.address_type_id.';