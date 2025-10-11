CREATE TABLE IF NOT EXISTS human_resources.employee_pay_history(
    business_entity_id INT       NOT NULL COMMENT 'employee identification number. foreign key to employee.business_entity_id.'
   ,rate_change_date   TIMESTAMP NOT NULL COMMENT 'Date the change in pay is effective';
   ,rate               NUMERIC   NOT NULL COMMENT 'Salary hourly rate.'
   ,pay_frequency      SMALLINT  NOT NULL COMMENT '1 = salary received monthly, 2 = salary received biweekly'
   ,modified_date      TIMESTAMP NOT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT 'audit when row value modified.'
   ,created_date       TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT 'audit when row inserted.'
);
