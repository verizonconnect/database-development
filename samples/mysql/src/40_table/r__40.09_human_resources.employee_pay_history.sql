CREATE TABLE IF NOT EXISTS human_resources.employee_pay_history(
    business_entity_id INT NOT NULL
        COMMENT 'Employee identification number. foreign key to employee.business_entity_id.'
   ,rate_change_when   TIMESTAMP NOT NULL
        COMMENT 'Date the change in pay is effective.'
   ,rate_num           DECIMAL(19,4) NOT NULL
        COMMENT 'Salary hourly rate.'
   ,pay_frequency_code SMALLINT  NOT NULL
        COMMENT '1 = salary received monthly, 2 = salary received biweekly.',
   ,modified_utc_when  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
        COMMENT 'Date and time the record was last updated.'
   ,created_utc_when   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
        COMMENT 'Date and time the record was created.'
) COMMENT 'Employee pay history.';
