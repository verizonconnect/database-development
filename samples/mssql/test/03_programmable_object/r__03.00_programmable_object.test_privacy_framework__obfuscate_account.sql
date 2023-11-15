-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
CREATE OR ALTER PROCEDURE test_programmable_object.test_privacy_framework__obfuscate_account
AS
BEGIN

-- Copyright (c) 2022. Verizon Connect Ireland Limited. All rights reserved. 
if schema_id('test') is null
    exec ('create schema test')

if schema_id('privacy_framework_backup_test') is null
    exec ('create schema privacy_framework_backup_test')


CREATE TABLE test.table1
   ([accountid]                 INT  NOT NULL
   ,[userid]                 INT  NOT NULL
   ,[email_address]          VARCHAR(100)      NULL
   ,[phone_number]	   	   VARCHAR(100)       NULL
   ,[SSN]						INT NULL
   ,[col2]                 VARCHAR(max)       NULL
   ,[col2b]                VARCHAR(5)       NULL
   ,[col3]                 VARCHAR(100)       NULL
   ,[col4]                 VARCHAR(100)       NULL
   ,[col5]                 VARCHAR(100)       NULL
   ,[col6]                 VARCHAR(100)       NULL
   ,[col8]                 INT                NULL
   ,[col9]                 VARCHAR(100)       NULL
   ,[col10]                 VARCHAR(100)       NULL
   ,[col11]                 VARCHAR(100)       NULL
   ,[col13]                 VARCHAR(100)       NULL
   ,[modified_utc_when]					datetime NULL
   ,[obfuscated_ind]						bit NULL);

CREATE TABLE test.table2
   ([table2_id]             INT IDENTITY(1,1) NOT NULL
   ,[accountid]                 INT  NOT NULL
   ,[userid]                 INT  NOT NULL
   ,[address]		          VARCHAR(100)      NULL
   ,[modified_utc_when]					datetime NULL
   ,[obfuscated_ind]						bit NULL);

CREATE TABLE test.table3
   ([accountid]                 INT  NOT NULL
   ,[full_name]		          VARCHAR(100)      NULL
   ,[modified_utc_when]					datetime NULL
   ,[obfuscated_ind]						bit NULL);

--Insert the test data
INSERT INTO test.table1 (accountid, userid, email_address, phone_number, SSN, col2, col3, col4, col5, col6, col8, col9, col10, col11, col13) 
   values (1, 1, 'name1@email.com', '012345678', 11111, 'col2', 'col3', 'col4', 'col5', 'col6', 8, 'col9', 'col10', 'col11', 'col13'), 
          (1, 2, 'name2@email.com', '023456789', 22222, 'col2', 'col3', 'col4', 'col5', 'col6', 8, 'col9', 'col10', 'col11', 'col13');

INSERT INTO test.table2 (accountid, userid, address) values (1, 1, 'Big long address thing'), (1, 1, 'Another address for 1'), (1, 2, 'Address for 2');

INSERT INTO test.table3 (accountid, full_name) values (1, 'First Name'), (2, 'Another Name');


EXEC tsqlt.FakeTable @TableName = 'privacy_framework'
                   , @SchemaName = 'drp_type';
INSERT INTO privacy_framework.drp_type (drp_type_desc) VALUES ('TEST00');

EXEC tsqlt.FakeTable @TableName = 'privacy_framework'
                   , @SchemaName = 'subject_type';
INSERT INTO privacy_framework.subject_type(subject_type_id, subject_type_desc) VALUES (99, 'test_subject');

EXEC tsqlt.FakeTable @TableName = 'privacy_framework'
                   , @SchemaName = 'table_data_dictionary';
EXEC tsqlt.ApplyConstraint @TableName = 'privacy_framework.table_data_dictionary'
                          ,@ConstraintName = 'fk_table_data_dictionary__drp_type';
