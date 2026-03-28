SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
    SELECT plan(2);

    SELECT is(
        common.get_accounting_start_date()
       ,'2003-07-01'::TIMESTAMP
       ,'Accounting start date should be 2003-07-01'
    );

    SELECT is(
        common.get_accounting_end_date()
       ,'2004-06-30 23:59:59.998'::TIMESTAMP
       ,'Accounting end date should be 2004-06-30 23:59:59.998'
    );

    SELECT * FROM finish();
ROLLBACK;
