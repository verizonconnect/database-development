SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
    SELECT plan(5);

    SELECT is(
        common.get_purchase_order_status_text(1::SMALLINT)
       ,'Pending'::VARCHAR(15)
       ,'Status 1 should return Pending'
    );

    SELECT is(
        common.get_purchase_order_status_text(2::SMALLINT)
       ,'Approved'::VARCHAR(15)
       ,'Status 2 should return Approved'
    );

    SELECT is(
        common.get_purchase_order_status_text(3::SMALLINT)
       ,'Rejected'::VARCHAR(15)
       ,'Status 3 should return Rejected'
    );

    SELECT is(
        common.get_purchase_order_status_text(4::SMALLINT)
       ,'Complete'::VARCHAR(15)
       ,'Status 4 should return Complete'
    );

    SELECT is(
        common.get_purchase_order_status_text(99::SMALLINT)
       ,'** Invalid **'::VARCHAR(15)
       ,'Invalid status should return ** Invalid **'
    );

    SELECT * FROM finish();
ROLLBACK;
