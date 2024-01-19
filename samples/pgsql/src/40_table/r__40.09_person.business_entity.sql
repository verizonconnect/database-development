CREATE TABLE IF NOT EXISTS person.business_entity(
    business_entity_id  SERIAL 
   ,rowguid             uuid      NOT NULL DEFAULT (common.uuid_generate_v1())
   ,modified_date       TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);

COMMENT ON TABLE person.business_entity IS 'Source of the ID that connects vendors, customers, and employees with address and contact information.';
COMMENT ON COLUMN person.business_entity.business_entity_id IS 'Primary key for all customers, vendors, and employees.';