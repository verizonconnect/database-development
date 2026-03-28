USE tap;
BEGIN;
SELECT tap.plan(3);

-- assemble: employee
INSERT INTO person.business_entity (business_entity_id) VALUES (903);
INSERT INTO person.person (business_entity_id, person_type, first_name, last_name)
VALUES (903, 'EM', 'Jane', 'Doe');

INSERT INTO human_resources.employee (
    business_entity_id, national_id_number, login_id, job_title
   ,birth_date, marital_status, gender, hire_date
) VALUES (903, 'NI903', 'jane@test.ie', 'Engineer', '1990-01-01', 'S', 'F', '2020-01-01');

-- act: call function into variable (avoids nested SELECT restriction)
SET @result_employee = common.get_contact_information(903);
SET @result_missing = common.get_contact_information(-1);
SET @result_null = common.get_contact_information(NULL);

-- assert
SELECT tap.ok(@result_employee = 'Jane Doe - Engineer (Employee)', 'get_contact_information should return employee info');
SELECT tap.ok(@result_missing IS NULL, 'get_contact_information should return NULL for non-existent person');
SELECT tap.ok(@result_null IS NULL, 'get_contact_information should return NULL for NULL input');

CALL tap.finish();
ROLLBACK;
