SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
    SELECT plan(4);

    -- assemble phase
    INSERT INTO person.business_entity (business_entity_id) VALUES (501);
    INSERT INTO person.person (business_entity_id, person_type, first_name, last_name)
    VALUES (501, 'EM', 'Jane', 'Doe');

    INSERT INTO human_resources.employee (
        business_entity_id, national_id_number, login_id, job_title
       ,birth_date, marital_status, gender, hire_date
    ) VALUES (501, 'NI501', 'jane@test.ie', 'Engineer', '1990-01-01', 'S', 'F', '2020-01-01');

    -- vendor contact setup
    INSERT INTO person.business_entity (business_entity_id) VALUES (502);
    INSERT INTO purchasing.vendor (business_entity_id, account_number, name, credit_rating)
    VALUES (502, 'VENDOR001', 'Test Vendor', 1);

    INSERT INTO person.business_entity (business_entity_id) VALUES (503);
    INSERT INTO person.person (business_entity_id, person_type, first_name, last_name)
    VALUES (503, 'VC', 'Bob', 'Smith');

    INSERT INTO person.contact_type (contact_type_id, name) VALUES (1, 'Sales Agent');
    INSERT INTO person.business_entity_contact (business_entity_id, person_id, contact_type_id)
    VALUES (502, 503, 1);

    -- store contact setup
    INSERT INTO person.business_entity (business_entity_id) VALUES (504);
    INSERT INTO sales.store (business_entity_id, name) VALUES (504, 'Test Store');

    INSERT INTO person.business_entity (business_entity_id) VALUES (505);
    INSERT INTO person.person (business_entity_id, person_type, first_name, last_name)
    VALUES (505, 'SC', 'Alice', 'Jones');

    INSERT INTO person.contact_type (contact_type_id, name) VALUES (2, 'Owner');
    INSERT INTO person.business_entity_contact (business_entity_id, person_id, contact_type_id)
    VALUES (504, 505, 2);

    -- consumer setup
    INSERT INTO person.business_entity (business_entity_id) VALUES (506);
    INSERT INTO person.person (business_entity_id, person_type, first_name, last_name)
    VALUES (506, 'IN', 'Charlie', 'Brown');

    INSERT INTO sales.customer (person_id, store_id) VALUES (506, NULL);

    -- act / assert phase

    -- Test 1: employee contact
    SELECT results_eq(
        $$SELECT first_name, last_name, job_title, business_entity_type
          FROM common.get_contact_information(501)$$
       ,$$VALUES ('Jane'::VARCHAR(50), 'Doe'::VARCHAR(50), 'Engineer'::VARCHAR(50), 'Employee'::VARCHAR(50))$$
       ,'Should return employee contact info'
    );

    -- Test 2: vendor contact
    SELECT results_eq(
        $$SELECT first_name, last_name, job_title, business_entity_type
          FROM common.get_contact_information(503)$$
       ,$$VALUES ('Bob'::VARCHAR(50), 'Smith'::VARCHAR(50), 'Sales Agent'::VARCHAR(50), 'Vendor Contact'::VARCHAR(50))$$
       ,'Should return vendor contact info'
    );

    -- Test 3: store contact
    SELECT results_eq(
        $$SELECT first_name, last_name, job_title, business_entity_type
          FROM common.get_contact_information(505)$$
       ,$$VALUES ('Alice'::VARCHAR(50), 'Jones'::VARCHAR(50), 'Owner'::VARCHAR(50), 'Store Contact'::VARCHAR(50))$$
       ,'Should return store contact info'
    );

    -- Test 4: consumer
    SELECT results_eq(
        $$SELECT first_name, last_name, business_entity_type
          FROM common.get_contact_information(506)$$
       ,$$VALUES ('Charlie'::VARCHAR(50), 'Brown'::VARCHAR(50), 'Consumer'::VARCHAR(50))$$
       ,'Should return consumer contact info'
    );

    SELECT * FROM finish();
ROLLBACK;
