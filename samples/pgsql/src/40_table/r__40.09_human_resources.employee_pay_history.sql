CREATE TABLE IF NOT EXISTS human_resources.employee_pay_history(
    business_entity_id INT NOT NULL
   ,rate_change_date TIMESTAMP NOT NULL
   ,rate NUMERIC NOT NULL
   ,pay_frequency SMALLINT NOT NULL
   ,modified_date TIMESTAMP NOT NULL DEFAULT (NOW() AT TIME ZONE 'utc')
);

COMMENT ON TABLE human_resources.employee_pay_history IS 'employee pay history.';
COMMENT ON COLUMN human_resources.employee_pay_history.business_entity_id IS 'employee identification number. foreign key to employee.business_entity_id.';
COMMENT ON COLUMN human_resources.employee_pay_history.rate_change_date IS 'Date the change in pay is effective';
COMMENT ON COLUMN human_resources.employee_pay_history.rate IS 'Salary hourly rate.';
COMMENT ON COLUMN human_resources.employee_pay_history.pay_frequency IS '1 = salary received monthly, 2 = salary received biweekly';