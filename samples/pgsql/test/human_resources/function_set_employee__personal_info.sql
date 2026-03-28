SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
    SELECT plan(1);

    -- assemble phase
    \set v_business_entity_id  14::int

    INSERT INTO person.business_entity (business_entity_id)
    VALUES (:v_business_entity_id);

    INSERT INTO person.person (business_entity_id, person_type, first_name, last_name)
    VALUES (:v_business_entity_id, 'EM', 'first', 'last');

    INSERT INTO human_resources.employee (
        business_entity_id, national_id_number, login_id, job_title
       ,birth_date, marital_status, gender, hire_date
    ) VALUES (
        :v_business_entity_id, 'NI5678', 'login2@test.ie', 'qa role'
       ,'2000-01-01', 'S', 'M', '2024-01-01'
    );

    -- act phase
    SELECT * FROM human_resources.set_employee__personal_info(
        :v_business_entity_id
       ,'NI9999'::VARCHAR(15)
       ,'1995-06-15'::DATE
       ,'M'::CHAR(1)
       ,'F'::CHAR(1)
    );

    -- assert phase
    PREPARE expected AS
    SELECT  'NI9999'::VARCHAR(15)
           ,'1995-06-15'::DATE
           ,'M'::CHAR(1)
           ,'F'::CHAR(1);

    PREPARE actual AS
    SELECT  national_id_number
           ,birth_date
           ,marital_status
           ,gender
    FROM    human_resources.employee
    WHERE   business_entity_id = :v_business_entity_id;

    SELECT results_eq(
        'actual'
       ,'expected'
       ,'Employee personal info should be updated'
    );

    SELECT * FROM finish();
ROLLBACK;

DEALLOCATE actual;
DEALLOCATE expected;
