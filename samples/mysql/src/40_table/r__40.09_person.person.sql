CREATE TABLE IF NOT EXISTS person.person(
    business_entity_id INT NOT NULL COMMENT 'Primary key for person records.'
   ,person_type char(2) NOT NULL COMMENT 'Primary type of person: SC = store contact, IN = individual (retail) customer, SP = sales person, EM = employee (non-sales_), VC = vendor contact, GC = general contact'
   ,name_style BOOLEAN NOT NULL DEFAULT (false) COMMENT '0 = the data in first_name and last_name are stored in western style (first name, last name) order.  1 = eastern style (last name, first name) order.'
   ,title VARCHAR(8) NULL COMMENT 'A courtesy title. for example, mr. or ms.'
   ,first_name VARCHAR(50) NOT NULL COMMENT 'First name of the person.'
   ,middle_name VARCHAR(50) NULL COMMENT 'Middle name or middle initial of the person.'
   ,last_name VARCHAR(50) NOT NULL COMMENT 'Last name of the person.'
   ,suffix VARCHAR(10) NULL COMMENT 'Surname suffix. for example, sr. or jr.'
   ,email_promotion INT NOT NULL DEFAULT (0) COMMENT '0 = contact does not wish to receive e-mail promotions, 1 = contact does wish to receive e-mail promotions from adventure_works, 2 = contact does wish to receive e-mail promotions from adventure_works and selected partners.'
   ,additional_contact_info TEXT NULL COMMENT 'Additional contact information about the person stored in xml format.'
   ,demographics TEXT NULL COMMENT 'personal information such as hobbies, and income collected from online shoppers. used for sales analysis.'
   ,rowguid CHAR(36) NOT NULL DEFAULT (UUID())
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_person` PRIMARY KEY (business_entity_id)
)
COMMENT 'Human beings involved with adventure_works: employees, customer contacts, and vendor contacts.';
