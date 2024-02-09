SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
    SELECT plan(2);

    -- assemble phase
    \set v_business_entity_id  13::int
    \set v_job_title '\'dev_role\''::varchar(50)
    \set v_hire_date '\'2023-01-01\''::date
    \set v_rate_change_date '\'2024-01-29 12:00:00\''::timestamp
    \set v_rate 13.17::numeric
    \set v_pay_frequency 2::smallint
    \set v_current_flag false::common.flag

    INSERT INTO person.business_entity (
        business_entity_id
    ) VALUES (
        :v_business_entity_id
    );

    INSERT INTO person.person(
        business_entity_id 
       ,person_type 
       ,first_name
       ,last_name
    ) VALUES (
        :v_business_entity_id
       ,'EM'
       ,'first'
       ,'last'
    );

    INSERT INTO human_resources.employee (
        business_entity_id
       ,national_id_number
       ,login_id
       ,job_title
       ,birth_date
       ,marital_status
       ,gender
       ,hire_date
    )
    VALUES (
        :v_business_entity_id
       ,'EI1234'
       ,'login@test.ie'
       ,'qa role'
       ,'2000-01-01'
       ,'S'
       ,'M'
       ,'2024-01-01'
    );

    -- act phase
    SELECT * FROM human_resources.set_employee__hire_info (
        :v_business_entity_id
       ,:v_job_title
       ,:v_hire_date
       ,:v_rate_change_date
       ,:v_rate
       ,:v_pay_frequency
       ,:v_current_flag
    );

    -- assert phase
    PREPARE expected_employee AS
    SELECT  :v_job_title::varchar(50)
           ,:v_hire_date::date
           ,:v_current_flag::common.flag;

    PREPARE actual_employee AS
    SELECT  job_title
           ,hire_date
           ,current_flag
    FROM    human_resources.employee
    WHERE   business_entity_id = :v_business_entity_id;

    PREPARE expected_employee_pay_history AS
    SELECT  :v_business_entity_id::int
           ,:v_rate_change_date::timestamp
           ,:v_rate::numeric
           ,:v_pay_frequency::smallint;

    PREPARE actual_employee_pay_history AS
    SELECT  business_entity_id
           ,rate_change_date
           ,rate
           ,pay_frequency
    FROM    human_resources.employee_pay_history
    WHERE   business_entity_id = :v_business_entity_id;
    
    SELECT results_eq(
        'actual_employee'
       ,'expected_employee'
       ,'The lists actual_employee and expected_employee should match');

    SELECT results_eq(
        'actual_employee_pay_history'
       ,'expected_employee_pay_history'
       ,'The lists actual_employee_pay_history and expected_employee_pay_history should match');

    SELECT * FROM finish();
ROLLBACK;

DEALLOCATE actual_employee;
DEALLOCATE expected_employee;
DEALLOCATE actual_employee_pay_history;
DEALLOCATE expected_employee_pay_history;