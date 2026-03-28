SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
    SELECT plan(4);

    SELECT is(
        common.get_document_status_text(1::SMALLINT)
       ,'Pending approval'::VARCHAR(16)
       ,'Status 1 should return Pending approval'
    );

    SELECT is(
        common.get_document_status_text(2::SMALLINT)
       ,'Approved'::VARCHAR(16)
       ,'Status 2 should return Approved'
    );

    SELECT is(
        common.get_document_status_text(3::SMALLINT)
       ,'Obsolete'::VARCHAR(16)
       ,'Status 3 should return Obsolete'
    );

    SELECT is(
        common.get_document_status_text(99::SMALLINT)
       ,'** Invalid **'::VARCHAR(16)
       ,'Invalid status should return ** Invalid **'
    );

    SELECT * FROM finish();
ROLLBACK;
