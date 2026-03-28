USE tap;
BEGIN;
SELECT tap.plan(39);

-- person.address
SELECT tap.has_table('person','address','');
SELECT tap.table_engine_is('person','address','InnoDB','');
SELECT tap.columns_are('person','address','`address_id`,`address_line_1`,`address_line_2`,`city`,`state_province_id`,`postal_code`,`spatial_location`,`rowguid`,`modified_date`','');

-- person.address_type
SELECT tap.has_table('person','address_type','');
SELECT tap.table_engine_is('person','address_type','InnoDB','');
SELECT tap.columns_are('person','address_type','`address_type_id`,`name`,`rowguid`,`modified_date`','');

-- person.business_entity
SELECT tap.has_table('person','business_entity','');
SELECT tap.table_engine_is('person','business_entity','InnoDB','');
SELECT tap.columns_are('person','business_entity','`business_entity_id`,`rowguid`,`modified_date`','');

-- person.business_entity_address
SELECT tap.has_table('person','business_entity_address','');
SELECT tap.table_engine_is('person','business_entity_address','InnoDB','');
SELECT tap.columns_are('person','business_entity_address','`business_entity_id`,`address_id`,`address_type_id`,`rowguid`,`modified_date`','');

-- person.business_entity_contact
SELECT tap.has_table('person','business_entity_contact','');
SELECT tap.table_engine_is('person','business_entity_contact','InnoDB','');
SELECT tap.columns_are('person','business_entity_contact','`business_entity_id`,`person_id`,`contact_type_id`,`rowguid`,`modified_date`','');

-- person.contact_type
SELECT tap.has_table('person','contact_type','');
SELECT tap.table_engine_is('person','contact_type','InnoDB','');
SELECT tap.columns_are('person','contact_type','`contact_type_id`,`name`,`modified_date`','');

-- person.country_region
SELECT tap.has_table('person','country_region','');
SELECT tap.table_engine_is('person','country_region','InnoDB','');
SELECT tap.columns_are('person','country_region','`country_region_code`,`name`,`modified_date`','');

-- person.email_address
SELECT tap.has_table('person','email_address','');
SELECT tap.table_engine_is('person','email_address','InnoDB','');
SELECT tap.columns_are('person','email_address','`business_entity_id`,`email_address_id`,`email_address`,`rowguid`,`modified_date`','');

-- person.password
SELECT tap.has_table('person','password','');
SELECT tap.table_engine_is('person','password','InnoDB','');
SELECT tap.columns_are('person','password','`business_entity_id`,`password_hash`,`password_salt`,`rowguid`,`modified_date`','');

-- person.person
SELECT tap.has_table('person','person','');
SELECT tap.table_engine_is('person','person','InnoDB','');
SELECT tap.columns_are('person','person','`business_entity_id`,`person_type`,`name_style`,`title`,`first_name`,`middle_name`,`last_name`,`suffix`,`email_promotion`,`additional_contact_info`,`demographics`,`rowguid`,`modified_date`','');

-- person.person_phone
SELECT tap.has_table('person','person_phone','');
SELECT tap.table_engine_is('person','person_phone','InnoDB','');
SELECT tap.columns_are('person','person_phone','`business_entity_id`,`phone_number`,`phone_number_type_id`,`modified_date`','');

-- person.phone_number_type
SELECT tap.has_table('person','phone_number_type','');
SELECT tap.table_engine_is('person','phone_number_type','InnoDB','');
SELECT tap.columns_are('person','phone_number_type','`phone_number_type_id`,`name`,`modified_date`','');

-- person.state_province
SELECT tap.has_table('person','state_province','');
SELECT tap.table_engine_is('person','state_province','InnoDB','');
SELECT tap.columns_are('person','state_province','`state_province_id`,`state_province_code`,`country_region_code`,`is_only_state_province_flag`,`name`,`territory_id`,`rowguid`,`modified_date`','');

CALL tap.finish();
ROLLBACK;
