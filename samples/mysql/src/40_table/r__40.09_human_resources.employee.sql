CREATE TABLE IF NOT EXISTS human_resources.employee(
    business_entity_id     INT NOT NULL
        COMMENT 'Primary key for employee records.  foreign key to business_entity.business_entity_id.',
    national_id_number     VARCHAR(15) NOT NULL
        COMMENT 'Unique national identification number such as a social security number.',
    login_id               VARCHAR(256) NOT NULL
        COMMENT 'Network login.',
    organization_node_desc VARCHAR(255) NULL DEFAULT ('/')
        COMMENT 'Where the employee is located in corporate hierarchy.',
    job_title_desc         VARCHAR(50) NOT NULL
        COMMENT 'Work title such as buyer or sales representative.',
    birth_date             DATE NOT NULL
        COMMENT 'Date of birth.',
    marital_status         CHAR(1) NOT NULL
        COMMENT 'M = married, S = single.',
    gender_code            CHAR(1) NOT NULL
        COMMENT 'M = male, F = female.',
    hire_date              DATE NOT NULL
        COMMENT 'employee hired on this date.',
    salaried_flag          BOOLEAN NOT NULL DEFAULT TRUE
        COMMENT 'Job classification. 0 = hourly, not exempt from collective bargaining. 1 = salaried, exempt from collective bargaining.',
    holiday_hour_total     SMALLINT NOT NULL DEFAULT 0
        COMMENT 'Number of available vacation hours.',
    sick_leave_hour_total  SMALLINT NOT NULL DEFAULT 0
        COMMENT 'Number of available sick leave hours.',
    current_flag           BOOLEAN NOT NULL DEFAULT TRUE
        COMMENT '0 = inactive, 1 = active.',
    row_guid_id            VARCHAR(36) NOT NULL
        COMMENT 'ROWGUIDCOL number uniquely identifying the record. Used to support a merge replication sample.',
   ,modified_utc_when      TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP 
        COMMENT 'Date and time the record was last updated.'
   ,created_utc_when       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        COMMENT 'Date and time the record was created.'
) COMMENT 'Employee information such as salary, department, and title.';