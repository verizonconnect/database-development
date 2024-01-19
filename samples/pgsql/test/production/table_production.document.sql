SET client_encoding = 'UTF-8';
SET client_min_messages = warning;
CREATE EXTENSION IF NOT EXISTS pgtap;
RESET client_min_messages;

BEGIN;
SELECT plan(60);

SELECT has_table(
    'production', 'document',
    'Should have table production.document'
);

SELECT hasnt_pk(
    'production', 'document',
    'Table production.document should have a primary key'
);

SELECT columns_are('production'::name, 'document'::name, ARRAY[
    'document_node'::name,
    'title'::name,
    'owner'::name,
    'folder_flag'::name,
    'file_name'::name,
    'file_extension'::name,
    'revision'::name,
    'change_number'::name,
    'status'::name,
    'document_summary'::name,
    'document'::name,
    'rowguid'::name,
    'modified_date'::name
]);

SELECT has_column(       'production', 'document', 'document_node', 'Column production.document.document_node should exist');
SELECT col_type_is(      'production', 'document', 'document_node', 'character varying', 'Column production.document.document_node should be type character varying');
SELECT col_not_null(     'production', 'document', 'document_node', 'Column production.document.document_node should be NOT NULL');
SELECT col_has_default(  'production', 'document', 'document_node', 'Column production.document.document_node should have a default');
SELECT col_default_is(   'production', 'document', 'document_node', '/'::character varying, 'Column production.document.document_node default is');

SELECT has_column(       'production', 'document', 'title', 'Column production.document.title should exist');
SELECT col_type_is(      'production', 'document', 'title', 'character varying(50)', 'Column production.document.title should be type character varying(50)');
SELECT col_not_null(     'production', 'document', 'title', 'Column production.document.title should be NOT NULL');
SELECT col_hasnt_default('production', 'document', 'title', 'Column production.document.title should not have a default');

SELECT has_column(       'production', 'document', 'owner', 'Column production.document.owner should exist');
SELECT col_type_is(      'production', 'document', 'owner', 'integer', 'Column production.document.owner should be type integer');
SELECT col_not_null(     'production', 'document', 'owner', 'Column production.document.owner should be NOT NULL');
SELECT col_hasnt_default('production', 'document', 'owner', 'Column production.document.owner should not have a default');

SELECT has_column(       'production', 'document', 'folder_flag', 'Column production.document.folder_flag should exist');
SELECT col_type_is(      'production', 'document', 'folder_flag', 'common.flag', 'Column production.document.folder_flag should be type common.flag');
SELECT col_not_null(     'production', 'document', 'folder_flag', 'Column production.document.folder_flag should be NOT NULL');
SELECT col_has_default(  'production', 'document', 'folder_flag', 'Column production.document.folder_flag should have a default');
SELECT col_default_is(   'production', 'document', 'folder_flag', 'false', 'Column production.document.folder_flag default is');

SELECT has_column(       'production', 'document', 'file_name', 'Column production.document.file_name should exist');
SELECT col_type_is(      'production', 'document', 'file_name', 'character varying(400)', 'Column production.document.file_name should be type character varying(400)');
SELECT col_not_null(     'production', 'document', 'file_name', 'Column production.document.file_name should be NOT NULL');
SELECT col_hasnt_default('production', 'document', 'file_name', 'Column production.document.file_name should not have a default');

SELECT has_column(       'production', 'document', 'file_extension', 'Column production.document.file_extension should exist');
SELECT col_type_is(      'production', 'document', 'file_extension', 'character varying(8)', 'Column production.document.file_extension should be type character varying(8)');
SELECT col_is_null(      'production', 'document', 'file_extension', 'Column production.document.file_extension should allow NULL');
SELECT col_hasnt_default('production', 'document', 'file_extension', 'Column production.document.file_extension should not have a default');

SELECT has_column(       'production', 'document', 'revision', 'Column production.document.revision should exist');
SELECT col_type_is(      'production', 'document', 'revision', 'character(5)', 'Column production.document.revision should be type character(5)');
SELECT col_not_null(     'production', 'document', 'revision', 'Column production.document.revision should be NOT NULL');
SELECT col_hasnt_default('production', 'document', 'revision', 'Column production.document.revision should not have a default');

SELECT has_column(       'production', 'document', 'change_number', 'Column production.document.change_number should exist');
SELECT col_type_is(      'production', 'document', 'change_number', 'integer', 'Column production.document.change_number should be type integer');
SELECT col_not_null(     'production', 'document', 'change_number', 'Column production.document.change_number should be NOT NULL');
SELECT col_has_default(  'production', 'document', 'change_number', 'Column production.document.change_number should have a default');
SELECT col_default_is(   'production', 'document', 'change_number', '0', 'Column production.document.change_number default is');

SELECT has_column(       'production', 'document', 'status', 'Column production.document.status should exist');
SELECT col_type_is(      'production', 'document', 'status', 'smallint', 'Column production.document.status should be type smallint');
SELECT col_not_null(     'production', 'document', 'status', 'Column production.document.status should be NOT NULL');
SELECT col_hasnt_default('production', 'document', 'status', 'Column production.document.status should not have a default');

SELECT has_column(       'production', 'document', 'document_summary', 'Column production.document.document_summary should exist');
SELECT col_type_is(      'production', 'document', 'document_summary', 'text', 'Column production.document.document_summary should be type text');
SELECT col_is_null(      'production', 'document', 'document_summary', 'Column production.document.document_summary should allow NULL');
SELECT col_hasnt_default('production', 'document', 'document_summary', 'Column production.document.document_summary should not have a default');

SELECT has_column(       'production', 'document', 'document', 'Column production.document.document should exist');
SELECT col_type_is(      'production', 'document', 'document', 'bytea', 'Column production.document.document should be type bytea');
SELECT col_is_null(      'production', 'document', 'document', 'Column production.document.document should allow NULL');
SELECT col_hasnt_default('production', 'document', 'document', 'Column production.document.document should not have a default');

SELECT has_column(       'production', 'document', 'rowguid', 'Column production.document.rowguid should exist');
SELECT col_type_is(      'production', 'document', 'rowguid', 'uuid', 'Column production.document.rowguid should be type uuid');
SELECT col_not_null(     'production', 'document', 'rowguid', 'Column production.document.rowguid should be NOT NULL');
SELECT col_has_default(  'production', 'document', 'rowguid', 'Column production.document.rowguid should have a default');
SELECT col_default_is(   'production', 'document', 'rowguid', 'common.uuid_generate_v1()', 'Column production.document.rowguid default is');

SELECT has_column(       'production', 'document', 'modified_date', 'Column production.document.modified_date should exist');
SELECT col_type_is(      'production', 'document', 'modified_date', 'timestamp without time zone', 'Column production.document.modified_date should be type timestamp without time zone');
SELECT col_not_null(     'production', 'document', 'modified_date', 'Column production.document.modified_date should be NOT NULL');
SELECT col_has_default(  'production', 'document', 'modified_date', 'Column production.document.modified_date should have a default');
SELECT col_default_is(   'production', 'document', 'modified_date', 'timezone(''utc''::text, now())', 'Column production.document.modified_date default is');

SELECT * FROM finish();
ROLLBACK;
