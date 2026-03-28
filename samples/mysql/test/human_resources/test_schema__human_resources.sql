USE tap;
BEGIN;
SELECT tap.plan(18);

-- human_resources.department
SELECT tap.has_table('human_resources','department','');
SELECT tap.table_engine_is('human_resources','department','InnoDB','');
SELECT tap.columns_are('human_resources','department','`department_id`,`name`,`group_name`,`modified_date`','');

-- human_resources.employee
SELECT tap.has_table('human_resources','employee','');
SELECT tap.table_engine_is('human_resources','employee','InnoDB','');
SELECT tap.columns_are('human_resources','employee','`business_entity_id`,`national_id_number`,`login_id`,`organization_node`,`job_title`,`birth_date`,`marital_status`,`gender`,`hire_date`,`salaried_flag`,`holiday_hours`,`sick_leave_hours`,`current_flag`,`rowguid`,`modified_date`','');

-- human_resources.employee_department_history
SELECT tap.has_table('human_resources','employee_department_history','');
SELECT tap.table_engine_is('human_resources','employee_department_history','InnoDB','');
SELECT tap.columns_are('human_resources','employee_department_history','`business_entity_id`,`department_id`,`shift_id`,`start_date`,`end_date`,`modified_date`','');

-- human_resources.employee_pay_history
SELECT tap.has_table('human_resources','employee_pay_history','');
SELECT tap.table_engine_is('human_resources','employee_pay_history','InnoDB','');
SELECT tap.columns_are('human_resources','employee_pay_history','`business_entity_id`,`rate_change_date`,`rate`,`pay_frequency`,`modified_date`','');

-- human_resources.job_candidate
SELECT tap.has_table('human_resources','job_candidate','');
SELECT tap.table_engine_is('human_resources','job_candidate','InnoDB','');
SELECT tap.columns_are('human_resources','job_candidate','`job_candidate_id`,`business_entity_id`,`cv`,`modified_date`','');

-- human_resources.shift
SELECT tap.has_table('human_resources','shift','');
SELECT tap.table_engine_is('human_resources','shift','InnoDB','');
SELECT tap.columns_are('human_resources','shift','`shift_id`,`name`,`start_time`,`end_time`,`modified_date`','');

CALL tap.finish();
ROLLBACK;
