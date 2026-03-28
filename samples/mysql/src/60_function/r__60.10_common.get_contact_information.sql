CREATE FUNCTION common.get_contact_information (
    v_person_id INT
)
RETURNS VARCHAR(200)
READS SQL DATA
BEGIN
    DECLARE v_result VARCHAR(200) DEFAULT NULL;
    IF v_person_id IS NOT NULL THEN
        IF EXISTS (
            SELECT 1
            FROM   human_resources.employee AS e
            WHERE  e.business_entity_id = v_person_id
        ) THEN
            SELECT CONCAT(p.first_name, ' ', p.last_name, ' - ', e.job_title, ' (Employee)')
            INTO   v_result
            FROM   human_resources.employee AS e
            JOIN   person.person AS p
               ON  p.business_entity_id = e.business_entity_id
            WHERE  e.business_entity_id = v_person_id;
            RETURN v_result;
        END IF;
        IF EXISTS (
            SELECT 1
            FROM   purchasing.vendor AS v
            JOIN   person.business_entity_contact AS bec
               ON  bec.business_entity_id = v.business_entity_id
            WHERE  bec.person_id = v_person_id
        ) THEN
            SELECT CONCAT(p.first_name, ' ', p.last_name, ' - ', ct.name, ' (Vendor Contact)')
            INTO   v_result
            FROM   purchasing.vendor AS v
            JOIN   person.business_entity_contact AS bec
               ON  bec.business_entity_id = v.business_entity_id
            JOIN   person.contact_type AS ct
               ON  ct.contact_type_id = bec.contact_type_id
            JOIN   person.person AS p
               ON  p.business_entity_id = bec.person_id
            WHERE  bec.person_id = v_person_id;
            RETURN v_result;
        END IF;
        IF EXISTS (
            SELECT 1
            FROM   sales.store AS s
            JOIN   person.business_entity_contact AS bec
               ON  bec.business_entity_id = s.business_entity_id
            WHERE  bec.person_id = v_person_id
        ) THEN
            SELECT CONCAT(p.first_name, ' ', p.last_name, ' - ', ct.name, ' (Store Contact)')
            INTO   v_result
            FROM   sales.store AS s
            JOIN   person.business_entity_contact AS bec
               ON  bec.business_entity_id = s.business_entity_id
            JOIN   person.contact_type AS ct
               ON  ct.contact_type_id = bec.contact_type_id
            JOIN   person.person AS p
               ON  p.business_entity_id = bec.person_id
            WHERE  bec.person_id = v_person_id;
            RETURN v_result;
        END IF;
        IF EXISTS (
            SELECT 1
            FROM   person.person AS p
            JOIN   sales.customer AS c
               ON  c.person_id = p.business_entity_id
            WHERE  p.business_entity_id = v_person_id
               AND c.store_id IS NULL
        ) THEN
            SELECT CONCAT(p.first_name, ' ', p.last_name, ' (Consumer)')
            INTO   v_result
            FROM   person.person AS p
            JOIN   sales.customer AS c
               ON  c.person_id = p.business_entity_id
            WHERE  p.business_entity_id = v_person_id
               AND c.store_id IS NULL;
            RETURN v_result;
        END IF;
    END IF;
    RETURN v_result;
END;
