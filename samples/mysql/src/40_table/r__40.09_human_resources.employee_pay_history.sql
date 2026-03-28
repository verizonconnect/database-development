CREATE TABLE IF NOT EXISTS human_resources.employee_pay_history(
    business_entity_id INT NOT NULL COMMENT 'employee identification number. foreign key to employee.business_entity_id.'
   ,rate_change_date DATETIME NOT NULL COMMENT 'Date the change in pay is effective'
   ,rate DECIMAL(19,4) NOT NULL COMMENT 'Salary hourly rate.'
   ,pay_frequency SMALLINT NOT NULL COMMENT '1 = salary received monthly, 2 = salary received biweekly'
   ,modified_date DATETIME NOT NULL DEFAULT (UTC_TIMESTAMP())
   ,CONSTRAINT `pk_employee_pay_history` PRIMARY KEY (business_entity_id, rate_change_date)
)
COMMENT 'employee pay history.';
