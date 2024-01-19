CREATE TABLE IF NOT EXISTS person.person(
    business_entity_id INT NOT NULL
   ,person_type char(2) NOT NULL
   ,name_style common.name_style NOT NULL DEFAULT (false)
   ,title VARCHAR(8) NULL
   ,first_name common.name NOT NULL
   ,middle_name common.name NULL
   ,last_name common.name NOT NULL
   ,suffix VARCHAR(10) NULL
   ,email_promotion INT NOT NULL DEFAULT (0)
   ,additional_contact_info XML NULL 
   ,demographics XML NULL
   ,rowguid uuid NOT NULL CONSTRAINT "df_person_rowguid" DEFAULT (common.uuid_generate_v1())
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);

COMMENT ON TABLE person.person IS 'Human beings involved with adventure_works: employees, customer contacts, and vendor contacts.';
COMMENT ON COLUMN person.person.business_entity_id IS 'Primary key for person records.';
COMMENT ON COLUMN person.person.person_type IS 'Primary type of person: SC = store contact, IN = individual (retail) customer, SP = sales person, EM = employee (non-sales_), VC = vendor contact, GC = general contact';
COMMENT ON COLUMN person.person.name_style IS '0 = the data in first_name and last_name are stored in western style (first name, last name) order.  1 = eastern style (last name, first name) order.';
COMMENT ON COLUMN person.person.title IS 'A courtesy title. for example, mr. or ms.';
COMMENT ON COLUMN person.person.first_name IS 'First name of the person.';
COMMENT ON COLUMN person.person.middle_name IS 'Middle name or middle initial of the person.';
COMMENT ON COLUMN person.person.last_name IS 'Last name of the person.';
COMMENT ON COLUMN person.person.suffix IS 'Surname suffix. for example, sr. or jr.';
COMMENT ON COLUMN person.person.email_promotion IS '0 = contact does not wish to receive e-mail promotions, 1 = contact does wish to receive e-mail promotions from adventure_works, 2 = contact does wish to receive e-mail promotions from adventure_works and selected partners.';
COMMENT ON COLUMN person.person.demographics IS 'personal information such as hobbies, and income collected from online shoppers. used for sales analysis.';
COMMENT ON COLUMN person.person.additional_contact_info IS 'Additional contact information about the person stored in xml format.';