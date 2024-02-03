DO $$
BEGIN
    IF NOT EXISTS (SELECT
                   FROM    information_schema.table_constraints AS tc
                   WHERE   tc.table_schema = 'sales'
                           AND tc.table_name = 'person_credit_card'
                           AND tc.constraint_name = 'pk_person_credit_card'
                           AND tc.constraint_type = 'PRIMARY KEY')
    THEN
        ALTER TABLE sales.person_credit_card
        ADD CONSTRAINT "pk_person_credit_card"
        PRIMARY KEY (business_entity_id, credit_card_id);
    END IF;
END$$
