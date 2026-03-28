USE tap;
BEGIN;
SELECT tap.plan(4);

-- assemble
INSERT INTO person.business_entity (business_entity_id) VALUES (902);
INSERT INTO person.person (business_entity_id, person_type, first_name, last_name)
VALUES (902, 'EM', 'Test', 'Person');

INSERT INTO human_resources.employee (
    business_entity_id, national_id_number, login_id, job_title
   ,birth_date, marital_status, gender, hire_date
) VALUES (
    902, 'NI902', 'test2@test.ie', 'Role'
   ,'1990-01-01', 'S', 'M', '2020-01-01'
);

-- act
CALL human_resources.set_employee__personal_info(902, 'NI999', '1985-06-15', 'M', 'F');

-- read results into variables
SELECT national_id_number, birth_date, marital_status, gender INTO @nid, @bd, @ms, @gn
FROM human_resources.employee WHERE business_entity_id = 902;

-- assert
SELECT tap.ok(@nid = 'NI999', 'set_employee__personal_info should update national_id_number');
SELECT tap.ok(@bd = '1985-06-15', 'set_employee__personal_info should update birth_date');
SELECT tap.ok(@ms = 'M', 'set_employee__personal_info should update marital_status');
SELECT tap.ok(@gn = 'F', 'set_employee__personal_info should update gender');

CALL tap.finish();
ROLLBACK;
