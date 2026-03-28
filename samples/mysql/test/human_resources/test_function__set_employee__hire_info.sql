USE tap;
BEGIN;
SELECT tap.plan(6);

-- assemble
INSERT INTO person.business_entity (business_entity_id) VALUES (901);
INSERT INTO person.person (business_entity_id, person_type, first_name, last_name)
VALUES (901, 'EM', 'Test', 'Employee');

INSERT INTO human_resources.employee (
    business_entity_id, national_id_number, login_id, job_title
   ,birth_date, marital_status, gender, hire_date
) VALUES (
    901, 'NI901', 'test@test.ie', 'Old Title'
   ,'1990-01-01', 'S', 'M', '2020-01-01'
);

-- act
CALL human_resources.set_employee__hire_info(
    901, 'New Title', '2025-01-15', '2025-01-15 09:00:00', 55.00, 2, TRUE
);

-- read results into variables
SELECT job_title, hire_date, current_flag INTO @jt, @hd, @cf
FROM human_resources.employee WHERE business_entity_id = 901;

SELECT COUNT(*) INTO @ph_count
FROM human_resources.employee_pay_history WHERE business_entity_id = 901;

SELECT rate, pay_frequency INTO @ph_rate, @ph_freq
FROM human_resources.employee_pay_history WHERE business_entity_id = 901 LIMIT 1;

-- assert
SELECT tap.ok(@jt = 'New Title', 'set_employee__hire_info should update job_title');
SELECT tap.ok(@hd = '2025-01-15', 'set_employee__hire_info should update hire_date');
SELECT tap.ok(@cf = TRUE, 'set_employee__hire_info should update current_flag');
SELECT tap.ok(@ph_count = 1, 'set_employee__hire_info should insert one pay history row');
SELECT tap.ok(@ph_rate = 55.00, 'set_employee__hire_info should insert correct rate');
SELECT tap.ok(@ph_freq = 2, 'set_employee__hire_info should insert correct pay_frequency');

CALL tap.finish();
ROLLBACK;
