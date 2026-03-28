SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
    SELECT plan(7);

    SELECT is(
        common.get_sales_order_status_text(1::SMALLINT)
       ,'In process'::VARCHAR(15)
       ,'Status 1 should return In process'
    );

    SELECT is(
        common.get_sales_order_status_text(2::SMALLINT)
       ,'Approved'::VARCHAR(15)
       ,'Status 2 should return Approved'
    );

    SELECT is(
        common.get_sales_order_status_text(3::SMALLINT)
       ,'Backordered'::VARCHAR(15)
       ,'Status 3 should return Backordered'
    );

    SELECT is(
        common.get_sales_order_status_text(4::SMALLINT)
       ,'Rejected'::VARCHAR(15)
       ,'Status 4 should return Rejected'
    );

    SELECT is(
        common.get_sales_order_status_text(5::SMALLINT)
       ,'Shipped'::VARCHAR(15)
       ,'Status 5 should return Shipped'
    );

    SELECT is(
        common.get_sales_order_status_text(6::SMALLINT)
       ,'Cancelled'::VARCHAR(15)
       ,'Status 6 should return Cancelled'
    );

    SELECT is(
        common.get_sales_order_status_text(99::SMALLINT)
       ,'** Invalid **'::VARCHAR(15)
       ,'Invalid status should return ** Invalid **'
    );

    SELECT * FROM finish();
ROLLBACK;
