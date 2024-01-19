SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(22);

SELECT tables_are('person', ARRAY[
    'address',
    'address_type',
    'business_entity',
    'business_entity_address',
    'business_entity_contact',
    'contact_type',
    'country_region',
    'email_address',
    'password',
    'person',
    'person_phone',
    'phone_number_type',
    'state_province'
]);

SELECT table_owner_is('person','address','postgres','person.address owner is postgres');
SELECT table_owner_is('person','address_type','postgres','person.address_type owner is postgres');
SELECT table_owner_is('person','business_entity','postgres','person.business_entity owner is postgres');
SELECT table_owner_is('person','business_entity_address','postgres','person.business_entity_address owner is postgres');
SELECT table_owner_is('person','business_entity_contact','postgres','person.business_entity_contact owner is postgres');
SELECT table_owner_is('person','contact_type','postgres','person.contact_type owner is postgres');
SELECT table_owner_is('person','country_region','postgres','person.country_region owner is postgres');
SELECT table_owner_is('person','email_address','postgres','person.email_address owner is postgres');
SELECT table_owner_is('person','password','postgres','person.password owner is postgres');
SELECT table_owner_is('person','person','postgres','person.person owner is postgres');
SELECT table_owner_is('person','person_phone','postgres','person.person_phone owner is postgres');
SELECT table_owner_is('person','phone_number_type','postgres','person.phone_number_type owner is postgres');
SELECT table_owner_is('person','state_province','postgres','person.state_province owner is postgres');
SELECT sequences_are('person', ARRAY[
    'address_address_id_seq',
    'address_type_address_type_id_seq',
    'business_entity_business_entity_id_seq',
    'contact_type_contact_type_id_seq',
    'email_address_email_address_id_seq',
    'phone_number_type_phone_number_type_id_seq',
    'state_province_state_province_id_seq'
]);

SELECT sequence_owner_is('person','address_address_id_seq','postgres','person.address_address_id_seq owner is postgres');
SELECT sequence_owner_is('person','address_type_address_type_id_seq','postgres','person.address_type_address_type_id_seq owner is postgres');
SELECT sequence_owner_is('person','business_entity_business_entity_id_seq','postgres','person.business_entity_business_entity_id_seq owner is postgres');
SELECT sequence_owner_is('person','contact_type_contact_type_id_seq','postgres','person.contact_type_contact_type_id_seq owner is postgres');
SELECT sequence_owner_is('person','email_address_email_address_id_seq','postgres','person.email_address_email_address_id_seq owner is postgres');
SELECT sequence_owner_is('person','phone_number_type_phone_number_type_id_seq','postgres','person.phone_number_type_phone_number_type_id_seq owner is postgres');
SELECT sequence_owner_is('person','state_province_state_province_id_seq','postgres','person.state_province_state_province_id_seq owner is postgres');

SELECT * FROM finish();
ROLLBACK;
