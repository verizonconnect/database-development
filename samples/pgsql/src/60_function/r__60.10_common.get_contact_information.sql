CREATE OR REPLACE FUNCTION common.get_contact_information (
    IN v_person_id INT
   )
RETURNS TABLE (
    person_id INT
   ,first_name VARCHAR(50)
   ,last_name VARCHAR(50)
   ,job_title VARCHAR(50)
   ,business_entity_type VARCHAR(50)
   ) AS
$$
BEGIN
    IF v_person_id IS NOT NULL THEN

        IF EXISTS (
            SELECT  1
            FROM    human_resources.employee AS e
            WHERE   e.business_entity_id = v_person_id
        ) THEN
            RETURN QUERY
                SELECT  v_person_id
                       ,p.first_name::VARCHAR(50)
                       ,p.last_name::VARCHAR(50)
                       ,e.job_title
                       ,'Employee'::VARCHAR(50)
                FROM    human_resources.employee AS e
                JOIN    person.person AS p
                    ON  p.business_entity_id = e.business_entity_id
                WHERE   e.business_entity_id = v_person_id;
        END IF;

        IF EXISTS (
            SELECT  1
            FROM    purchasing.vendor AS v
            JOIN    person.business_entity_contact AS bec
                ON  bec.business_entity_id = v.business_entity_id
            WHERE   bec.person_id = v_person_id
        ) THEN
            RETURN QUERY
                SELECT  v_person_id
                       ,p.first_name::VARCHAR(50)
                       ,p.last_name::VARCHAR(50)
                       ,ct.name::VARCHAR(50)
                       ,'Vendor Contact'::VARCHAR(50)
                FROM    purchasing.vendor AS v
                JOIN    person.business_entity_contact AS bec
                    ON  bec.business_entity_id = v.business_entity_id
                JOIN    person.contact_type AS ct
                    ON  ct.contact_type_id = bec.contact_type_id
                JOIN    person.person AS p
                    ON  p.business_entity_id = bec.person_id
                WHERE   bec.person_id = v_person_id;
        END IF;

        IF EXISTS (
            SELECT  1
            FROM    sales.store AS s
            JOIN    person.business_entity_contact AS bec
                ON  bec.business_entity_id = s.business_entity_id
            WHERE   bec.person_id = v_person_id
        ) THEN
            RETURN QUERY
                SELECT  v_person_id
                       ,p.first_name::VARCHAR(50)
                       ,p.last_name::VARCHAR(50)
                       ,ct.name::VARCHAR(50)
                       ,'Store Contact'::VARCHAR(50)
                FROM    sales.store AS s
                JOIN    person.business_entity_contact AS bec
                    ON  bec.business_entity_id = s.business_entity_id
                JOIN    person.contact_type AS ct
                    ON  ct.contact_type_id = bec.contact_type_id
                JOIN    person.person AS p
                    ON  p.business_entity_id = bec.person_id
                WHERE   bec.person_id = v_person_id;
        END IF;

        IF EXISTS (
            SELECT  1
            FROM    person.person AS p
            JOIN    sales.customer AS c
                ON  c.person_id = p.business_entity_id
            WHERE   p.business_entity_id = v_person_id
                AND c.store_id IS NULL
        ) THEN
            RETURN QUERY
                SELECT  v_person_id
                       ,p.first_name::VARCHAR(50)
                       ,p.last_name::VARCHAR(50)
                       ,NULL::VARCHAR(50)
                       ,'Consumer'::VARCHAR(50)
                FROM    person.person AS p
                JOIN    sales.customer AS c
                    ON  c.person_id = p.business_entity_id
                WHERE   p.business_entity_id = v_person_id
                    AND c.store_id IS NULL;
        END IF;

    END IF;

    RETURN;
END;
$$ LANGUAGE plpgsql
    STABLE;

COMMENT ON FUNCTION common.get_contact_information(IN INT) IS 'Table function returning the first name, last name, job title and contact type for a given contact.';
