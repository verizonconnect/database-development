CREATE PROCEDURE human_resources.set_employee__personal_info (
    IN v_business_entity_id INT
   ,IN v_national_id_number VARCHAR(15)
   ,IN v_birth_date DATE
   ,IN v_marital_status CHAR(1)
   ,IN v_gender CHAR(1)
)
MODIFIES SQL DATA
BEGIN
    UPDATE human_resources.employee
    SET    national_id_number = v_national_id_number
          ,birth_date = v_birth_date
          ,marital_status = v_marital_status
          ,gender = v_gender
    WHERE  business_entity_id = v_business_entity_id;
END;
