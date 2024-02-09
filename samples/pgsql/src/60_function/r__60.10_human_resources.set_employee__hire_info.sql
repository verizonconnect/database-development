CREATE OR REPLACE FUNCTION human_resources.set_employee__hire_info (
    IN v_business_entity_id INT
   ,IN v_job_title VARCHAR(50)
   ,IN v_hire_date DATE
   ,IN v_rate_change_date TIMESTAMP
   ,IN v_rate NUMERIC
   ,IN v_pay_frequency SMALLINT
   ,IN v_current_flag common.flag
   )
RETURNS void AS
$$
DECLARE

BEGIN
    UPDATE  human_resources.employee 
    SET     job_title = v_job_title 
           ,hire_date = v_hire_date 
           ,current_flag = v_current_flag 
    WHERE   business_entity_id = v_business_entity_id;

    INSERT INTO human_resources.employee_pay_history (
        business_entity_id
       ,rate_change_date
       ,rate
       ,pay_frequency
    ) 
    VALUES (
        v_business_entity_id
       ,v_rate_change_date
       ,v_rate
       ,v_pay_frequency
    );
END;
$$ LANGUAGE plpgsql
    SECURITY DEFINER;

COMMENT ON FUNCTION human_resources.set_employee__hire_info(INT, VARCHAR(50), DATE, TIMESTAMP, NUMERIC, SMALLINT, common.flag) IS 'Set new hire initial rate of pay';