INSERT INTO privacy_framework.table_data_dictionary (sch_nm, tbl_nm, transactional_indicator, partitioned_indicator, drp_type_desc, business_justification_id)
	VALUES ('test', 'table1', 0, 0, 'TEST00', 1),
			('test', 'table2', 0, 0, 'TEST00', 1),
			('test', 'table3', 0, 0, 'TEST00', 1);

EXEC tsqlt.FakeTable @TableName = 'privacy_framework'
                   , @SchemaName = 'column_data_dictionary';
EXEC tsqlt.ApplyConstraint @TableName = 'privacy_framework.column_data_dictionary'
                          ,@ConstraintName = 'fk_column_data_dictionary__table_data_dictionary';
INSERT INTO privacy_framework.column_data_dictionary (sch_nm, tbl_nm, col_nm, pii_indicator, direct_pii_indicator, subject_data_type_id, subject_type_id)
	VALUES ('test', 'table1', 'accountid', 0, 0, NULL , NULL),
		   ('test', 'table1', 'userid', 0, 0, NULL , NULL),
		   ('test', 'table1', 'email_address', 1, 1, 5 , 99),
		   ('test', 'table1', 'phone_number', 1, 1, 7 , 99),
		   ('test', 'table1', 'ssn', 1, 1, 19 , 99),
		   ('test', 'table1', 'col2', 1, 1, 19 , 99),
		   ('test', 'table1', 'col2b', 1, 1, 19 , 99),
		   ('test', 'table1', 'col3', 1, 1, 19 , 99),
		   ('test', 'table1', 'col4', 1, 1, 19 , 99),
		   ('test', 'table1', 'col5', 1, 1, 19 , 99),
		   ('test', 'table1', 'col6', 1, 1, 19 , 99),
		   ('test', 'table1', 'col8', 1, 1, 19 , 99),
		   ('test', 'table1', 'col9', 1, 1, 19 , 99),
		   ('test', 'table1', 'col10', 1, 1, 19 , 99),
		   ('test', 'table1', 'col11', 1, 1, 19 , 99),
		   ('test', 'table1', 'col13', 1, 1, 19 , 99),
		   ('test', 'table2', 'accountid', 0, 0, NULL , NULL),
		   ('test', 'table2', 'userid', 0, 0, NULL , NULL),
		   ('test', 'table2', 'address', 1, 1, 2 , 99),
		   ('test', 'table3', 'accountid', 0, 0, NULL , NULL),
		   ('test', 'table3', 'full_name', 1, 1, 2 , 99);

EXEC tsqlt.FakeTable @TableName = 'privacy_framework'
                   , @SchemaName = 'table_configuration';
EXEC tsqlt.ApplyConstraint @TableName = 'privacy_framework.table_configuration'
                          ,@ConstraintName = 'fk_table_configuration__table_data_dictionary';
INSERT INTO privacy_framework.table_configuration (sch_nm, tbl_nm, account_id_column_name, batch_size, modified_utc_when_column_name, obfuscated_ind_column_name, subject_id_column_name)
VALUES ('test', 'table1', 'accountid', 1000, 'modified_utc_when', 'obfuscated_ind', 'userid'),
		('test', 'table2', 'accountid', 1000, 'modified_utc_when', 'obfuscated_ind', 'userid'),
		('test', 'table3', 'accountid', 1000, 'modified_utc_when', 'obfuscated_ind', NULL);

EXEC tsqlt.FakeTable @TableName = 'privacy_framework'
                   , @SchemaName = 'obfuscation_column_configuration';
EXEC tsqlt.ApplyConstraint @TableName = 'privacy_framework.obfuscation_column_configuration'
                          ,@ConstraintName = 'fk_obfuscation_column_configuration__table_configuration'; 
