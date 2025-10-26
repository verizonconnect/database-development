USE tap;
BEGIN;
CALL tap.plan(4);

-- ***************************************************************
-- TABLE human_resources.department
-- ***************************************************************
SELECT tap.has_table('human_resources','department','');
SELECT tap.table_collation_is('human_resources','department','utf8mb3_general_ci','');
SELECT tap.table_engine_is('human_resources','department','InnoDB','');

-- COLUMNS
SELECT tap.columns_are('human_resources','department','`department_id`,`department_name`,`group_name`,`modified_utc_when`,`created_utc_when`','');

CALL tap.finish();
ROLLBACK;