INSERT INTO privacy_framework.obfuscation_column_configuration (sch_nm, tbl_nm, col_nm, obfuscation_method_id, obfuscated_subject_level_indicator)
	VALUES ('test', 'table1', 'email_address', 1, 1),
		   ('test', 'table1', 'phone_number', 1, 0),
		   ('test', 'table1', 'ssn', 12, 1),
		   ('test', 'table1', 'col2', 2, 1),
		   ('test', 'table1', 'col2b', 2, 1),
		   ('test', 'table1', 'col3', 3, 1),
		   ('test', 'table1', 'col4', 4, 1),
		   ('test', 'table1', 'col5', 5, 1),
		   ('test', 'table1', 'col6', 6, 1),
		   ('test', 'table1', 'col8', 8, 1),
		   ('test', 'table1', 'col9', 9, 1),
		   ('test', 'table1', 'col10', 10, 1),
		   ('test', 'table1', 'col11', 11, 1),
		   ('test', 'table1', 'col13', 13, 1),
		   ('test', 'table2', 'address', 1, 1),
		   ('test', 'table3', 'full_name', 7, 0);

CREATE table #expected_resultset
(
	accountid                 INT  NOT NULL
   ,userid                 INT  NOT NULL
   ,email_address          VARCHAR(100)      NULL
   ,phone_number	   	   VARCHAR(100)       NULL
   ,SSN						INT NULL
   ,col2                 VARCHAR(max)       NULL
   ,col2b                VARCHAR(5)       NULL
   ,obfuscated_ind               BIT NULL
);

CREATE table #expected_resultset2
(
	accountid                 INT  NOT NULL
   ,userid                 INT  NOT NULL
   ,address		          VARCHAR(100)      NULL
   ,[obfuscated_ind]               BIT NULL
);

CREATE table #expected_resultset3
(
	accountid                 INT  NOT NULL
   ,full_name		          VARCHAR(100)      NULL
   ,[obfuscated_ind]               BIT NULL
);

--Check the existing schemas and tables
INSERT INTO #expected_resultset (accountid, userid, email_address, phone_number, SSN, col2, col2b, [obfuscated_ind])
SELECT 1, 2, 'Obfuscated', 'Obfuscated', NULL, 'REMOVED', 'REMOV', 1 UNION ALL
SELECT 1, 1, 'Obfuscated', 'Obfuscated', NULL, 'REMOVED', 'REMOV', 1;

INSERT INTO #expected_resultset2 (accountid, userid, address, [obfuscated_ind])
 SELECT 1, 2, 'Obfuscated', 1 UNION ALL
 SELECT 1, 1, 'Obfuscated', 1 UNION ALL
 SELECT 1, 1, 'Obfuscated', 1;

INSERT INTO #expected_resultset3 (accountid, full_name, [obfuscated_ind])
 SELECT 2, 'Another Name', NULL;

--Give the db_role_privacy_framework_aso role the needed access to the schema and backup schema
GRANT INSERT, UPDATE, SELECT, DELETE ON SCHEMA::test TO db_role_privacy_framework_aso;
GRANT ALTER, INSERT, UPDATE, SELECT, DELETE ON SCHEMA::privacy_framework_backup_test TO db_role_privacy_framework_aso;

--Run as a user with the db_role_privacy_framework_aso role
CREATE login user_privacy_framework_aso WITH PASSWORD = 'Pass1234';
CREATE USER user_privacy_framework_aso FOR LOGIN user_privacy_framework_aso;
ALTER ROLE db_role_privacy_framework_aso ADD MEMBER user_privacy_framework_aso;
EXECUTE AS LOGIN = 'user_privacy_framework_aso';

 --Run the obfuscation
EXEC privacy_framework.obfuscate_account @account_id = 1;

--Revert back to SA to complete the test
REVERT;

--Test the results match
EXEC tSQLt.AssertEqualsTable @Expected = N'#expected_resultset'
                            ,@Actual = N'test.table1'
                            ,@Message = N'The lists expected_resultset and test.table1 should match';

EXEC tSQLt.AssertEqualsTable @Expected = N'#expected_resultset2'
                            ,@Actual = N'test.table2'
                            ,@Message = N'The lists expected_resultset2 and test.table2 should match';

EXEC tSQLt.AssertEqualsTable @Expected = N'#expected_resultset3'
                            ,@Actual = N'test.table3'
                            ,@Message = N'The lists expected_resultset3 and test.table3 should match';

END;
GO